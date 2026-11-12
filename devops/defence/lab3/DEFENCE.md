# Захист лабораторної роботи №3

Технології DevOps. Розгортання власного застосунку в Kubernetes.

Проєкт: Relativa, гілка `devops/lab3`. Коміт бази той самий, що на `lab9`: `5b07227`. Файли роботи не закомічені. Кластер після журналу знову збігається з `k8s/`: образ `relativa-gateway:1.0.0`, дві репліки. Сирі виводи: `devops/lab3/evidence`. Коротший звіт з тими самими фактами: `devops/lab3/REPORT.md`.

## 1. Мета

Описати власний застосунок маніфестами Kubernetes, підняти його в локальному minikube і показати, що kubectl керує життєвим циклом: самовідновлення, масштаб, rolling update, відкат і розбір зламаного образу.

## 2. Що саме стоїть у кластері

Relativa — CRM з кількох сервісів. У цю роботу входить шлюз Gateway, той самий образ, що в `docker-compose.yaml` (`Gateway/Dockerfile`), і PostgreSQL 16. Auth, core, graph, ml, audit, клієнт, RabbitMQ і міграції не розгортались. `/health` і старт процесу шлюзу їх не потребують.

Gateway до цієї бази не підключається. PostgreSQL тут як компонент зі станом того самого проєкту: бланк просить PersistentVolumeClaim, якщо стан є. Том доводить, що рядок переживає видалення пода. Scale, rollout і відкат крутяться на Gateway, бо це той процес, у якого дві версії образу.

Тег `latest` не використовується. Образи `1.0.0` і `1.1.0` зібрані локально і завантажені в minikube командою `minikube image load`. Облікового запису Docker Hub немає. `imagePullPolicy: IfNotPresent`: наявний тег береться з вузла, відсутній тег kubelet намагається стягнути і отримує `ImagePullBackOff`, а не `ErrImageNeverPull`.

## 3. Середовище

Команди, якими машина доведена до роботи.

Docker Engine уже був, 29.8.0. kubectl уже був, клієнт 1.36.1. minikube не було:

```text
winget install -e --id Kubernetes.minikube --accept-package-agreements --accept-source-agreements
```

Після встановлення minikube 1.39.0 лежить у `C:\Program Files\Kubernetes\Minikube\minikube.exe`. Новий термінал підхоплює його в PATH. У тому самому вікні PATH треба зібрати з машинного і користувацького середовища, інакше оболонка, відкрита до install, команду не бачить.

Перший старт відхилено:

```text
minikube start --driver=docker --cpus=2 --memory=4096
```

Текст помилки: Docker Desktop has only 3841MB memory but you specified 4096MB. Робочий старт:

```text
minikube start --driver=docker --cpus=2 --memory=3072
```

Кластер: Kubernetes 1.37.0, один вузол `minikube`, роль control-plane, IP `192.168.49.2`, ОС Debian 12, containerd 2.3.4. Сервер 1.37 і клієнт kubectl 1.36 відрізняються на одну minor-версію. Політика skew kubectl це дозволяє, кластер через це не перестворювався.

```text
kubectl get nodes -o wide
kubectl get pods -n kube-system
minikube addons enable metrics-server
minikube addons enable ingress
```

У `kube-system` підняті etcd, kube-apiserver, kube-controller-manager, kube-scheduler, kube-proxy, coredns, kindnet, storage-provisioner і metrics-server. Ingress-контролер живе в namespace `ingress-nginx`, под `ingress-nginx-controller` у стані Running. `kubectl top nodes` і `kubectl top pods -n relativa` після прогріву metrics-server віддають числа, тож додаток не лише увімкнений, а й відповідає.

## 4. Образи

У runtime-стадії `Gateway/Dockerfile`, після копіювання publish:

```dockerfile
ARG APP_VERSION=1.0.0
ENV App__Version=$APP_VERSION
```

ARG стоїть у runtime-стадії, тому збірка `1.1.0` перевикористала restore і publish. Перевірка `docker image inspect`: в `1.0.0` змінна `App__Version=1.0.0`, в `1.1.0` — `App__Version=1.1.0`.

