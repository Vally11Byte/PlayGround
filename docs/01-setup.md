# 01 · Setup dell'ambiente

🎯 **Obiettivo:** avere tutti gli strumenti funzionanti e lanciare l'app con F5.

## 📖 Cosa ti serve e perché

| Strumento | A cosa serve |
|-----------|--------------|
| **.NET SDK 10** | compilare ed eseguire l'app |
| **VS Code + C# Dev Kit** | scrivere codice e fare debug |
| **Git** | tenere la storia del codice |
| **GitHub CLI (`gh`)** | parlare con GitHub dal terminale |
| **Docker** | impacchettare l'app in un container |

Sul tuo PC hai già .NET, Git, `gh` e Docker. Mancano solo alcune configurazioni.

## 🛠️ Pratica

### 1. Presentati a Git

Ogni commit porta il tuo nome e la tua email. Usa **la stessa email del tuo account GitHub**,
altrimenti i commit non verranno collegati al tuo profilo.

```bash
git config --global user.name "Il Tuo Nome"
git config --global user.email "tua-email@esempio.it"
git config --global init.defaultBranch main    # il branch principale si chiama "main"
git config --global pull.rebase false          # "git pull" fa merge (più semplice all'inizio)
git config --global core.editor "code --wait"  # usa VS Code quando Git ti chiede di scrivere
```

Verifica: `git config --global --list`

### 2. Collegati a GitHub

```bash
gh auth login
```
Rispondi: `GitHub.com` → `SSH` → genera una nuova chiave SSH → `Login with a web browser`.

`gh` crea la chiave SSH e la carica sul tuo account per te. Verifica:
```bash
gh auth status
ssh -T git@github.com     # deve rispondere "Hi <tuo-utente>! You've successfully authenticated"
```

> 💡 **SSH vs HTTPS**: sono due modi per autenticarti con GitHub. Con SSH non devi mai inserire password o token: la chiave sul tuo PC fa da "badge".

### 3. Sistema Docker

Adesso se lanci `docker ps` ottieni `permission denied`. Due possibili cause:

```bash
# a) il servizio Docker non è avviato → avvialo e fallo partire al boot
sudo systemctl enable --now docker

# b) il tuo utente non è nel gruppo "docker" → aggiungilo
sudo usermod -aG docker $USER
```
Dopo il punto b) **esci e rientra dalla sessione** (o riavvia). Poi verifica:
```bash
docker run --rm hello-world
```
Se vedi "Hello from Docker!" sei a posto.

> ⚠️ Stare nel gruppo `docker` equivale di fatto ad avere i permessi di root. Sul tuo PC va bene; su un server condiviso pensaci.

### 4. Apri il progetto in VS Code

```bash
code ~/Work/repos/PlayGround
```

1. In basso a destra VS Code propone di installare le **estensioni consigliate** → *Install All*.
   Sono elencate in `.vscode/extensions.json`.
2. Premi **F5**.
3. Si apre il browser su http://localhost:5269 con l'app. 🎉

### 5. Prova il debugger

1. Apri `PlayGround/Components/Pages/Counter.razor`.
2. Clicca a sinistra del numero di riga di `currentCount++;` → compare un pallino rosso (breakpoint).
3. Nel browser vai su *Counter* e clicca il bottone.
4. VS Code si ferma sulla riga: passa il mouse su `currentCount` per vederne il valore.
5. `F10` = vai avanti di una riga, `F5` = continua, `Shift+F5` = ferma tutto.

## 📖 Cosa c'è in `.vscode/`

| File | Cosa fa |
|------|---------|
| `launch.json` | le configurazioni di **F5** (debug normale, hot reload, attach) |
| `tasks.json` | i **task**: `build` (lanciato prima di F5), `publish`, comandi Docker. Li trovi con `Ctrl+Shift+P` → *Tasks: Run Task* |
| `extensions.json` | estensioni consigliate a chi apre il progetto |
| `settings.json` | impostazioni condivise dal team (formattazione al salvataggio, ecc.) |

Questi file vanno **committati**: così tutto il team ha la stessa esperienza con F5.

## 🏋️ Esercizio

1. Avvia la configurazione **PlayGround (watch / hot reload)** dal menu a tendina di *Run and Debug*.
2. Cambia il testo `Hello, world!` in `Home.razor` e salva.
3. Guarda il browser aggiornarsi da solo.

## ✅ Checklist

- [ ] `git config --global user.email` restituisce la mail di GitHub
- [ ] `gh auth status` dice che sei loggato
- [ ] `docker run --rm hello-world` funziona senza `sudo`
- [ ] F5 apre l'app e i breakpoint funzionano

➡️ Prossima: [02 · Git in locale](02-git-basi.md)
