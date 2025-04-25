#!/bin/bash

# File Flask Anda (ganti 'app:app' dengan nama file dan objek app Anda)
# Contoh: jika file Anda bernama main.py dan variabel Flask app bernama 'app', gunakan 'main:app'
FLASK_APP_FILE="app:app"

# File Bot Telegram Anda
TELEGRAM_BOT_FILE="bot.py"

# Port yang diberikan oleh Koyeb
PORT=8080
# Gunakan Gunicorn untuk menjalankan Flask di port ini
echo "Starting Flask app with Gunicorn on port $PORT..."
# Jalankan Gunicorn di latar belakang
gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 "$FLASK_APP_FILE" &
# Anda bisa menyesuaikan --workers dan --threads

# Jalankan bot Telegram di latar belakang
echo "Starting Telegram bot..."
python "$TELEGRAM_BOT_FILE" &

# Tangkap ID proses (PID) dari proses yang baru saja dijalankan di latar belakang
FLASK_PID=$!
BOT_PID=$! # Mungkin sama jika dijalankan sangat cepat, tapi tidak masalah untuk wait

echo "Flask PID: $FLASK_PID, Bot PID: $BOT_PID"

# Tunggu hingga salah satu proses latar belakang selesai
# Ini akan menjaga kontainer tetap berjalan selama salah satu script berjalan


echo "One of the processes has finished. Container may stop."
