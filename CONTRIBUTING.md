# Come contribuire

Regole brevi, valide per tutti. Il perché di ogni regola è spiegato in [docs/](docs/00-percorso.md).

## Il flusso (GitHub Flow)

1. **Ogni lavoro parte da una issue.** Se non c'è, creala.
2. **Aggiorna `main`** prima di iniziare:
   ```bash
   git switch main
   git pull
   ```
3. **Crea un branch** con un nome parlante:
   ```bash
   git switch -c feat/12-pagina-contatti
   ```
   Formato: `<tipo>/<numero-issue>-<descrizione-breve>`
4. **Fai commit piccoli** con messaggi chiari (vedi sotto).
5. **Pusha e apri una Pull Request** verso `main`. Scrivi `Closes #12` nella descrizione.
6. **Aspetta la CI verde e almeno una review** approvata.
7. **Merge con "Squash and merge"**, poi cancella il branch.

> ⛔ Nessuno fa push diretto su `main`.

## Messaggi di commit (Conventional Commits)

```
<tipo>: <cosa fa, al presente, minuscolo>
```

| Tipo       | Quando                                | Esempio                                   |
|------------|---------------------------------------|-------------------------------------------|
| `feat`     | nuova funzionalità                    | `feat: aggiungi pagina contatti`          |
| `fix`      | correzione di un bug                  | `fix: contatore non si azzera`            |
| `docs`     | solo documentazione                   | `docs: spiega come fare una release`      |
| `refactor` | riorganizzi il codice senza cambiarne il comportamento | `refactor: estrai servizio meteo` |
| `chore`    | manutenzione, config, dipendenze      | `chore: aggiorna immagine .NET`           |
| `ci`       | modifiche alle GitHub Actions         | `ci: aggiungi cache alla build`           |

Aggiungi `!` se rompi qualcosa di esistente: `feat!: cambia formato API`.

## Versioni e release

Usiamo [Semantic Versioning](https://semver.org/lang/it/): `MAJOR.MINOR.PATCH`.
Le release le fa chi mantiene il progetto, con un tag `vX.Y.Z` su `main`.
Procedura completa: [docs/07-release-e-tag.md](docs/07-release-e-tag.md).
