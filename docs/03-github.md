# 03 · Il repo su GitHub

🎯 **Obiettivo:** pubblicare il repository su GitHub, capire push/pull e proteggere `main`.

## 📖 Concetti

- **Git** = lo strumento, vive sul tuo PC.
- **GitHub** = un servizio che ospita repository Git e aggiunge collaborazione (PR, issue, Actions...).
- **Remote** = un repository "remoto" collegato al tuo. Per convenzione si chiama `origin`.

```
  Il tuo PC                         GitHub
  ┌──────────────┐   git push   ┌──────────────┐
  │ repo locale  │ ───────────▶ │ origin       │
  │              │ ◀─────────── │              │
  └──────────────┘   git pull   └──────────────┘
```

Il tuo repository locale è **completo e indipendente**: puoi fare commit offline.
GitHub è semplicemente il punto d'incontro del team.

## 🛠️ Pratica

### 1. Crea il repo su GitHub e collegalo

Dalla cartella del progetto:
```bash
gh repo create PlayGround --private --source=. --remote=origin --push
```
Questo comando fa tre cose: crea il repo su GitHub, aggiunge il remote `origin`, fa il push.

Verifica:
```bash
git remote -v
gh repo view --web        # apre il repo nel browser
```

<details>
<summary>Il modo "manuale", per capire cosa succede sotto</summary>

1. Su github.com → *New repository* → nome `PlayGround`, **senza** README/gitignore (li hai già)
2. Poi:
   ```bash
   git remote add origin git@github.com:<tuo-utente>/PlayGround.git
   git push -u origin main
   ```
   `-u` collega il tuo `main` locale a `origin/main`: dalla volta dopo basta `git push`.
</details>

### 2. Push e pull

```bash
# modifichi qualcosa, poi:
git add .
git commit -m "docs: aggiorna readme"
git push                  # manda i tuoi commit su GitHub
```

Simula un collega: su github.com modifica il `README.md` direttamente dal browser (icona ✏️) e fai commit.
Poi sul tuo PC:
```bash
git pull                  # scarica e integra i commit nuovi
```

> 💡 `git pull` = `git fetch` (scarica) + `git merge` (integra). `git fetch` da solo scarica senza toccare i tuoi file: utile per "guardare" prima.

### 3. Clonare

Quello che farà un tuo collega:
```bash
cd /tmp
gh repo clone <tuo-utente>/PlayGround
# oppure: git clone git@github.com:<tuo-utente>/PlayGround.git
```

### 4. Proteggi `main` 🔒

Questa è la regola più importante per lavorare in gruppo: **nessuno scrive direttamente su `main`**,
tutto passa da Pull Request controllate.

Su GitHub: *Settings* → *Rules* → *Rulesets* → *New branch ruleset*:
- **Name**: `proteggi-main`
- **Enforcement status**: Active
- **Target branches**: *Add target* → *Include default branch*
- Spunta:
  - ✅ Restrict deletions
  - ✅ Require a pull request before merging → *Required approvals*: `1` (se lavori da solo per ora: `0`)
  - ✅ Require status checks to pass → aggiungi `Build .NET` e `Build immagine Docker` (compaiono dopo la prima esecuzione della CI, lezione 06)
  - ✅ Block force pushes

Prova: fai un commit su `main` e `git push`. Deve essere **rifiutato**. È giusto così.

> ⚠️ Sui repo **privati** con account gratuito alcune regole non sono applicate. Se non funzionano, rendi il repo pubblico (è un progetto di prova) oppure accetta che siano "promemoria".

## 🏋️ Esercizio

1. Clona il repo in una seconda cartella (`/tmp/PlayGround-collega`).
2. Fai un commit dalla cartella "collega" e pushalo (prima di attivare la protezione di `main`).
3. Torna nella cartella originale e fai `git pull`. Vedi il commit del "collega"?

## ✅ Checklist

- [ ] Il repo è su GitHub e `git remote -v` mostra `origin`
- [ ] So la differenza tra `fetch`, `pull` e `push`
- [ ] `main` è protetto e un push diretto viene rifiutato

➡️ Prossima: [04 · Branch e Pull Request](04-branch-e-pr.md)