`/health` у `Gateway/src/Relativa.Gateway/Program.cs` лишився анонімним. Додано три поля, які процес уже може прочитати:

- `version` з `App:Version`. Змінна оточення `App__Version` у ASP.NET лягає в конфігурацію як `App:Version`.
- `pod` з `POD_NAME`.
- `appName` з `Relativa:AppName`, куди лягає `Relativa__AppName` з ConfigMap.

Секрет у JSON не потрапляє.

Збірка і завантаження, з кореня репозиторію, після старту кластера:

```text
docker build --build-arg APP_VERSION=1.0.0 -t relativa-gateway:1.0.0 -f Gateway/Dockerfile Gateway
docker build --build-arg APP_VERSION=1.1.0 -t relativa-gateway:1.1.0 -f Gateway/Dockerfile Gateway
minikube image load relativa-gateway:1.0.0
minikube image load relativa-gateway:1.1.0
```

`minikube image load` потрібен, бо демон Docker на хості і containerd у вузлі minikube — різні сховища. Образ, зібраний на хості, под не бачить, поки його не скопіювати. Postgres окремо не завантажувався: kubelet сам стягнув `postgres:16-alpine`.

У Deployment змінної `App__Version` немає навмисно. Якби її задати в маніфесті, вона перекрила б образ, і обидві версії відповідали б однаково.

## 5. Маніфести

Каталог `k8s/`, один об'єкт на файл, UTF-8, LF. Префікси `00`–`80` задають порядок `kubectl apply -f k8s/`: namespace створюється першим. Усі іменовані об'єкти, крім самого Namespace, мають `metadata.namespace: relativa`. Маніфести написані вручну, не через `kubectl create --dry-run -o yaml`.

Селектор шлюзу — лише `app: relativa-gateway`. Той самий label на шаблоні пода. Версії в селекторі немає: селектор після створення Deployment змінити не можна, і rolling update тоді не зміг би підмінити под.

`00-namespace.yaml`. Namespace `relativa`. Ізоляція імен: `kubectl get pods -n relativa` не змішує шлюз із `kube-system`.

`10-configmap.yaml`, ім'я `relativa-config`. Несекретні параметри:

| Ключ | Значення | Змінна в контейнері | Хто читає |
|---|---|---|---|
| `APP_NAME` | Relativa | `Relativa__AppName` | gateway, поле `appName` у `/health` |
| `LOG_LEVEL` | Information | `Relativa__LogLevel` | gateway |
| `JWT_ISSUER` | relativa-auth | `Jwt__Issuer` | gateway, перевірка видавця JWT |
| `JWT_AUDIENCE` | relativa | `Jwt__Audience` | gateway, перевірка аудиторії JWT |
| `DB_NAME` | relativa | `POSTGRES_DB` | postgres |
| `DB_USER` | relativa | `POSTGRES_USER` | postgres |

`20-secret.yaml`, ім'я `relativa-secret`, тип `Opaque`, блок `stringData`. Ключі `JWT_SECRET` і `POSTGRES_PASSWORD`. Значення синтетичні, лежать у файлі, це не паролі робочих систем. `JWT_SECRET` довший за 32 символи, бо `Program.cs` кладе його в `SymmetricSecurityKey`, і коротший ключ для HMAC-SHA256 не годиться. Рядок навмисно інший, ніж `SecretKey` у `Gateway/src/Relativa.Gateway/appsettings.json`. Так видно, що процес узяв Secret, а не файл з образу: змінні оточення в ASP.NET перекривають JSON.

`30-postgres-pvc.yaml`. Ім'я `postgres-data`, `ReadWriteOnce`, 1Gi. `storageClassName` не вказано, тож береться клас minikube `standard`. PVC став Bound на том `pvc-a2db748c-1ebe-4650-a149-95888a87cf18`.

`40-postgres-deployment.yaml`. Одна репліка, контейнер `postgres`, образ `postgres:16-alpine`, label `app: relativa-postgres`. Пароль з Secret, ім'я бази і користувач з ConfigMap. Том змонтовано в `/var/lib/postgresql/data`. Проби `exec`: `pg_isready -U relativa -d relativa`. Requests `cpu: 100m`, `memory: 256Mi`. Limits `cpu: 500m`, `memory: 512Mi`.

