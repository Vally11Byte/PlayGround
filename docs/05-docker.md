# 05 · Docker

🎯 **Obiettivo:** impacchettare l'app in un'immagine Docker e farla girare in un container.

## 📖 Concetti

**Il problema:** "sul mio PC funziona". Sul server manca .NET, c'è la versione sbagliata, manca una libreria...

**La soluzione:** spedire l'app **insieme a tutto quello che le serve** per girare.

| Termine | Analogia | Cos'è |
|---------|----------|-------|
| **Dockerfile** | la ricetta | istruzioni per costruire l'immagine |
| **Immagine** | la torta surgelata | pacchetto immutabile: sistema minimo + runtime + la tua app |
| **Container** | la torta scongelata sul tavolo | un'immagine **in esecuzione**. Ne puoi avviare quanti vuoi dalla stessa immagine |
| **Registry** | il supermercato | dove si pubblicano le immagini (Docker Hub, **ghcr.io**) |
| **Tag** | l'etichetta | la versione dell'immagine: `playground:1.2.0` |
| **Layer** | gli strati | ogni istruzione del Dockerfile crea uno strato, che viene messo in cache |

Un container **non** è una macchina virtuale: condivide il kernel del tuo sistema, quindi parte in un attimo e pesa poco.

## 📖 Leggiamo il `Dockerfile`

Apri il [`Dockerfile`](../Dockerfile). È **multi-stage**:

```
Stage "build"  (immagine sdk:10.0, ~900 MB)
  ├─ copia il .csproj, dotnet restore     ← in cache finché non cambi dipendenze
  ├─ copia il codice
  └─ dotnet publish → /app/publish
              │
              │ copia SOLO il risultato
              ▼
Stage "final"  (immagine aspnet:10.0, ~230 MB)
  └─ dotnet PlayGround.dll
```

Perché due stage? L'SDK serve per **compilare**, ma non per **eseguire**. L'immagine finale è
più piccola, più veloce da scaricare e più sicura (niente compilatore, niente sorgenti).

Altre cose da notare:
- `ARG VERSION` → la versione viene passata da fuori e finisce nella home page dell'app
- `EXPOSE 8080` + `ASPNETCORE_HTTP_PORTS=8080` → dentro il container l'app ascolta sulla 8080
- `USER $APP_UID` → l'app non gira come root (buona pratica di sicurezza)
- `.dockerignore` → cosa **non** mandare a Docker (bin, obj, .git...): build più veloci

## 🛠️ Pratica

### 1. Build a mano

```bash
cd ~/Work/repos/PlayGround
docker build -t playground:dev --build-arg VERSION=0.1.0-prova .
docker images                  # la vedi nell'elenco?
```
Il `.` finale è il **contesto**: la cartella che viene mandata a Docker.

Rilancia lo stesso comando: ci mette un secondo. Sono i **layer in cache**.
Ora cambia un `.razor` e rilancia: nota che il `restore` resta in cache (`CACHED`), rifà solo il publish.

### 2. Avvia un container

```bash
docker run --rm -p 8080:8080 --name pg playground:dev
```
- `-p 8080:8080` → **porta del tuo PC : porta del container**. Senza, l'app è irraggiungibile.
- `--rm` → cancella il container quando lo fermi
- `--name pg` → un nome comodo

Apri http://localhost:8080 → in home vedi `Versione: 0.1.0-prova`. `Ctrl+C` per fermarlo.

Prova `-p 9000:8080`: ora l'app è su http://localhost:9000. Capito cosa fa `-p`?

### 3. In background ed esplorazione

```bash
docker run -d -p 8080:8080 --name pg playground:dev   # -d = detached (in background)
docker ps                        # container attivi
docker logs -f pg                # log in tempo reale (Ctrl+C per uscire dai log)
docker exec -it pg bash          # entra DENTRO il container
  ls /app                        #   i file pubblicati
  whoami                         #   "app", non root
  exit
docker stop pg && docker rm pg   # ferma e rimuovi
```

### 4. Docker Compose

Scrivere `docker run` con tutte le opzioni è scomodo e soggetto a errori. **Compose** descrive tutto
in un file: [`compose.yaml`](../compose.yaml).

```bash
docker compose up --build        # builda e avvia (Ctrl+C per fermare)
docker compose up --build -d     # in background
docker compose ps
docker compose logs -f
docker compose down              # ferma e rimuove
```

Oppure da VS Code: `Ctrl+Shift+P` → *Tasks: Run Task* → **docker: avvia (compose up)**.

Il vero potere di Compose arriva con **più servizi**: app + database + cache, tutti con un comando.
(Vedi esercizio bonus.)

### 5. Fai pulizia ogni tanto

```bash
docker system df          # quanto spazio stai usando
docker image prune        # cancella le immagini "orfane"
docker system prune       # cancella tutto ciò che non è in uso (chiede conferma)
```

## 🏋️ Esercizi

1. Avvia **due** container dalla stessa immagine, su porte diverse (8081 e 8082). Aprili entrambi.
2. Cambia `ASPNETCORE_ENVIRONMENT` in `Development` in `compose.yaml`, riavvia, e guarda come cambiano i log.
3. **Bonus:** aggiungi a `compose.yaml` un servizio `db` con l'immagine `postgres:17`
   (serve la variabile `POSTGRES_PASSWORD`) e un volume per i dati. Avvia tutto con un solo comando.
   Poi committa il lavoro in un branch e apri una PR come nella lezione 04!

## ✅ Checklist

- [ ] So la differenza tra immagine e container
- [ ] So spiegare perché il Dockerfile ha due stage
- [ ] So cosa fa `-p 8080:8080`
- [ ] So leggere i log ed entrare in un container
- [ ] Uso `docker compose` invece di lunghi `docker run`

➡️ Prossima: [06 · CI con GitHub Actions](06-ci.md)
