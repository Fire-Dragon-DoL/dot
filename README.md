# Dot

A chat bot built using [Lita](https://www.lita.io/)

## Required environment variables

- `DOT_ADMIN_ID` string representing the admin bot user ID on Slack
- `DOT_SLACK_TOKEN` access token to the Slack API
- `DOT_DATACLIPS_PATH` path to the YML file containing the URLs to 3
  dataclips. If not provided, it defaults to `$PWD/dataclips.yml`.
  See [dataclips.example.yml](dataclips.example.yml).