`50-postgres-service.yaml`. ClusterIP, порт 5432. З хоста базу не публікуємо. Доступ для перевірки — `kubectl exec`.

`60-gateway-deployment.yaml`. Ім'я `relativa-gateway`, контейнер саме `gateway` (це ім'я в `kubectl set image`), 2 репліки, образ `relativa-gateway:1.0.0`, порт 8080, `ASPNETCORE_URLS=http://+:8080`. Env з ConfigMap і Secret, як у таблиці вище, плюс:

```yaml
- name: POD_NAME
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
```

Readiness: `httpGet /health` порт 8080, `initialDelaySeconds: 5`, `periodSeconds: 5`. Liveness: той самий шлях, `initialDelaySeconds: 15`, `periodSeconds: 10`. Ті самі requests і limits, що в бази. Стратегія `RollingUpdate`, `maxUnavailable: 0`, `maxSurge: 1`. Під час оновлення старі поди лишаються, поки новий не пройде readiness, і одночасно може жити один додатковий под.

`70-gateway-service.yaml`. Тип NodePort, порт 8080, `nodePort: 30080`, селектор `app: relativa-gateway`. Всередині кластера адреса `relativa-gateway.relativa.svc:8080`. З вузла — `127.0.0.1:30080`.

`80-ingress.yaml`. Клас `nginx`, хост `relativa.local`, шлях `/` на сервіс `relativa-gateway:8080`. Rewrite немає, інакше `/health` переписався б. Додаток ingress увімкнений окремим пунктом бланка. На драйвері docker з Windows сам Ingress без `minikube tunnel` (а тунель часто хоче права адміністратора) не є зручним входом з браузера. Тому доступ з хоста зроблено NodePort і port-forward, а Ingress лишається об'єктом, який контролер прийняв: у describe є подія `Scheduled for sync`, адреса `192.168.49.2`.

Застосування:

```text
kubectl apply -f k8s/
kubectl rollout status deploy/relativa-postgres -n relativa
kubectl rollout status deploy/relativa-gateway -n relativa
```

Перший apply створив усі об'єкти, обидва Deployment стали Ready.

## 6. Доступ і конфігурація в контейнері

`minikube service ... --url` на цьому драйвері не віддав URL і тримав процес. Для браузера:

```text
kubectl port-forward -n relativa svc/relativa-gateway 18080:8080
```

Сторінка `http://127.0.0.1:18080/health` показала JSON з `version` `1.0.0`, іменем пода і `appName` `Relativa`. Знімок у `evidence/health-browser.png`. З вузла той самий шлях через NodePort потрапив в інший под. Це вже розподіл: port-forward прилипає до одного пода, kube-proxy на NodePort вибирає ендпоінт на кожне з'єднання.

Несекретні змінні:

```text
kubectl exec deploy/relativa-gateway -n relativa -- printenv Relativa__AppName Relativa__LogLevel Jwt__Issuer Jwt__Audience POD_NAME App__Version
```

Результат збігається з ConfigMap, з іменем пода і з тегом `1.0.0`.

Секрет перевірявся хешем, без запису пароля в журнал. SHA-256 `Jwt__SecretKey` у поді дорівнює SHA-256 ключа `JWT_SECRET` у маніфесті. Те саме для `POSTGRES_PASSWORD` у контейнері бази. Хеш JWT не дорівнює хешу placeholder з `appsettings.json`. На захисті, якщо попросять показати рядок, його читають з `k8s/20-secret.yaml` або командою `printenv Jwt__SecretKey` усередині пода. У HTTP його немає.

## 7. Самовідновлення

```text
kubectl delete pod relativa-gateway-878685b65-6pz2m -n relativa --wait=true
kubectl rollout status deploy/relativa-gateway -n relativa
kubectl get pods -n relativa -l app=relativa-gateway -o wide
```

Було два поди, `6pz2m` і `94w6q`. Після видалення першого лишився `94w6q` і з'явився `hqq7k`, Ready, той самий ReplicaSet `878685b65`. Deployment не створює под сам. Він тримає бажане число реплік через ReplicaSet. ReplicaSet бачить, що живих подів менше, ніж `replicas`, і створює новий. Видалення Deployment прибрало б і ReplicaSet, і поди. Видалення одного пода їх не чіпає.

