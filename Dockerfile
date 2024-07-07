# Utiliser l'image de base Python 3.9-slim
FROM python:3.9-slim

# Créer le répertoire de travail et installer les dépendances
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le contenu de l'application
COPY service/ ./service/

# Passer à un utilisateur non-root
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Exposer le port sur lequel l'application va tourner
EXPOSE 8080

# Utiliser gunicorn comme serveur WSGI pour exécuter le service
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
