set -e

cp /app/config_monitor.yml /app/prometheus_backup.yml
/app/run.sh
apt-get update

apt-get install -y curl jq

/app/monitor.sh
#tail -f /dev/null