## 8. Том

```text
kubectl exec -n relativa deploy/relativa-postgres -- psql -U relativa -d relativa -c "CREATE TABLE IF NOT EXISTS lab3_probe(id int);"
kubectl exec -n relativa deploy/relativa-postgres -- psql -U relativa -d relativa -c "INSERT INTO lab3_probe VALUES (1);"
kubectl exec -n relativa deploy/relativa-postgres -- psql -U relativa -d relativa -c "SELECT id FROM lab3_probe;"
kubectl delete pod relativa-postgres-6c9b64ccd8-l4qc6 -n relativa --wait=true
kubectl rollout status deploy/relativa-postgres -n relativa
kubectl exec -n relativa deploy/relativa-postgres -- psql -U relativa -d relativa -c "SELECT id FROM lab3_probe;"
```

До видалення `SELECT` повернув `1`. Після — новий под `8dm8b` на тому самому PVC, `SELECT` знову `1`. Якби дані були в writable layer контейнера, новий под побачив би порожню базу. `emptyDir` теж помер би разом із подом. PVC переживає под, бо том окремий від контейнера.

Локальний сокет у образі Postgres довіряє користувачу всередині контейнера, тому `psql` без пароля в команді спрацював. Пароль усе одно переданий у процес через Secret: без нього офіційний entrypoint не підняв би кластер бази.

## 9. Масштаб

```text
kubectl scale deploy/relativa-gateway -n relativa --replicas=4
kubectl rollout status deploy/relativa-gateway -n relativa
```

Чотири поди Ready: `dmtlh`, `f9swh`, `n5pm4`, `tkq9p`. Далі з вузла, щоб потрапити в kube-proxy, а не в один port-forward:

```text
minikube ssh -- curl -sS -m 5 http://127.0.0.1:30080/health
```

Дванадцять відповідей, усі `version` `1.0.0`, імена подів чергуються. У вибірці є всі чотири. Service не має session affinity, тож кожне нове TCP-з'єднання може потрапити в інший под.

Повернення до файлового базису:

```text
kubectl scale deploy/relativa-gateway -n relativa --replicas=2
```

У першому `get pods` після цього два поди ще `Terminating`. Це нормально: ReplicaSet уже не хоче їх тримати, kubelet ще доганяє видалення. `rollout status` дочекався двох Ready.

## 10. Rolling update і відкат

Спочатку образ повернуто на `1.0.0`, щоб вікно замірів починалось зі старої версії. Далі:

```text
kubectl set image deploy/relativa-gateway gateway=relativa-gateway:1.1.0 -n relativa
```

Ім'я контейнера в команді — `gateway`, як у маніфесті. Поки йшло оновлення, ті самі запити на NodePort спочатку відповідали `1.0.0` з подів `f9swh` і `dmtlh`, потім `1.1.0` з пода `relativa-gateway-6445459444-jwg6b`. У цьому вікні не було відповіді з помилкою. `rollout status` написав `successfully rolled out`.

Чому застосунок не зникав. `maxUnavailable: 0` забороняє прибирати старий под, поки новий не Ready. `maxSurge: 1` дозволяє один зайвий под. Readiness б'є в `/health` кожні 5 секунд і не пускає под у Service, поки проба не пройде. kube-proxy бачить лише Ready ендпоінти.

Історія і відкат:

```text
kubectl rollout history deploy/relativa-gateway -n relativa
kubectl rollout undo deploy/relativa-gateway -n relativa
kubectl rollout status deploy/relativa-gateway -n relativa
```

Undo повернув образ на `relativa-gateway:1.0.0`. kubectl попередив, що undo не переписує анотацію `kubectl.kubernetes.io/last-applied-configuration`. Наступний `kubectl apply -f k8s/` орієнтується на файл, не на undo. Тому в кінці apply знову виставив те, що в git-робочому дереві: `1.0.0` і 2 репліки.

