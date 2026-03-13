#!/bin/bash

# Путь к Nginx Proxy Manager сертификатам
NPM_CERT_DIR="/home/admin/element/npm/letsencrypt/live/npm-2"

# Путь к данным Synapse
SYNAPSE_DATA_DIR="/home/admin/element/synapse/data"

# Контейнер Synapse
SYNAPSE_CONTAINER="synapse"

# Копируем сертификаты
cp "$NPM_CERT_DIR/fullchain.pem" "$SYNAPSE_DATA_DIR/cert.pem"
cp "$NPM_CERT_DIR/privkey.pem" "$SYNAPSE_DATA_DIR/key.pem"

# Устанавливаем владельца и права (user внутри контейнера uid=1000)
chown 1000:1000 "$SYNAPSE_DATA_DIR/cert.pem" "$SYNAPSE_DATA_DIR/key.pem"
chmod 644 "$SYNAPSE_DATA_DIR/cert.pem" "$SYNAPSE_DATA_DIR/key.pem"

# Перезапуск контейнера Synapse
docker restart "$SYNAPSE_CONTAINER"

echo "✅ Сертификаты обновлены и контейнер Synapse перезапущен."
