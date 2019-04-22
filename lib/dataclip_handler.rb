require "ostruct"

module Lita
  module Handlers
    class DataclipHandler < Handler
      config :requests_over_time_by_city_url
      config :top_clicks_all_time_url
      config :reddit_comments_url

      route(/requests\sfor\s(.+)\slast\sweek/, command: true) do |response|
        url = config.requests_over_time_by_city_url
        selected_city = response.matches[0].first.to_s.downcase
        http_response = HTTParty.get(url, follow_redirects: true)
        data = JSON.
          parse(http_response.body).
          fetch("values").
          lazy.
          map do |arr|
            OpenStruct.new(week: arr[0], city: arr[1], reqs: arr[2])
          end.
          sort_by { |entry| entry.week }.
          reverse.
          select { |entry| entry.city == selected_city }.
          first

        if data.nil?
          msg = "There have been *no requests* for " \
                "#{selected_city.capitalize} last week"
        else
          msg = "#{selected_city.capitalize} received *#{data.reqs}* " \
                "requests last week"
        end

        response.reply(msg)
      rescue => err
        response.reply("Sorry, I encountered an error: **#{err}**")
        raise err
      end

      route(/top\ssources\sof\sclicks/) do |response|
        url = config.top_clicks_all_time_url
        http_response = HTTParty.get(url, follow_redirects: true)
        data = JSON.
          parse(http_response.body).
          fetch("values").
          lazy.
          map { |arr| OpenStruct.new(name: arr[0], clicks: arr[1]) }.
          take(5)

        msg = "The top 5 sources of clicks of all time are:\n"
        data.each do |source|
          msg << "- *#{source.name}* with #{source.clicks} clicks\n"
        end

        response.reply(msg)
      rescue => err
        response.reply("Sorry, I encountered an error: **#{err}**")
        raise err
      end

      route(/latest\sreddit\stopic/) do |response|
        url = config.reddit_comments_url
        http_response = HTTParty.get(url, follow_redirects: true)
        data = JSON.
          parse(http_response.body).
          fetch("values").
          lazy.
          map { |arr| OpenStruct.new(title: arr[27], created: arr[32]) }.
          sort_by { |comment| comment.created }.
          reverse.
          take(1).
          first

        msg = "The latest reddit topic is:\n\n#{data.title}"

        response.reply(msg)
      rescue => err
        response.reply("Sorry, I encountered an error: **#{err}**")
        raise err
      end

      http.get "/" do |request, response|
        response.body << "Hello, world!"
      end
    end

    Lita.register_handler(DataclipHandler)
  end
end
