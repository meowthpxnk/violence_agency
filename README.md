# Набор агентов

Это проект с агентами Cursor для разработки. Корневой агент принимает задачу и передаёт её дальше. Python и FastAPI идут агенту `backend`, TypeScript и React — агенту `frontend`. Эти агенты делают работу сами и отдают diff своему ревьюеру. К корневому агенту работа возвращается только после `verdict: approve`.

Совет по правилам принимает агент `standards`. Он правит файлы набора и оставляет правку после проверки `python .cursor/check_recommendations.py` и ревьюера `reviewer-standards`.

Весь набор лежит в `.cursor`:

- `agents` — промпты агентов
- `rules` — правила и образцы кода
- `recommendations` — текстовые рекомендации
- `AGENTS.md` — протокол корневого агента
- `check_recommendations.py` — проверка формы рекомендаций

Правила и рекомендации написаны на английском. Промпты агентов можно писать по-русски.

## Установка

Скрипт скачивает `.cursor` в выбранный проект. Если в проекте уже есть `.cursor`, папка переименовывается в `.cursor.backup`, и на её место ставится набор. Если `.cursor.backup` уже есть, установка останавливается, чтобы не затереть прежнюю копию.

Из клона этого репозитория, находясь в своём проекте:

```powershell
powershell -ExecutionPolicy Bypass -File C:\path\to\violence_agency\scripts\install.ps1
```

Текущая папка и есть цель. Другой путь задаётся так:

```powershell
powershell -ExecutionPolicy Bypass -File C:\path\to\violence_agency\scripts\install.ps1 -Target C:\work\my-app
```

Скрипт можно скачать и запустить без клона. Тогда набор берётся из GitHub, ветка `master`:

```powershell
irm https://raw.githubusercontent.com/meowthpxnk/violence_agency/master/scripts/install.ps1 -OutFile $env:TEMP\install-agents.ps1
powershell -ExecutionPolicy Bypass -File $env:TEMP\install-agents.ps1 -Target C:\work\my-app
```

## Обновление

Скрипт скачивает новую версию набора с GitHub и заменяет `.cursor` в проекте. Папку `.cursor.backup` он не трогает.

```powershell
powershell -ExecutionPolicy Bypass -File C:\path\to\violence_agency\scripts\update.ps1 -Target C:\work\my-app
```

Или скачанным файлом:

```powershell
irm https://raw.githubusercontent.com/meowthpxnk/violence_agency/master/scripts/update.ps1 -OutFile $env:TEMP\update-agents.ps1
powershell -ExecutionPolicy Bypass -File $env:TEMP\update-agents.ps1 -Target C:\work\my-app
```

Правки, сделанные прямо в установленном `.cursor`, при обновлении заменяются версией из репозитория.

## Удаление

Скрипт удаляет папку `.cursor` целиком и возвращает на место резервную копию. Сначала ищется `.cursor.backup`. Если её нет, возвращается `.cursor.bak`.

```powershell
powershell -ExecutionPolicy Bypass -File C:\path\to\violence_agency\scripts\uninstall.ps1 -Target C:\work\my-app
```

Или скачанным файлом:

```powershell
irm https://raw.githubusercontent.com/meowthpxnk/violence_agency/master/scripts/uninstall.ps1 -OutFile $env:TEMP\uninstall-agents.ps1
powershell -ExecutionPolicy Bypass -File $env:TEMP\uninstall-agents.ps1 -Target C:\work\my-app
```

Если резервной копии не было, проект остаётся без `.cursor`.