Один `curl` одразу після undo отримав таймаут 5 секунд. У цей момент ендпоінти мінялись. Наступний доказ, що `1.0.0` живий, — логи пода цієї ревізії під час зламаного оновлення: кілька рядків `HTTP GET /health responded 200`, і `printenv App__Version` дорівнює `1.0.0`.

`kubectl rollout history` у фіналі показує не кожну ревізію з першої, а ті, для яких ReplicaSet ще існує. Після серії `set image` лишились три:

- `relativa-gateway-878685b65` — `1.0.0`, 2 репліки, зараз працює
- `relativa-gateway-6445459444` — `1.1.0`, 0 реплік
- `relativa-gateway-7ffd96797c` — `9.9.9`, 0 реплік

Нуль реплік не означає, що запис стерто. ReplicaSet лишається, щоб `rollout undo` мав куди повертатись, поки його не витіснить ліміт історії.

## 11. ImagePullBackOff

```text
kubectl set image deploy/relativa-gateway gateway=relativa-gateway:9.9.9 -n relativa
kubectl get pods -n relativa -l app=relativa-gateway
kubectl describe pod relativa-gateway-7ffd96797c-vs9rt -n relativa
```

Под `vs9rt` у стані Pending, контейнер Waiting, причина `ImagePullBackOff`, образ `relativa-gateway:9.9.9`. Events, у порядку появи:

1. Scheduled на вузол minikube.
2. Failed: не вдалося стягнути `docker.io/library/relativa-gateway:9.9.9`. Репозиторію немає: `pull access denied, repository does not exist`.
3. `ErrImagePull`.
4. Back-off pulling image.
5. `ImagePullBackOff`.
6. kubelet повторює Pulling.

`ErrImagePull` — сама невдала спроба. `ImagePullBackOff` — kubelet чекає дедалі довше перед наступною спробою, щоб не гатити registry. Контейнер не створений: Container ID порожній, логів цього пода немає. Логи і `exec` знімались з живого пода попередньої ревізії, `relativa-gateway-878685b65-gl6vv`. Він слухає `[::]:8080`, відповідає 200, `App__Version=1.0.0`. Два старі поди лишились Running саме через `maxUnavailable: 0`: зламаний под не став Ready, тож старі не прибрали.

Виправлення:

```text
kubectl set image deploy/relativa-gateway gateway=relativa-gateway:1.1.0 -n relativa
kubectl rollout status deploy/relativa-gateway -n relativa
```

Обидва нові поди Ready. `/health` повернув `version` `1.1.0`.

Після того, як цей вивід уже лежав у `evidence/fix.txt`, кластер повернуто до файлів:

```text
kubectl apply -f k8s/
```

Apply змінив Deployment шлюзу. Postgres, сервіси, PVC, Ingress лишились unchanged. `/health` знову `version` `1.0.0`. Тег `9.9.9` у файли не записувався.

## 12. Що сказати, якщо запитають про збої зняття журналу

Пам'ять 4096 МіБ Docker не дав. Кластер на 3072 МіБ, і цього вистачило на ingress, metrics-server, два поди шлюзу і Postgres. `kubectl top` це підтверджує: вузол зайняв близько 1357 МіБ з ліміту.

`minikube service --url` на docker-драйвері Windows тримає тунель у тому самому терміналі і в цій сесії URL не надрукував. NodePort з вузла працює. Браузер відкрито через port-forward на сервіс.

Перша спроба `curl -w` через `minikube ssh` розвалилась: перенос рядка в аргументі `-w` розрізав команду всередині bash на вузлі. У журнал розподілу трафіку пішла повторна серія вже з `curl -sS -m 5` без `-w`. Розподіл по чотирьох подах знятий цією серією.

Один запит після `rollout undo` спіймав таймаут 5 секунд. Решта доказів відкату — образ у Deployment `1.0.0`, успішний `rollout status` і живі логи `/health` пода цієї ревізії.

## 13. Словник

**Cluster.** Набір машин, якими керує Kubernetes. Тут одна машина, вузол minikube, і вона ж тримає control plane.

**Node.** Вузол, де kubelet запускає поди. У `kubectl get nodes` він `Ready`, роль `control-plane`.

**Control plane.** Процеси, які вирішують, що має працювати: kube-apiserver приймає `kubectl`, etcd пам'ятає об'єкти, kube-scheduler обирає вузол, kube-controller-manager крутить контролери на кшталт ReplicaSet.

