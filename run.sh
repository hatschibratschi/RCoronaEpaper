# run in crontab with
# 10 15 * * * ~/git/RCoronaEpaper/run.sh > /dev/null 2>&1

cd ~/git/RCoronaEpaper
wget -O 'covid19_dashboard_ages_data.zip' 'https://covid19-dashboard.ages.at/data/data.zip'
R --no-save < dataGgplot.R
cd ~/git/e-Paper/RaspberryPi_JetsonNano/python
python3 examples/epaper_simple.py
