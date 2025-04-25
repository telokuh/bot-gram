#!/bin/bash

# Jalankan script1.py di latar belakang (&)
echo "Running script1.py..."
python3 app.py &

# Jalankan script2.py di latar belakang (&)
echo "Running script2.py..."
python3 bot.py &

# Tunggu hingga semua proses di latar belakang selesai
# Ini penting agar kontainer tetap berjalan selama script Python berjalan
wait -n

echo "All scripts finished."