**kubelet.** Агент на вузлі. Тягне образ, стартує контейнер, виконує проби, пише Events. Саме kubelet поставив `ImagePullBackOff`.

**Pod.** Найменша одиниця запуску. Один або кілька контейнерів зі спільною мережею і томами. Под шлюзу містить один контейнер `gateway`.

**Deployment.** Опис бажаного стану подів: скільки реплік, який образ, які проби. Сам контейнерів не запускає.

**ReplicaSet.** Нащадок Deployment. Тримує точну кількість подів з даним селектором. Нова ревізія образу — новий ReplicaSet. Старий лишається з нулем реплік для відкату.

**Label.** Пара ключ-значення на об'єкті. У шлюзу це `app: relativa-gateway`.

**Selector.** Запит за labels. Service і Deployment знаходять свої поди тільки ним. Якщо label пода не входить у селектор, Service на нього не пошле трафік, навіть якщо под Running.

**Service.** Стабільна адреса на множину подів. Поди змінюють IP, Service ні. Тут ClusterIP бази `10.101.55.108` і NodePort шлюзу `10.101.50.29`.

**ClusterIP.** Адреса тільки всередині кластера. База така навмисно.

**NodePort.** Той самий ClusterIP плюс порт на кожному вузлі, тут `30080`. З вузла minikube це `127.0.0.1:30080`.

**kube-proxy.** Програмує правила, які з адреси Service ведуть на IP готових подів. Розподіл дванадцяти запитів по чотирьох подах — його робота.

**Ingress.** Правило HTTP ззовні кластера на Service. Об'єкт сам по собі трафік не приймає.

**Ingress controller.** Под, який читає Ingress і налаштовує проксі. Тут nginx у namespace `ingress-nginx`. Подія `Scheduled for sync` означає, що контролер побачив наш об'єкт.

**Addon.** Додаток minikube, який ставить готовий компонент. Увімкнені metrics-server, ingress, storage-provisioner і default-storageclass.

**Namespace.** Окрема область імен. `relativa` не змішується з `kube-system`. Видалення namespace прибрало б усі об'єкти роботи.

**ConfigMap.** Несекретна конфігурація, змонтована як env або файл. Тут env. Зміна ConfigMap не перезапускає под сама. Щоб процес перечитав змінні, под треба перестворити.

**Secret.** Той самий механізм для чутливих рядків. У etcd значення лежить закодованим, `stringData` у файлі лише зручний запис: API сам робить base64. Це не шифрування. Тому в репозиторії лише навчальні рядки.

**stringData.** Поле Secret, куди пишуть звичайний текст. `data` вимагало б base64 вручну.

**Downward API.** Спосіб віддати поду дані про нього самого. `fieldRef: metadata.name` пише ім'я пода в `POD_NAME`. Без цього два поди одного образу не відрізнити у відповіді.

**Requests.** Скільки CPU і пам'яті под просить для планування. Scheduler не поставить под на вузол, де цього немає.

**Limits.** Стеля. CPU понад limit душать, пам'ять понад limit вбиває процес з OOMKilled. Клас QoS у describe зламаного пода — Burstable, бо request і limit задані і не рівні між собою так, щоб це був Guaranteed на всі контейнери з рівними request і limit. У нашому контейнері request менший за limit, тому Burstable.

**Liveness probe.** Чи живий процес. Провал рестартує контейнер. У шлюзу це GET `/health` після 15 секунд старту, далі кожні 10. Якщо процес завис, kubelet його перезапустить.

**Readiness probe.** Чи можна слати трафік. Провал прибирає под з Service, але не рестартує контейнер. Той самий `/health`, раніше і частіше: затримка 5 секунд, період 5. Саме readiness тримає rolling update від того, щоб віддати користувачу под, який ще не слухає порт.

**Rolling update.** Заміна подів партіями, без вікна, коли реплік нуль. Керується `maxUnavailable` і `maxSurge`.

**maxUnavailable.** Скільки подів можна мати недоступними понад бажане число. Нуль означає: спочатку підніми новий, потім прибирай старий.

