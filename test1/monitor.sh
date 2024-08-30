ipprometheus="192.168.1.2:9090"
ipprometheus_backup="192.168.1.5:9090"
current_up=1
now_up=1



while true; do
  now_up="$(curl -s "$ipprometheus_backup/api/v1/query?query=up" | jq -r '.data.result[] | select(.metric.instance == "192.168.1.2:9090") | .value[1]')"
  if [ "$now_up" != "$current_up" ]; then
    if [ "$now_up" = "0" ]; then
      echo "down"
      cp /app/prometheus.yml /app/prometheus_backup.yml
      curl -X POST http://$ipprometheus_backup/-/reload
      echo "done"
    else 
      echo "up"
      cp /app/config_monitor.yml /app/prometheus_backup.yml
      curl -X POST http://$ipprometheus_backup/-/reload
      curl -X POST http://$ipprometheus/-/reload
      echo "donex2"
    fi
  fi
  current_up="$now_up"
  sleep 5
done
