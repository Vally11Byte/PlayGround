# syntax=docker/dockerfile:1
#
# Build "multi-stage":
#   1. stage "build"   -> immagine grande con l'SDK, compila e pubblica l'app
#   2. stage "final"   -> immagine piccola con solo il runtime ASP.NET + i file pubblicati
# L'immagine finale non contiene ne' l'SDK ne' il codice sorgente.

# ---------- Stage 1: build ----------
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Versione dell'app, passata dall'esterno (es. dalla pipeline di release: --build-arg VERSION=1.2.0)
ARG VERSION=0.0.0-dev

# Prima copiamo solo il .csproj e facciamo il restore: questo layer viene
# messo in cache e non si rifa' finche' non cambiano le dipendenze.
COPY PlayGround/PlayGround.csproj PlayGround/
RUN dotnet restore PlayGround/PlayGround.csproj

# Poi copiamo tutto il resto e pubblichiamo
COPY . .
RUN dotnet publish PlayGround/PlayGround.csproj \
    -c Release \
    -o /app/publish \
    --no-restore \
    -p:Version=${VERSION}

# ---------- Stage 2: runtime ----------
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS final
WORKDIR /app

# Porta su cui ascolta l'app dentro il container
ENV ASPNETCORE_HTTP_PORTS=8080
EXPOSE 8080

COPY --from=build /app/publish .

# Le immagini .NET hanno gia' un utente non-root chiamato "app": usiamolo
USER $APP_UID

ENTRYPOINT ["dotnet", "PlayGround.dll"]
