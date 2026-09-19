# PlayGround

App Blazor Server (.NET 10) usata come **palestra** per imparare:

- 🐙 **Git e GitHub**: commit, branch, Pull Request, code review, tag e release
- 🐳 **Docker**: immagini, container, Compose, registry
- ⚙️ **CI/CD** con GitHub Actions: build automatica e release automatica
- 👥 **Lavoro in gruppo**: issue, convenzioni, flusso condiviso

👉 **Inizia da qui: [docs/00-percorso.md](docs/00-percorso.md)**

---

## Avvio rapido

### Da VS Code (debug)

1. Apri la cartella del repository in VS Code
2. Installa le estensioni consigliate (VS Code te lo propone in basso a destra)
3. Premi **F5** → compila, avvia e apre il browser su http://localhost:5269

Nel pannello *Run and Debug* (`Ctrl+Shift+D`) trovi anche:
- **PlayGround (watch / hot reload)**: si ricarica da solo quando salvi
- **Attach a processo .NET**: per attaccarti a un'app già avviata

### Da terminale

```bash
dotnet run --project PlayGround
```

### Con Docker

```bash
docker compose up --build
# apri http://localhost:8080
```

## Struttura

```
.
├── .github/
│   ├── workflows/ci.yml        # build ad ogni push/PR
│   ├── workflows/release.yml   # release automatica sui tag v*.*.*
│   ├── ISSUE_TEMPLATE/         # modelli per aprire issue
│   └── pull_request_template.md
├── .vscode/                    # F5, task, estensioni consigliate
├── docs/                       # 📚 la guida passo passo
├── PlayGround/                 # il codice dell'app
├── Dockerfile                  # come si costruisce l'immagine
├── compose.yaml                # come si avvia in locale con Docker
├── CHANGELOG.md                # storico delle versioni
└── CONTRIBUTING.md             # regole per contribuire
```

## Contribuire

Leggi [CONTRIBUTING.md](CONTRIBUTING.md).
