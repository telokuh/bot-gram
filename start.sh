#!/bin/bash

# File Flask Anda (ganti 'app:app' dengan nama file dan objek app Anda)
FLASK_APP_FILE="app:app"

# File Bot Telegram Anda
TELEGRAM_BOT_FILE="bot.py"

# Port yang diberikan oleh Koyeb
PORT=8080

while true; do
  echo "Starting Flask app with Gunicorn on port $PORT..."
  gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 "$FLASK_APP_FILE" &
  FLASK_PID=$!

  echo "Starting Telegram bot..."
  python "$TELEGRAM_BOT_FILE" &
  BOT_PID=$!

  echo "Flask PID: $FLASK_PID, Bot PID: $BOT_PID"

  # Tunggu hingga salah satu proses latar belakang selesai
  wait -n

  # Jika salah satu proses selesai, matikan yang lain, kemudian restart keduanya
  echo "One of the processes has finished. Restarting both processes..."
  kill $FLASK_PID 2>/dev/null
  kill $BOT_PID 2>/dev/null

  # Opsional: delay sebelum restart, misal 3 detik
  sleep 3
done