**maxSurge.** Скільки додаткових подів можна завести понад `replicas`. Одиниця означає на двох репліках короткочасно три поди.

**Revision.** Номер шаблону пода в історії Deployment. `kubectl set image` і `kubectl apply` зі зміною шаблону створюють нову. `kubectl rollout undo` повертає попередню.

**Rollback.** Повернення попереднього шаблону. Тут `kubectl rollout undo` повернув образ з `1.1.0` на `1.0.0`.

**ImagePullBackOff.** kubelet не зміг стягнути образ і чекає перед повтором. Причина в Events, не в імені статусу.

**Events.** Журнал рішень scheduler і kubelet по об'єкту. `kubectl describe pod` показує їх унизу. Для `9.9.9` там прямо написано, що репозиторію `docker.io/library/relativa-gateway` немає.

**PersistentVolumeClaim.** Запит пода на диск: розмір і режим доступу. Под не знає, де фізично лежить диск.

**PersistentVolume.** Сам том. Його створив provisioner minikube, коли PVC став Bound.

**StorageClass.** Політика, яким provisioner створювати том. Клас `standard` у minikube — локальний hostPath на вузлі. Для однієї ноди `ReadWriteOnce` достатньо.

**Image tag.** Частина імені після двокрапки. `1.0.0` і `1.1.0` — різні образи. `latest` бланк забороняє, бо під одним ім'ям ховається різний вміст і відкат тоді невизначений.

**imagePullPolicy.** `IfNotPresent` не чіпає образ, якщо він уже на вузлі. `Always` щоразу питає registry. `Never` не тягне зовсім і на відсутньому тегу дає `ErrImageNeverPull`, що не є завданням бланка.

**metrics-server.** Збирає CPU і пам'ять з kubelet і віддає їх `kubectl top`. Без нього `top` відповідає помилкою.

**Declarative apply.** `kubectl apply -f` виставляє бажаний стан з файлу. Повторний apply доганяє різницю.

**Imperative set.** `kubectl set image`, `kubectl scale`, `kubectl delete pod` змінюють живий об'єкт, не файл. Тому зламаний тег не потрапив у `k8s/`, а фінальний apply повернув кластер до файлу.

## 14. Питання

**Чому не `latest`?** Бо відкат і історія тоді не мають стабільного вмісту. Два теги, `1.0.0` і `1.1.0`, зібрані з різним `App__Version`. `/health` це показує. У маніфесті зафіксовано `1.0.0`.

**Чим liveness відрізняється від readiness, якщо шлях один?** Обидві б'ють у `/health`. Провал liveness рестартує контейнер. Провал readiness лише виймає под із Service. Під час старту readiness починається раніше, щоб под увійшов у баланс, щойно слухає порт, а liveness дає процесy 15 секунд, перш ніж вважати його мертвим.

**Чому JWT у Secret і чому його немає в `/health`?** Це ключ підпису. У відповідь його віддавати не можна. У маніфесті значення синтетичне і не дорівнює рядку з `appsettings.json`. SHA-256 у поді збігається з маніфестом і не збігається з placeholder. ASP.NET бере змінну `Jwt__SecretKey` вище за JSON, тож процес підписував би токени ключем із Secret.

**Чому `maxUnavailable: 0`?** Щоб під час заміни образу лишався хоча б один Ready под. Заміри під час переходу на `1.1.0` це показали: спочатку відповідав `1.0.0`, потім `1.1.0`, без помилкової відповіді у вікні. Readiness не пускає новий под у Service, поки `/health` не відповідає.

**Чому Gateway не ходить у цю базу і що доводить `lab3_probe`?** Шлюз у цій роботі stateless і стартує без Postgres. База додана, бо в проєкті є стан і бланк просить PVC. Рядок `1` прочитаний після видалення пода на тому самому PVC. Це і є доказ тома. Життєвий цикл застосунку показаний на шлюзі, де є дві версії образу.

**Звідки `ImagePullBackOff` на `9.9.9`?** Образ у minikube не завантажували і в Docker Hub репозиторію `library/relativa-gateway` немає. Events: `pull access denied, repository does not exist`, далі `ErrImagePull`, далі backoff. `IfNotPresent` не рятує, коли образу на вузлі немає: kubelet іде в registry.

