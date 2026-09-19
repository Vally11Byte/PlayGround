# 09 · Deploy su un server

🎯 **Obiettivo:** far girare una versione rilasciata su un server, aggiornarla e tornare indietro.

## 📖 L'idea

Sul server **non compili nulla** e **non cloni il repo**. Il server scarica solo l'immagine già
pronta da ghcr.io, costruita e testata dalla pipeline. Quello che gira in produzione è esattamente
quello che ha costruito la release: riproducibile.

```
GitHub (release v1.2.0) ──▶ ghcr.io/<utente>/playground:1.2.0 ──docker pull──▶ Server
```

## 🛠️ Pratica

Ti serve una macchina Linux con Docker: una VPS (Hetzner, DigitalOcean...), un Raspberry Pi,
o per esercitarti anche **il tuo stesso PC** in un'altra cartella.

### 1. Rendi pubblico il package (oppure fai login)

Su GitHub: il tuo profilo → *Packages* → `playground` → *Package settings* → *Change visibility* → Public.
Così il server può scaricarlo senza credenziali. Se vuoi tenerlo privato, sul server fai il `docker login ghcr.io`
come nella lezione 07, con un token che abbia solo `read:packages`.

### 2. Il compose di produzione

Sul server crea una cartella `~/playground` con dentro `compose.yaml`:
```yaml
services:
  playground:
    image: ghcr.io/<tuo-utente>/playground:${VERSION:-1.0.0}
    container_name: playground
    ports:
      - "80:8080"
    environment:
      ASPNETCORE_ENVIRONMENT: Production
    restart: unless-stopped
```
Differenza chiave con il `compose.yaml` del repo: qui c'è `image:` e **non** `build:`.

E un file `.env` accanto:
```
VERSION=1.0.0
```

### 3. Avvia

```bash
cd ~/playground
docker compose pull
docker compose up -d
docker compose logs -f
```
Apri `http://<ip-del-server>` → Versione: 1.0.0.

### 4. Aggiorna a una nuova versione

```bash
sed -i 's/^VERSION=.*/VERSION=1.1.0/' .env
docker compose pull
docker compose up -d        # ricrea solo il container cambiato
```

### 5. Rollback

La 1.1.0 ha un problema? Tornare indietro è la stessa operazione:
```bash
sed -i 's/^VERSION=.*/VERSION=1.0.0/' .env
docker compose up -d
```
Ecco perché le versioni devono essere **immutabili** e perché in produzione non si usa `latest`:
sai sempre esattamente cosa sta girando e puoi tornare a un punto preciso.

## 🚀 Per andare oltre

Quando hai padroneggiato tutto il resto:
- **HTTPS**: metti davanti all'app un reverse proxy come **Caddy** (ottiene i certificati da solo) o Traefik
- **Deploy automatico**: un job in `release.yml` che si collega al server via SSH ed esegue i comandi del punto 4
  (la chiave SSH va nei *Secrets* del repo). Oppure strumenti come Watchtower o Coolify
- **Environments di GitHub**: `staging` e `production`, con approvazione manuale prima del deploy in produzione
- **Healthcheck**: un endpoint `/health` nell'app e un `healthcheck:` nel compose

## ✅ Checklist finale del percorso

- [ ] Ho una versione dell'app online, scaricata da ghcr.io
- [ ] So aggiornarla e fare rollback cambiando una sola riga
- [ ] Riesco a spiegare a un collega ogni freccia del disegno in [00-percorso.md](00-percorso.md)

🎓 **Complimenti, hai finito il percorso!**
