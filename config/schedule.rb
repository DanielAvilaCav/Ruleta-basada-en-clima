
set :output, "log/cron_log.log"
env :PATH, ENV['PATH']

every 3.minutes do
  runner "RoundsService.play_round"
end