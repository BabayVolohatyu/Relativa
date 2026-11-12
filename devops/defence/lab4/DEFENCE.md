# План захисту лабораторної роботи №4

Технології DevOps. Пакування застосунку в Helm-чарт.

Проєкт: Relativa, гілка `devops/lab4`. Чарт лежить у `helm/`. Докази (виводи команд) лежать у `devops/evidence/lab4`. Звіт: `devops/defence/lab4/lab4_report.docx` (його генерує `devops/gen_lab4_report.py`). Скрипт, який відтворює весь життєвий цикл: `devops/defence/lab4/run-lifecycle.ps1`.

## 1. Мета

Взяти маніфести з Лаби 3 (`k8s/`), які були набором окремих YAML-файлів із зашитими значеннями, і запакувати їх у Helm-чарт. Після цього той самий чарт ставиться у двох середовищах (dev і prod) різними значеннями, а релізом можна керувати як одним цілим: встановити, оновити, подивитися історію, відкотити, видалити.

Коротко для викладача: у Лабі 3 я керував окремими об'єктами через `kubectl apply`. У Лабі 4 я керую застосунком як релізом через `helm install/upgrade/rollback/uninstall`.

## 2. Що ми пакуємо

Те саме, що в Лабі 3: шлюз Gateway (образ `relativa-gateway`) і PostgreSQL 16. Образи `relativa-gateway:1.0.0` і `1.1.0` уже завантажені в minikube командою `minikube image load`, тож Docker Hub не потрібен. `postgres:16-alpine` уже є на вузлі.

Об'єкти Лаби 3: Namespace, ConfigMap, Secret, PVC, Deployment і Service для postgres, Deployment і Service для gateway, Ingress (усього 9). Чарт відтворює всі, крім Namespace (див. розділ 5), і додає два службові Pod'и (хук і тест).

## 3. Середовище

- Helm: v3.20.0 (`winget`). Спочатку winget поставив Helm 4.3.1, але лаба описана для Helm 3, тому я його видалив і поставив 3.20.0. Це варто згадати, якщо спитають, чому саме ця версія.
- minikube v1.39.0, драйвер docker, Kubernetes v1.37.0.
- Docker Desktop. Один раз рушій завис (`docker version` не відповідав), тому я перезапустив Docker Desktop і `wsl --shutdown`, після чого minikube запустився нормально.
- Реліз Лаби 3 перед початком видалено, щоб порти й імена не конфліктували. Виводи: `00-env.txt`.

## 4. Структура чарту

```text
helm/
  Chart.yaml            # метадані: name relativa, version 1.0.0, appVersion 1.0.0
  values.yaml           # значення за замовчуванням (dev)
  values-dev.yaml       # явні dev-значення
  values-prod.yaml      # відмінності prod
  .helmignore
  README.md
  templates/
    _helpers.tpl        # іменовані шаблони: fullname, labels, selectorLabels
    NOTES.txt           # текст після install
    configmap.yaml
    secret.yaml
    postgres-pvc.yaml
    postgres-deployment.yaml
    postgres-service.yaml
    gateway-deployment.yaml
    gateway-service.yaml
    ingress.yaml        # лише якщо ingress.enabled
    pre-upgrade-check.yaml   # хук pre-upgrade
    tests/test-health.yaml   # helm test
```

`version` у `Chart.yaml` описує версію самого чарту (змінюється, коли змінюються шаблони). `appVersion` описує версію застосунку, який чарт розгортає. Це різні речі, обидві зараз 1.0.0.

## 5. Шаблони і values

Усі зашиті значення з Лаби 3 винесено у `values.yaml`: репліки, тег образу, `nodePort`, ресурси, проби, рівень логування, розмір PVC, увімкнення Ingress. У шаблонах вони тепер `{{ .Values.… }}`.

Імена об'єктів будуються через `_helpers.tpl` (`relativa.fullname` = ім'я релізу + ім'я чарту). Завдяки цьому той самий чарт можна поставити двічі під різними іменами, об'єкти не зіткнуться. Це підтверджено в `05b-install-twice.txt`: реліз `second` у тому самому namespace створив `second-relativa-gateway`, `second-relativa-postgres` і власний PVC. Після демонстрації його видалено.

