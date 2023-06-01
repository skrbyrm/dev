import schedule
import time
import subprocess

def run_script():
    subprocess.call(["python", "scrap.py"])

# Schedule the script to run at  08:00 AM
schedule.every().day.at("08:00").do(run_script)

while True:
    schedule.run_pending()
    time.sleep(1)
