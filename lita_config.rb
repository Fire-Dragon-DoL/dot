require_relative "./lib/dataclip_handler"

Lita.configure do |config|
  config.robot.name = "Dot"

  config.robot.locale = :en

  config.robot.log_level = :info
  config.robot.admins = [ENV.fetch("DOT_ADMIN_ID")]

  config.robot.adapter = :slack
  config.adapters.slack.token = ENV.fetch("DOT_SLACK_TOKEN")
  config.adapters.slack.link_names = true
  config.adapters.slack.parse = "full"
  config.adapters.slack.unfurl_links = true
  config.adapters.slack.unfurl_media = true

  config.redis = { host: "127.0.0.1", port: 6379 }

  dataclip = config.handlers.dataclip_handler
  dataclip.top_clicks_all_time_url = ENV.fetch("DOT_URL1")
  dataclip.reddit_comments_url = ENV.fetch("DOT_URL2")
  dataclip.requests_over_time_by_city_url = ENV.fetch("DOT_URL3")
end
