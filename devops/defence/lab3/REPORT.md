# Лабораторна робота №3

Технології DevOps. Розгортання власного застосунку в Kubernetes.

Проєкт: Relativa. Гілка `devops/lab3`, той самий коміт, що й `lab9` (`5b07227`). Нових комітів немає. У кластері minikube працюють Gateway і PostgreSQL. Журнали команд лежать у [evidence](evidence).

## Середовище

| Інструмент | Версія | Примітка |
|---|---|---|
| Docker Engine | 29.8.0 | драйвер minikube |
| kubectl | клієнт 1.36.1, сервер 1.37.0 | розбіжність в одну minor-версію, це дозволений skew |
| minikube | 1.39.0 | поставлено через `winget install -e --id Kubernetes.minikube` |
| Kubernetes | 1.37.0 | containerd 2.3.4 |
| Образ шлюзу | `relativa-gateway:1.0.0` і `1.1.0` | зібрані локально, завантажені в minikube |
| PostgreSQL | `postgres:16-alpine` | офіційний образ |

`minikube start --driver=docker --cpus=2 --memory=4096` завершився помилкою: Docker Desktop має лише 3841 МіБ. Кластер піднято з `--memory=3072`. Журнал вузла: [nodes.txt](evidence/nodes.txt). Системні поди: [kube-system.txt](evidence/kube-system.txt). Додатки metrics-server і ingress увімкнені: [addons.txt](evidence/addons.txt), контролер ingress: [ingress-pods.txt](evidence/ingress-pods.txt).

## 5. Розгортання

Одна команда з каталогу:

```text
kubectl apply -f k8s/
```

Вивід: [apply.txt](evidence/apply.txt). Створено namespace `relativa`, ConfigMap, Secret, PVC, два Deployment, два Service і Ingress.

Об'єкти після першого застосування: [objects.txt](evidence/objects.txt). Gateway `2/2`, Postgres `1/1`, PVC `postgres-data` у стані Bound, 1Gi, storage class `standard`. Service шлюзу — NodePort `8080:30080/TCP`.

`minikube service relativa-gateway -n relativa --url` на драйвері docker не повернув адресу: процес лишився висіти з текстом, що термінал треба тримати відкритим. Хост відкрито так:

```text
kubectl port-forward -n relativa svc/relativa-gateway 18080:8080
```

Браузер: `http://127.0.0.1:18080/health`. Знімок: [health-browser.png](evidence/health-browser.png). Тіло сторінки:

```json
{"status":"ok","service":"relativa-gateway","version":"1.0.0","pod":"relativa-gateway-878685b65-6pz2m","appName":"Relativa"}
```

Той самий шлях з вузла через NodePort (`minikube ssh -- curl -sS http://127.0.0.1:30080/health`) відповів іншим подом, `94w6q`: [nodeport-from-node.txt](evidence/nodeport-from-node.txt). Port-forward тримає один под, тому для розподілу трафіку далі використано NodePort.

Змінні з ConfigMap у контейнері `gateway`: [config-in-container.txt](evidence/config-in-container.txt).

```text
Relativa__AppName=Relativa
Relativa__LogLevel=Information
Jwt__Issuer=relativa-auth
Jwt__Audience=relativa
POD_NAME=relativa-gateway-878685b65-6pz2m
App__Version=1.0.0
```

`App__Version` прийшла з образу, не з ConfigMap. `POD_NAME` — downward API.

Секрет у файл журналу відкритим текстом не записувався. SHA-256 значення в поді збігається з SHA-256 відповідного ключа в `k8s/20-secret.yaml`, і хеш `Jwt__SecretKey` не збігається з хешем рядка з `appsettings.json`: [secret-match.txt](evidence/secret-match.txt). Обидва результати — `match`, відмінність від placeholder — `yes`. У відповіді `/health` секретів немає.

## 6. Життєвий цикл

Самовідновлення: [self-heal.txt](evidence/self-heal.txt). Видалено `relativa-gateway-878685b65-6pz2m`. ReplicaSet створив `relativa-gateway-878685b65-hqq7k`, обидва поди Ready.

