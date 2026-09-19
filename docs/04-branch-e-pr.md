# 04 · Branch e Pull Request

🎯 **Obiettivo:** lavorare come in un team vero: branch, Pull Request, review, merge, conflitti.

## 📖 Concetti

### Branch

Un **branch** è una linea di sviluppo parallela. Crei un branch, ci lavori quanto vuoi,
e `main` resta intatto finché non decidi di unire il lavoro.

```
main      ●───●───────────────●   (merge)
               \             /
feat/12         ●───●───●───●
```

### GitHub Flow

Il flusso più semplice e più usato, quello che adottiamo:

1. `main` è **sempre funzionante** e pronto per il rilascio
2. Per ogni cosa (feature, fix...) crei un **branch** da `main`
3. Quando hai finito apri una **Pull Request** (PR)
4. La **CI** controlla che tutto compili, un **collega** revisiona
5. Si fa **merge** in `main` e si cancella il branch

### Pull Request

Una PR è una **richiesta di unire** il tuo branch in `main`. Ma è soprattutto un **luogo di discussione**:
i colleghi vedono le differenze, commentano le singole righe, suggeriscono modifiche.

## 🛠️ Pratica: il ciclo completo

### 1. Parti da una issue

```bash
gh issue create --title "Aggiungi pagina About" --body "Una pagina che spiega cos'è il progetto"
```
Supponiamo che GitHub le assegni il numero **#1**.

### 2. Crea il branch

```bash
git switch main
git pull                           # parti SEMPRE da main aggiornato
git switch -c feat/1-pagina-about  # crea il branch e ci si sposta
git branch                         # l'asterisco indica dove sei
```

### 3. Lavora e committa

Crea `PlayGround/Components/Pages/About.razor`:
```razor
@page "/about"

<PageTitle>About</PageTitle>

<h1>About</h1>
<p>Progetto palestra per imparare Git, GitHub e Docker.</p>
```
Aggiungi il link in `Components/Layout/NavMenu.razor` (copia uno dei `<div class="nav-item ...">` esistenti).
Premi F5 e verifica che funzioni. Poi:
```bash
git add .
git commit -m "feat: aggiungi pagina about"
```

### 4. Pusha il branch e apri la PR

```bash
git push -u origin feat/1-pagina-about
gh pr create --fill --web
```
Nel browser vedrai il **template** della PR (da `.github/pull_request_template.md`). Compilalo
e scrivi `Closes #1`: quando la PR verrà unita, la issue si chiuderà da sola.

### 5. La review

Nella PR, tab **Files changed**:
- clicca sul `+` accanto a una riga per commentarla
- *Review changes* → **Comment** / **Approve** / **Request changes**

Se ti chiedono modifiche: **non** aprire una nuova PR. Continua a committare sullo **stesso branch**
e fai `git push`: la PR si aggiorna da sola.

> 👥 Da solo non puoi approvare le tue PR. Chiedi a un amico di diventare collaboratore
> (*Settings → Collaborators*), oppure per ora metti le approvazioni richieste a 0.

### 6. Merge

GitHub offre tre modi. **Usiamo "Squash and merge"**: tutti i commit del branch diventano
**un solo commit** su `main`, con il titolo della PR. Storia di `main` pulita, un commit = una funzionalità.

| Modo | Risultato su `main` |
|------|---------------------|
| Create a merge commit | tutti i commit del branch + un commit di merge |
| **Squash and merge** ✅ | un solo commit per PR |
| Rebase and merge | tutti i commit del branch, in fila, senza merge commit |

Suggerimento: in *Settings → General → Pull Requests* lascia attivo solo **Allow squash merging**
e attiva **Automatically delete head branches**.

### 7. Riallinea il tuo PC

```bash
git switch main
git pull
git branch -d feat/1-pagina-about    # cancella il branch locale
git fetch --prune                    # dimentica i branch remoti cancellati
```

## 💥 I conflitti

Un conflitto avviene quando **due branch modificano le stesse righe**. Git non sa quale versione tenere
e chiede a te. **Non è un errore, è una domanda.**

### Provocane uno (apposta)

```bash
git switch main && git pull
git switch -c exp/a
# in Home.razor cambia <h1>Hello, world!</h1> in <h1>Ciao A</h1>
git commit -am "feat: titolo A"
git switch main
git switch -c exp/b
# in Home.razor cambia la STESSA riga in <h1>Ciao B</h1>
git commit -am "feat: titolo B"
git merge exp/a          # 💥 CONFLICT
```

Apri `Home.razor`, vedrai:
```
<<<<<<< HEAD
<h1>Ciao B</h1>
=======
<h1>Ciao A</h1>
>>>>>>> exp/a
```
- sopra `=======` c'è la versione del branch dove sei (`HEAD`)
- sotto c'è quella che stai unendo

VS Code mostra i bottoni *Accept Current* / *Accept Incoming* / *Accept Both*, oppure usa il **Merge Editor**.
Scegli il risultato finale, **cancella i marcatori** `<<<<<<<`, `=======`, `>>>>>>>`, poi:
```bash
git add PlayGround/Components/Pages/Home.razor
git commit                 # conclude il merge
```
Se ti perdi: `git merge --abort` torna a prima del merge.

Pulizia: `git switch main && git branch -D exp/a exp/b`

> 💡 Come evitare conflitti: branch **piccoli e brevi** (1-2 giorni), `git pull` spesso, e parlatevi
> quando due persone toccano lo stesso file.

## 🏋️ Esercizio

1. Apri una issue "Il contatore deve incrementare di 2".
2. Fai tutto il ciclo: branch → commit → PR con `Closes #N` → merge squash → pulizia.
3. Controlla che la issue si sia chiusa da sola.

## ✅ Checklist

- [ ] So creare un branch dal `main` aggiornato
- [ ] So aprire una PR e collegarla a una issue
- [ ] So aggiornare una PR con nuovi commit
- [ ] Ho risolto un conflitto senza panico

➡️ Prossima: [05 · Docker](05-docker.md)