**Як показано баланс між репліками?** Дванадцять запитів на NodePort `30080` при чотирьох репліках повернулися з чотирьох різних `pod`. Port-forward для цього не годиться: він тримає один под.

**Чому версія не входить у селектор?** Селектор Deployment незмінний. Якби в ньому був тег, зміна образу або не пройшла б, або нові поди не збіглися б із Service. Стабільний селектор — `app: relativa-gateway`. Версію видно в образі й у полі `version` відповіді.

**Що буде, якщо видалити под, Deployment і ReplicaSet?** Видалення пода: ReplicaSet створить заміну. Це знято в `self-heal.txt`. Видалення ReplicaSet без Deployment: Deployment створить новий ReplicaSet. Видалення Deployment: зникають і ReplicaSet, і поди, якщо не сказати `--cascade=orphan`.

**Чому після undo наступний apply може здивувати?** Undo не оновлює last-applied-configuration. Apply дивиться у файл `k8s/60-gateway-deployment.yaml`, де образ `1.0.0`. Фінальний apply так і зробив, і `/health` знову віддав `1.0.0`.

**Навіщо і Ingress, і NodePort?** Пункт 2 вимагає увімкнути додаток ingress. Пункт 4 дозволяє Ingress або NodePort. Ingress створений і контролер його прийняв. Надійний вхід з цієї Windows-машини без admin-тунелю — NodePort `30080` і port-forward на Service.

## 15. Сценарій на п'ять-сім хвилин

Кластер уже на `1.0.0`, дві репліки, PVC Bound. Журнали не перезнімати, якщо викладач не просить наживо.

1. Показати гілку `devops/lab3` і каталог `k8s/`. Сказати: один файл на об'єкт, `kubectl apply -f k8s/`, namespace `relativa`. Образи `1.0.0` і `1.1.0` без `latest`, завантажені в minikube, не в Docker Hub.
2. `kubectl get pods,deploy,rs,svc,pvc,ingress -n relativa`. Gateway 2/2, Postgres 1/1, PVC Bound, Service NodePort `30080`. Три ReplicaSet шлюзу: робочий `1.0.0`, нульові `1.1.0` і `9.9.9`.
3. Відкрити `http://127.0.0.1:18080/health`, якщо port-forward ще живий, або підняти його знову. Показати `version`, `pod`, `appName`. Сказати, що `appName` з ConfigMap, `version` з образу, ім'я пода з downward API, секрет у JSON не входить.
4. `kubectl exec deploy/relativa-gateway -n relativa -- printenv Relativa__AppName Jwt__Issuer App__Version`. Для секрету відкрити `evidence/secret-match.txt`: хеш збігається з маніфестом і не збігається з `appsettings.json`.
5. Видалити один под шлюзу і показати нове ім'я. Якщо часу мало, відкрити `evidence/self-heal.txt`: `6pz2m` замінено на `hqq7k`.
6. Масштаб і оновлення не крутити вдруге, якщо викладач не просить. Відкрити `evidence/scale.txt`: чотири імені подів у відповідях. Відкрити `evidence/rollout.txt`: у одному вікні спочатку `1.0.0`, потім `1.1.0`, без помилкової відповіді. Сказати про `maxUnavailable: 0` і readiness.
7. `evidence/image-pull-backoff.txt`, блок Events. Своїми словами: тега `9.9.9` немає ні локально, ні в Docker Hub, kubelet пішов у backoff, старі поди лишились, бо новий не став Ready. `evidence/fix.txt`: повернення на `1.1.0` і `version` `1.1.0`. `evidence/reset.txt`: apply повернув файл `1.0.0`.
8. Якщо лишається хвилина: `evidence/pvc-survive.txt`. Рядок `1` є і після нового пода. Gateway цю базу не використовує. Том закриває умову бланка про стан.

Наживо зламаний тег ставити лише якщо викладач просить побачити Events зараз. Команда та сама: `kubectl set image deploy/relativa-gateway gateway=relativa-gateway:9.9.9 -n relativa`, потім describe, потім `kubectl apply -f k8s/`, щоб повернути файл.
