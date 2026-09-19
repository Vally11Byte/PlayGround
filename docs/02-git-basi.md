# 02 · Git in locale

🎯 **Obiettivo:** trasformare la cartella in un repository e capire commit, staging e storia.

## 📖 Concetti

**Git** è una "macchina del tempo" per il codice. Ogni **commit** è una fotografia
dell'intero progetto in un momento preciso, con autore, data e un messaggio che spiega il perché.

I file passano per tre zone:

```
 Working directory  ──git add──▶  Staging area  ──git commit──▶  Repository (.git)
 (dove modifichi)                 (cosa andrà nel                (la storia)
                                   prossimo commit)
```

Perché la staging area? Perché puoi aver modificato 5 file ma voler fare **due commit separati**,
ognuno con un senso preciso. Commit piccoli e mirati = storia leggibile = bug facili da trovare.

## 🛠️ Pratica

### 1. Crea il repository

```bash
cd ~/Work/repos/PlayGround
git init
git status
```
`git init` crea la cartella nascosta `.git`: **quella è** il repository.
`git status` è il comando che userai di più: ti dice sempre dove sei e cosa è cambiato.

### 2. Il `.gitignore`

Apri `.gitignore`. Elenca ciò che **non** deve finire in Git:
- `bin/`, `obj/` → file generati dalla compilazione (si ricreano, e sono pesanti)
- file personali dell'editor
- **segreti** (password, chiavi): mai, mai nel repository

Nota che `.vscode/launch.json` e compagni sono esplicitamente *inclusi* con `!`.

### 3. Il primo commit

```bash
git add .                  # metti tutto in staging
git status                 # verde = in staging
git commit -m "chore: progetto iniziale"
git log                    # la storia (esci con q)
```

### 4. Un commit "vero"

1. In `Home.razor` cambia il testo di benvenuto.
2. Guarda cosa hai cambiato:
   ```bash
   git diff                # differenze non ancora in staging
   ```
3. Committa:
   ```bash
   git add PlayGround/Components/Pages/Home.razor
   git diff --staged       # differenze in staging
   git commit -m "feat: nuovo messaggio di benvenuto"
   ```
4. Guarda la storia compatta:
   ```bash
   git log --oneline --graph
   ```

> 💡 In VS Code, il pannello **Source Control** (`Ctrl+Shift+G`) fa le stesse cose con i click:
> il `+` accanto al file è `git add`, il ✓ è `git commit`. Usa pure la UI, ma **impara prima i comandi**:
> quando qualcosa va storto, il terminale ti dice esattamente cosa succede.

### 5. Il messaggio di commit

Usiamo **Conventional Commits** (vedi [CONTRIBUTING.md](../CONTRIBUTING.md)):
```
feat: aggiungi pagina contatti
fix: il contatore partiva da 1
docs: spiega come avviare con Docker
```
Regola d'oro: il messaggio completa la frase *"Se applicato, questo commit..."*.

### 6. Tornare indietro (senza panico)

```bash
git restore file.cs          # butta le modifiche NON in staging di un file
git restore --staged file.cs # toglie il file dalla staging (le modifiche restano)
git commit --amend           # correggi l'ULTIMO commit (solo se non l'hai ancora pushato!)
git revert <hash>            # crea un nuovo commit che annulla <hash> (sicuro, anche se pushato)
```

## 🏋️ Esercizio

1. Modifica **due** file diversi (es. `Home.razor` e `Counter.razor`).
2. Fai **due commit separati**, uno per file, con messaggi diversi.
3. Fai un terzo commit che rompe qualcosa, poi annullalo con `git revert`.
4. Con `git log --oneline` dovresti vedere 5 commit.

## ✅ Checklist

- [ ] So spiegare la differenza tra working directory, staging e commit
- [ ] Uso `git status` e `git diff` prima di ogni commit
- [ ] So perché `bin/` e `obj/` non vanno committati
- [ ] So annullare una modifica con `restore` e un commit con `revert`

➡️ Prossima: [03 · Il repo su GitHub](03-github.md)
