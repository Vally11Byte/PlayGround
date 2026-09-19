# 08 · Lavorare in gruppo

🎯 **Obiettivo:** organizzare il lavoro di più persone senza pestarsi i piedi.

## 📖 Le regole del team (in breve)

1. **`main` è sacro**: sempre funzionante, si tocca solo via PR.
2. **Niente lavoro senza issue**: così tutti sanno chi fa cosa.
3. **Branch piccoli e brevi**: una PR al giorno è meglio di una alla settimana.
4. **CI verde + 1 approvazione** prima del merge.
5. **Chi apre la PR la unisce**, dopo l'approvazione. Chi revisiona non fa merge al posto tuo.
6. **Mai force push su branch condivisi.** Sul *tuo* branch personale si può, con cautela.
7. **Nessun segreto nel repository**: password e chiavi vanno nei *Secrets* di GitHub o in file ignorati.

## 🛠️ Pratica

### 1. Invita i collaboratori

*Settings → Collaborators → Add people*. Loro riceveranno un invito via email.

### 2. Organizza le issue

- **Labels**: `bug`, `enhancement`, `good first issue`, `help wanted`... (i template in `.github/ISSUE_TEMPLATE/` ne applicano alcune in automatico)
- **Assignees**: chi ci sta lavorando. Assegnati una issue **prima** di iniziare, così nessuno la fa in doppio.
- **Milestones**: raggruppa le issue per rilascio (es. milestone `v1.2.0`)

```bash
gh issue list
gh issue list --assignee @me
gh issue edit 5 --add-assignee @me --add-label "bug"
```

### 3. La board (GitHub Projects)

Sul tuo profilo → *Projects* → *New project* → template **Board**. Colonne: *Todo → In progress → In review → Done*.
Collega il repo e aggiungi le issue. È la vista d'insieme di "chi sta facendo cosa".

### 4. CODEOWNERS

Crea `.github/CODEOWNERS` per assegnare in automatico i revisori in base ai file toccati:
```
# Chi deve revisionare cosa
*                     @utente-a
/.github/             @utente-a @utente-b
/Dockerfile           @utente-b
```

### 5. La routine quotidiana

```bash
# Mattina
git switch main && git pull
gh issue list --assignee @me

# Inizio lavoro
git switch -c feat/23-descrizione

# Durante (spesso)
git add -p                   # aggiungi pezzo per pezzo, rivedendo ogni modifica
git commit -m "feat: ..."
git push

# main è andato avanti mentre lavoravi? Portati dentro le novità:
git fetch
git merge origin/main        # risolvi eventuali conflitti QUI, sul tuo branch

# Fine
gh pr create --fill
gh pr checks --watch
```

### 6. Merge vs Rebase

Per aggiornare il tuo branch con le novità di `main` hai due strade:

```
merge:   main  A───B───C                 rebase:  main  A───B───C
                \       \                                         \
         feat    X───Y───M               feat                      X'──Y'
```
- **`git merge origin/main`**: sicuro, non riscrive nulla, aggiunge un commit di merge. **Usa questo.**
- **`git rebase origin/main`**: storia lineare, ma **riscrive i tuoi commit** (nuovi hash). Poi serve
  `git push --force-with-lease`. Va bene **solo** su branch dove lavori da solo.

Con lo *Squash and merge* su `main`, i commit di merge nel tuo branch spariscono comunque: quindi `merge` è la scelta semplice e sicura.

### 7. Fare review bene

Chi revisiona:
- Scarica la PR e provala: `gh pr checkout 42` poi F5
- Commenta il **codice**, non la persona. "Qui potremmo..." invece di "Hai sbagliato..."
- Distingui: *bloccante* vs *suggerimento* (prefisso `nit:` per le piccolezze)
- Usa il pulsante **Suggest changes** per proporre la riga corretta: l'autore la applica con un click

Chi riceve la review:
- Rispondi a ogni commento, anche solo con 👍
- Non prenderla sul personale: la review migliora il **codice**, e fa imparare **entrambi**

## 🏋️ Esercizio (in due!)

Trova un amico/collega e:
1. Invitalo come collaboratore.
2. Create due issue, una a testa, **che toccano lo stesso file** (es. entrambi modificano `NavMenu.razor`).
3. Lavorate in parallelo, aprite le PR.
4. Il primo fa merge. Il secondo si ritrova in conflitto: lo risolve con `git merge origin/main` sul suo branch.
5. Revisionatevi a vicenda con almeno un commento *Suggest changes*.
6. Fate insieme una release.

## ✅ Checklist

- [ ] Ogni PR ha una issue collegata e un assegnatario
- [ ] So aggiornare il mio branch con `main`
- [ ] So quando il rebase è ok e quando no
- [ ] Ho revisionato una PR di qualcun altro

➡️ Prossima: [09 · Deploy su un server](09-deploy-server.md)