Secret. У `values.yaml` лежать лише синтетичні лабораторні значення (`jwtSecretKey`, `postgresPassword`), а в шаблоні стоїть `required`, тож без значення рендер падає. Реальні паролі в values-файли не потрапляють: у prod їх передають через `--set secret.postgresPassword=…`.

Чому Namespace не шаблон. Namespace створює сам Helm через `--create-namespace`. Він не може бути частиною релізу, бо Helm зберігає стан релізу як Secret саме в цьому namespace, тобто namespace має існувати ще до рендеру шаблонів. Якби Namespace був шаблоном, `helm uninstall` намагався б його видалити разом зі своїм власним станом. Тому `00-namespace.yaml` з Лаби 3 у чарт не переноситься, і це відзначено в звіті пунктом 3a зі зірочкою.

Пріоритет значень (`02-values-priority.txt`): `values.yaml` < `-f файл` < `--set`. Приклад із доказів: за замовчуванням `replicas: 1` і тег `1.0.0`, з `-f values-prod.yaml` стає 3 і `1.1.0`, а `--set gateway.replicaCount=5 --set gateway.image.tag=9.9.9` перемагає і файл: 5 і `9.9.9`.

## 6. Два середовища

| Параметр | dev (`values.yaml`) | prod (`values-prod.yaml`) |
|---|---|---|
| Репліки gateway | 1 | 3 |
| Тег образу | 1.0.0 | 1.1.0 |
| Ресурси gateway (requests) | 50m / 128Mi | 150m / 256Mi |
| Ресурси postgres (requests) | 50m / 128Mi | 150m / 384Mi |
| Рівень логування | Information | Warning |
| Ingress | вимкнено | увімкнено, host `relativa.local` |

Розмір PVC у prod свідомо не змінювався: PVC не можна зменшувати, а збільшення залежить від storage class, тож `helm upgrade` міг би впасти. Це гарне пояснення, чому prod-файл містить лише безпечні відмінності.

Порівняння середовищ: `02-diff-dev-prod.txt`. Порівняння об'єктів Лаби 3 і чарту: `02-compare-lab3.txt`.

## 7. Lint, template, install

Команди та очікуваний результат:

```text
helm lint helm/                              # 1 chart(s) linted, 0 chart(s) failed
helm lint helm/ -f helm/values-prod.yaml
helm template relativa helm/ -f helm/values-prod.yaml
helm install relativa helm/ -n relativa-helm --create-namespace --wait --timeout 5m
```

- `helm lint` перевіряє структуру і синтаксис чарту. Єдине INFO: рекомендація додати іконку, це не помилка (`01-lint.txt`).
- `helm template` рендерить шаблони локально, без кластера. Корисно, щоб побачити готові маніфести до встановлення (`02-template-dev.yaml`, `02-template-prod.yaml`).
- `helm install` створює реліз `relativa` у namespace `relativa-helm`. `--wait` чекає готовності Pod'ів. Результат: STATUS deployed, REVISION 1, два Pod'и Running, PVC Bound (`03-install.txt`, `04-status.txt`).
- Після install працює `/health` через `minikube ssh -- curl …` на NodePort.

## 8. Життєвий цикл релізу

Реальна історія з `08-history.txt`, `09-rollback.txt`, `11b-hook-failure.txt`:

| Ревізія | Дія | Результат |
|---|---|---|
| 1 | `helm install` | Install complete, тег 1.0.0, 1 репліка |
| 2 | `helm upgrade --set gateway.image.tag=1.1.0` | `/health` показує `"version":"1.1.0"` |
| 3 | `helm upgrade -f values-prod.yaml` | 3 репліки, Warning, Ingress |
| 4 | `helm rollback relativa 1` | Rollback to 1: знову 1.0.0 і 1 репліка |
| 5 | `helm upgrade --set postgres.service.port=5999` | failed: хук не пройшов |
| 6 | `helm rollback relativa 4` | Rollback to 4, реліз знову deployed |

