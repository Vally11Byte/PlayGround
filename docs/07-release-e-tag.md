# 07 · Tag e Release

🎯 **Obiettivo:** rilasciare versioni numerate dell'app, con immagine Docker pubblicata e note di rilascio.

## 📖 Concetti

### Perché le versioni

`main` cambia di continuo. Un **rilascio** è un punto preciso della storia a cui dai un nome
("la 1.2.0") per poter dire: *questa* è la versione in produzione, *questa* ha il bug, torniamo a *questa*.

### Semantic Versioning (SemVer)

```
  1 . 4 . 2
  │   │   └─ PATCH: correzioni di bug, nulla di nuovo       (fix:)
  │   └───── MINOR: nuove funzionalità, compatibili          (feat:)
  └───────── MAJOR: cambiamenti che rompono la compatibilità (feat!:)
```
- Quando aumenti un numero, **azzeri quelli a destra**: `1.4.2` → `1.5.0` → `2.0.0`
- `0.x.y` = "in sviluppo, può cambiare tutto". Si passa a `1.0.0` quando è stabile
- Pre-release: `1.5.0-beta.1`, `2.0.0-rc.1`

Nota come i tipi dei **Conventional Commits** ti dicono già quale numero aumentare.

### Tag

Un **tag** è un'etichetta fissa su un commit. A differenza di un branch, **non si sposta mai**.

```bash
git tag -a v1.0.0 -m "Release 1.0.0"   # tag "annotato": ha autore, data, messaggio (usa sempre questo)
git tag                                  # elenco
git show v1.0.0                          # dettagli
```
I tag **non vengono pushati** con un normale `git push`: vanno pushati esplicitamente.

### Release su GitHub

Una **Release** è una pagina su GitHub legata a un tag, con le note (cosa è cambiato) ed eventuali file.
Nel nostro progetto la crea **in automatico** il workflow [`release.yml`](../.github/workflows/release.yml).

## 📖 Cosa succede quando pushi un tag

```
git push origin v1.0.0
        │
        ▼
Workflow "Release" (trigger: tag v*.*.*)
  ├─ login su ghcr.io con il GITHUB_TOKEN (automatico, niente password da configurare)
  ├─ docker/metadata-action: da v1.0.0 calcola i tag immagine 1.0.0, 1.0, 1, latest
  ├─ build con VERSION=1.0.0 → finisce nella home page dell'app
  ├─ push su ghcr.io/<utente>/playground
  └─ gh release create --generate-notes → note generate dai titoli delle PR
```

Perché più tag sulla stessa immagine? Chi usa `:1` riceve automaticamente tutti i fix della 1.x,
chi usa `:1.0.0` è bloccato esattamente su quella versione. In produzione **usa sempre la versione esatta**.

## 🛠️ Pratica: la tua prima release

### 1. Prepara il CHANGELOG

Il [`CHANGELOG.md`](../CHANGELOG.md) è scritto **per le persone**, non per le macchine.
Via branch + PR (come sempre!), trasforma la sezione `[Unreleased]` in:
```markdown
## [Unreleased]

## [1.0.0] - 2026-09-20
### Added
- ...
```
Fai merge della PR.

### 2. Crea e pusha il tag

**Sempre da `main` aggiornato**, così il tag punta al commit giusto:
```bash
git switch main
git pull
git tag -a v1.0.0 -m "Release 1.0.0"
git push origin v1.0.0
```

### 3. Segui la release

```bash
gh run watch
gh release view v1.0.0 --web
```
Su GitHub, nella pagina del repo, a destra compaiono **Releases** e **Packages**.

### 4. Usa l'immagine rilasciata

La prima volta il package è **privato**. Per scaricarlo dal tuo PC:
```bash
gh auth refresh -s read:packages
gh auth token | docker login ghcr.io -u <tuo-utente> --password-stdin
docker run --rm -p 8080:8080 ghcr.io/<tuo-utente>/playground:1.0.0
```
Apri http://localhost:8080: in home c'è scritto **Versione: 1.0.0**. 🎉

> 💡 Il nome immagine è tutto **minuscolo** (`playground`), anche se il repo si chiama `PlayGround`: Docker non accetta maiuscole.

### 5. Una patch

1. Issue "Bug: ..." → branch `fix/N-...` → PR `fix: ...` → merge
2. Aggiorna il CHANGELOG (sezione `### Fixed`)
3. `git tag -a v1.0.1 -m "Release 1.0.1"` e push

## 🚑 Quando qualcosa va storto

**Ho creato il tag sul commit sbagliato (e NON l'ho ancora pushato):**
```bash
git tag -d v1.0.0
```

**L'ho già pushato e la release è partita:**
non riscrivere la storia. Un tag pubblicato potrebbe essere già stato scaricato da qualcuno.
Correggi il problema e rilascia **`v1.0.1`**. È la regola: *le versioni pubblicate sono immutabili*.

**Rollback in produzione:** basta tornare all'immagine precedente (`:1.0.0` invece di `:1.0.1`). Vedi lezione 09.

## 🏋️ Esercizio

1. Rilascia `v1.0.0`.
2. Aggiungi una funzionalità (`feat:`), rilascia la versione giusta. Quale? (risposta: `v1.1.0`)
3. Correggi un bug, rilascia. (`v1.1.1`)
4. Guarda le note generate automaticamente nelle Release: più i titoli delle PR sono chiari, più le note sono utili.

## ✅ Checklist

- [ ] So scegliere il numero di versione giusto
- [ ] So creare un tag annotato e pusharlo
- [ ] So trovare l'immagine su ghcr.io e avviarla
- [ ] So che una versione pubblicata non si modifica: se ne fa una nuova

➡️ Prossima: [08 · Lavorare in gruppo](08-lavoro-in-gruppo.md)