Том: [pvc-survive.txt](evidence/pvc-survive.txt). У Postgres створено `lab3_probe`, вставлено `1`, под бази видалено. Новий под `relativa-postgres-6c9b64ccd8-8dm8b` на тому самому PVC повернув той самий рядок.

Масштаб: [scale.txt](evidence/scale.txt). `kubectl scale --replicas=4` підняв чотири поди. Дванадцять запитів на NodePort `30080` розійшлися по всіх чотирьох іменах: `tkq9p`, `dmtlh`, `n5pm4`, `f9swh`. Усі відповіді `version` `1.0.0`. Потім масштаб повернуто до 2. У знімку `get pods` два поди ще були `Terminating`: зменшення реплік не стирає їх миттєво.

Оновлення: [rollout.txt](evidence/rollout.txt).

```text
kubectl set image deploy/relativa-gateway gateway=relativa-gateway:1.1.0 -n relativa
```

Під час rolling update перші відповіді були `version` `1.0.0` (поди `f9swh` і `dmtlh`), остання в вікні замірів — `1.1.0` (под `relativa-gateway-6445459444-jwg6b`). Жодна з цих відповідей не була помилкою. `rollout status` завершився успішно, образ у Deployment став `relativa-gateway:1.1.0`. `maxUnavailable: 0` не віддавав трафік поду, поки readiness на `/health` не стала успішною.

Відкат: [rollback.txt](evidence/rollback.txt). `kubectl rollout undo` повернув образ `relativa-gateway:1.0.0`, `rollout status` успішний. Один запит одразу після undo вперся в таймаут 5 секунд, поки ендпоінти мінялись. Що версія `1.0.0` знову обслуговувала трафік, видно далі: живий под цієї ревізії писав `HTTP GET /health responded 200` уже під час зламаного оновлення.

## 7. Діагностика

Зламаний тег: [image-pull-backoff.txt](evidence/image-pull-backoff.txt).

```text
kubectl set image deploy/relativa-gateway gateway=relativa-gateway:9.9.9 -n relativa
```

Под `relativa-gateway-7ffd96797c-vs9rt` перейшов у `ImagePullBackOff`. У Events kubelet написав: не вдалося стягнути `docker.io/library/relativa-gateway:9.9.9`, `pull access denied, repository does not exist`, потім `ErrImagePull`, `Back-off pulling image`, `ImagePullBackOff`. Два поди попередньої ревізії лишились `Running`, бо `maxUnavailable: 0` не прибирає старий под, поки новий не Ready.

Логи і вхід у живий контейнер: [logs-exec.txt](evidence/logs-exec.txt). Под `relativa-gateway-878685b65-gl6vv` слухає `http://[::]:8080` і відповідає 200 на `/health`. `printenv` у ньому: `App__Version=1.0.0`, `POD_NAME` збігається з іменем пода, `Relativa__AppName=Relativa`.

Виправлення: [fix.txt](evidence/fix.txt). Образ повернуто на `relativa-gateway:1.1.0`. Обидва поди Ready. `/health` віддав `version` `1.1.0`.

## Стан після журналу

Щоб кластер збігався з файлами в `k8s/` (образ `1.0.0`, 2 репліки), ще раз виконано `kubectl apply -f k8s/`: [reset.txt](evidence/reset.txt). `/health` після цього знову `version` `1.0.0`.

ReplicaSet, які лишились: [replicasets.txt](evidence/replicasets.txt).

| ReplicaSet | Образ | Бажано реплік |
|---|---|---|
| `relativa-gateway-878685b65` | `1.0.0` | 2, обидві Ready |
| `relativa-gateway-6445459444` | `1.1.0` | 0 |
| `relativa-gateway-7ffd96797c` | `9.9.9` | 0 |
| `relativa-postgres-6c9b64ccd8` | `postgres:16-alpine` | 1 |

`kubectl top` бачить обидва поди шлюзу (близько 41–43m CPU і 28–30Mi) і Postgres. Вузол minikube: 412m CPU, 1357Mi пам'яті. Це підтверджує, що metrics-server віддає метрики, а не лише стоїть у списку додатків.
