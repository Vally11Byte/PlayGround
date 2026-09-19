# ★ Cheatsheet

## Git — tutti i giorni

| Comando | Cosa fa |
|---------|---------|
| `git status` | dove sono, cosa è cambiato |
| `git diff` / `git diff --staged` | cosa ho modificato / cosa sto per committare |
| `git add <file>` / `git add -p` | metti in staging (tutto il file / pezzo per pezzo) |
| `git commit -m "tipo: messaggio"` | salva uno snapshot |
| `git log --oneline --graph --all` | la storia, in forma di albero |
| `git switch main` | vai su main |
| `git switch -c feat/12-cosa` | crea un branch e vacci |
| `git pull` | scarica e integra le novità |
| `git push` / `git push -u origin <branch>` | manda i commit (la prima volta con `-u`) |
| `git fetch --prune` | aggiorna le info sui branch remoti, dimentica quelli cancellati |
| `git merge origin/main` | porta le novità di main nel tuo branch |
| `git branch -d <branch>` | cancella un branch locale già unito |
| `git stash` / `git stash pop` | metti da parte le modifiche al volo / riprendile |

## Git — annullare qualsiasi cosa 🚑

| Situazione | Comando |
|------------|---------|
| Voglio buttare le modifiche a un file | `git restore <file>` |
| Ho fatto `add` di troppo | `git restore --staged <file>` |
| Voglio correggere l'ultimo commit (NON pushato) | `git commit --amend` |
| Voglio annullare l'ultimo commit ma tenere le modifiche (NON pushato) | `git reset --soft HEAD~1` |
| Voglio annullare un commit già pushato | `git revert <hash>` |
| Sono in mezzo a un merge e mi sono perso | `git merge --abort` |
| Ho committato sul branch sbagliato (NON pushato) | `git switch -c branch-giusto` poi `git switch -` e `git reset --hard HEAD~1` |
| Ho perso un commit / ho fatto un disastro | `git reflog` → trova l'hash → `git switch -c salvataggio <hash>` |
| Tag sbagliato (NON pushato) | `git tag -d v1.0.0` |

> `git reflog` è la rete di sicurezza: Git ricorda **ogni** posizione in cui sei stato negli ultimi 90 giorni.

## GitHub CLI

| Comando | Cosa fa |
|---------|---------|
| `gh repo view --web` | apri il repo nel browser |
| `gh issue create` / `gh issue list` | crea / elenca issue |
| `gh pr create --fill` | apri una PR dal branch corrente |
| `gh pr list` / `gh pr view --web` | elenca / apri PR |
| `gh pr checkout 42` | scarica la PR 42 in locale per provarla |
| `gh pr checks --watch` | segui la CI della PR |
| `gh pr merge --squash --delete-branch` | unisci la PR |
| `gh run list` / `gh run watch` | esecuzioni delle Actions |
| `gh release list` / `gh release view vX.Y.Z` | le release |

## Release

```bash
git switch main && git pull
git tag -a v1.2.0 -m "Release 1.2.0"
git push origin v1.2.0
gh run watch
```

## Docker

| Comando | Cosa fa |
|---------|---------|
| `docker build -t nome:tag .` | costruisci un'immagine |
| `docker images` | elenca immagini |
| `docker run --rm -p 8080:8080 nome:tag` | avvia un container |
| `docker run -d --name x ...` | avvia in background |
| `docker ps` / `docker ps -a` | container attivi / tutti |
| `docker logs -f x` | log in tempo reale |
| `docker exec -it x bash` | entra nel container |
| `docker stop x && docker rm x` | ferma e rimuovi |
| `docker pull ghcr.io/utente/img:1.0.0` | scarica da un registry |
| `docker system prune` | pulizia |

## Docker Compose

| Comando | Cosa fa |
|---------|---------|
| `docker compose up --build` | builda e avvia |
| `docker compose up -d` | avvia in background |
| `docker compose ps` | stato |
| `docker compose logs -f` | log |
| `docker compose pull` | scarica le immagini aggiornate |
| `docker compose down` | ferma e rimuovi |

## VS Code

| Tasto | Cosa fa |
|-------|---------|
| `F5` | avvia con debug |
| `Shift+F5` | ferma |
| `F9` | metti/togli breakpoint |
| `F10` / `F11` | passo successivo / entra nella funzione |
| `Ctrl+Shift+B` | build |
| `Ctrl+Shift+G` | pannello Source Control |
| `Ctrl+Shift+P` → *Tasks: Run Task* | task Docker, publish... |
| `` Ctrl+` `` | terminale integrato |
