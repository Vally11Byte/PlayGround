# 🗺️ Il percorso

Questa guida ti porta da zero a saper lavorare in team con Git, GitHub e Docker,
usando questo progetto come terreno di prova. **Puoi rompere tutto: è fatto apposta.**

## Come usarla

- Segui le lezioni **in ordine**: ognuna usa quello che hai fatto nella precedente.
- Ogni lezione ha: 🎯 obiettivo → 📖 concetti → 🛠️ pratica → 🏋️ esercizio → ✅ checklist.
- **Scrivi i comandi a mano** invece di copiarli: è così che ti restano in testa.
- Se ti blocchi, guarda [99-cheatsheet.md](99-cheatsheet.md) (c'è anche "come annullare qualsiasi cosa").

## Le tappe

| #  | Lezione | Cosa impari | Tempo |
|----|---------|-------------|-------|
| 01 | [Setup dell'ambiente](01-setup.md) | Installare e configurare tutto, F5 in VS Code | 30 min |
| 02 | [Git in locale](02-git-basi.md) | Repository, commit, storia, `.gitignore` | 1 h |
| 03 | [Il repo su GitHub](03-github.md) | Remote, push, pull, clone, protezione di `main` | 45 min |
| 04 | [Branch e Pull Request](04-branch-e-pr.md) | GitHub Flow, review, merge, conflitti | 1,5 h |
| 05 | [Docker](05-docker.md) | Immagini, container, Dockerfile, Compose | 1,5 h |
| 06 | [CI con GitHub Actions](06-ci.md) | Build automatica ad ogni PR | 45 min |
| 07 | [Tag e Release](07-release-e-tag.md) | SemVer, tag, changelog, immagini su ghcr.io | 1 h |
| 08 | [Lavorare in gruppo](08-lavoro-in-gruppo.md) | Issue, board, regole di team, rebase | 1 h |
| 09 | [Deploy su un server](09-deploy-server.md) | Mettere online l'immagine rilasciata | 1 h |
| ★  | [Cheatsheet](99-cheatsheet.md) | Tutti i comandi in una pagina | — |

## Il quadro generale (rileggilo alla fine)

```
  Tu (VS Code, F5)
      │  git commit
      ▼
  branch feat/...  ──git push──▶  GitHub  ──▶  Pull Request
                                              │  CI: compila? Docker builda?
                                              │  review di un collega
                                              ▼
                                            main
                                              │  git tag v1.2.0 + push
                                              ▼
                                   Workflow "Release"
                                   ├─▶ immagine ghcr.io/…:1.2.0
                                   └─▶ GitHub Release con note
                                              │
                                              ▼
                               Server: docker compose pull && up -d
```

Alla fine del percorso saprai fare **ogni freccia** di questo disegno, e sapere *perché* esiste.