Важливі спостереження:

- Відкат не повертає стару ревізію, а створює нову (ревізія 4 «Rollback to 1»). Історія тільки росте.
- `helm get values --revision N` показує, які саме значення були в кожній ревізії.
- Зміна ConfigMap/Secret змінює анотацію `checksum/…` у Deployment, тому Pod'и перезапускаються самі. Без цього зміна конфігу не підхопилась би.
- Видалення: `helm uninstall relativa -n relativa-helm`. Після нього в namespace лишається тільки `configmap/kube-root-ca.crt`. Його створює сам Kubernetes у кожному namespace, до Helm він не стосується (`10-uninstall.txt`).

## 9. Завдання на вибір: хук і тест

Вибрано варіант (b): хук `pre-upgrade` і `helm test`.

- Хук `pre-upgrade-check` запускає Pod із `pg_isready` перед кожним `helm upgrade`. Якщо БД не відповідає, апгрейд зупиняється ще до зміни об'єктів. Політика видалення `before-hook-creation,hook-succeeded`.
- Тест `tests/test-health.yaml` стукає `wget` на `/health` і шукає `"status":"ok"`. Запуск: `helm test relativa -n relativa-helm`. Результат: `Phase: Succeeded` (`11-test.txt`).
- Демонстрація провалу: у `11b-hook-failure.txt` я свідомо вказав неправильний порт БД (`--set postgres.service.port=5999`). Лог хука: `relativa-postgres:5999 - no response`, апгрейд завершився `UPGRADE FAILED`, ревізія 5 має статус failed, але Deployment'и не змінилися й застосунок працює (`1/1 Available`). Потім відкат до ревізії 4 створив ревізію 6.

Дрібниця, на якій я спіткнувся: Pod'и хуків і тестів не належать до релізу, тому `helm uninstall` їх не видаляє. Щоб після видалення нічого не лишалось, додано політику `hook-succeeded`, а невдалий Pod хука видаляється вручну.

## 10. Де Helm зберігає стан

Кожна ревізія це Secret типу `helm.sh/release.v1` у namespace релізу з іменем `sh.helm.release.v1.<реліз>.v<N>`. Усередині: base64 від gzip від JSON (чарт, значення, маніфест, статус). Мітки: `owner=helm`, `status`, `version`. Це видно у `05-helm-state.txt` і в списку Secret'ів у `10-uninstall.txt` (v1…v6 перед видаленням). Окремої бази чи Tiller у Helm 3 немає, тому реліз «живе» в кластері.

## 11. Глосарій

- Helm: менеджер пакетів для Kubernetes.
- Чарт (chart): пакет із шаблонами, значеннями і метаданими.
- Реліз (release): конкретне встановлення чарту в кластері під своїм ім'ям.
- Ревізія (revision): номер змін релізу, кожен install/upgrade/rollback створює нову.
- values: параметри, що підставляються в шаблони.
- Шаблон (template): YAML з Go-template вставками.
- `_helpers.tpl`: файл із повторно використовуваними іменованими шаблонами.
- Хук (hook): об'єкт, який запускається на певному етапі життєвого циклу (pre-upgrade, test тощо).
- `NOTES.txt`: підказка, що друкується після install.
- Репозиторій чартів: місце, звідки чарти ставляться. У цій лабі не використовується.

## 12. Питання і відповіді

**Що таке Helm і навіщо він, якщо є kubectl?**
kubectl створює окремі об'єкти. Helm додає шаблони, значення, імена релізів, історію і відкат. Один чарт ставиться в різні середовища різними values, а оновлення й відкат виконуються однією командою.

**У чому різниця між `version` і `appVersion`?**
`version` це версія чарту, `appVersion` це версія застосунку. Тег образу береться зі values, а не з `appVersion`.

**Чим `helm upgrade` відрізняється від `kubectl apply`?**
`helm upgrade` створює нову ревізію, зберігає значення і дає змогу відкотитись. `kubectl apply` просто застосовує YAML і не пам'ятає, що було раніше.

**Який пріоритет у values?**
`values.yaml` найнижчий, потім `-f файл`, потім `--set` (виграє останній).

**Чому Namespace не в шаблонах?**
Helm зберігає стан релізу в Secret у цьому namespace, тому namespace має існувати до рендеру. Його створює `--create-namespace`.

**Що робить `--wait`?**
Helm не вважає install/upgrade завершеним, доки Pod'и не стануть Ready (до `--timeout`).

**Що робить `helm rollback`?**
Бере маніфест і значення старої ревізії та застосовує як нову ревізію. Стара ревізія не стирається.

**Як зберігається пароль?**
У репозиторії лише синтетичні лабораторні значення. Реальний пароль передається через `--set` і ніколи не комітиться. Шаблон використовує `required`, тому без пароля рендер падає.

**Що буде, якщо хук упаде?**
Upgrade зупиняється, реліз отримує статус failed, об'єкти не чіпаються. Це показано в ревізії 5.

**Чому після uninstall лишився `kube-root-ca.crt`?**
Його створює сам Kubernetes у кожному namespace. Helm його не створював і не видаляє.

**Чому Pod'и перезапустилися після зміни ConfigMap?**
У Deployment є анотація з контрольною сумою ConfigMap і Secret. Коли конфіг змінюється, змінюється й шаблон Pod'а, тому Deployment робить rolling update.

**Чому PVC не змінювали у prod?**
Розмір PVC не можна зменшити, а розширення залежить від storage class. Upgrade міг би впасти.

**Де побачити, що саме було встановлено?**
`helm get manifest`, `helm get values`, `helm get hooks`, `helm status`, `helm history`.

## 13. Сценарій демонстрації (5-7 хвилин)

1. (30 с) Що за лаба. «Беру маніфести Лаби 3 і пакую в Helm-чарт». Показати `helm/` і `Chart.yaml`.
2. (60 с) Шаблони і values. Відкрити `values.yaml` і `templates/gateway-deployment.yaml`, показати `{{ .Values.gateway.replicaCount }}` і `include "relativa.fullname"`. Згадати, що Namespace створює `--create-namespace`.
3. (45 с) Дві середовища. `helm template … -f helm/values-prod.yaml | Select-String replicas` і показати пріоритет `--set`.
4. (45 с) `helm lint helm/` і встановлення: `helm install relativa helm/ -n relativa-helm --create-namespace --wait`. Показати `kubectl get all -n relativa-helm`, `/health`.
5. (60 с) Upgrade: `helm upgrade … --set gateway.image.tag=1.1.0`, `/health` показує 1.1.0. Потім prod values: 3 репліки.
6. (45 с) `helm history`, `helm rollback relativa 1`, знову 1.0.0, у історії з'явилась нова ревізія.
7. (45 с) Хук і тест: `helm test relativa -n relativa-helm`. Показати `11b-hook-failure.txt`: невдалий апгрейд, ревізія 5 failed, застосунок живий.
8. (30 с) Де Helm зберігає стан: `kubectl get secret -n relativa-helm | Select-String helm.sh`.
9. (30 с) `helm uninstall`, у namespace лишився лише `kube-root-ca.crt`.

Якщо часу мало, пункти 3 і 8 можна скоротити до однієї фрази. Якщо щось пішло не так наживо, усі виводи вже збережено в `devops/evidence/lab4`, а `devops/defence/lab4/run-lifecycle.ps1` відтворює весь цикл.

## 14. Перед захистом

- Переконатися, що Docker Desktop і minikube запущені: `minikube status`.
- Образи на місці: `minikube image ls | Select-String relativa-gateway`.
- Реліз видалено, namespace `relativa-helm` порожній (стан після мого прогону).
- Версія Helm: `helm version --short` має показувати `v3.20.0`.
- Нічого не закомічено: пункт 10a вимагає коміту гілки `devops/lab4`, це лишається зробити вручну.
