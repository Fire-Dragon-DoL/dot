# Dot

A chat bot built using [Lita](https://www.lita.io/)

## Required environment variables

- `PORT` port for HTTP routes of lita, defaults to 3000 if omitted
- `REDIS_URL` url representing Redis connection configuration
- `DOT_ADMIN_ID` string representing the admin bot user ID on Slack
- `DOT_SLACK_TOKEN` access token to the Slack API
- `DOT_URL1` url referencing dataclip for **Top clicks** command
- `DOT_URL2` url referencing dataclip for **Reddit** command
- `DOT_URL3` url referencing dataclip for **City Requests** command

## Available commands

- `@dot what are the top sources of clicks of all time?`
- `What's the latest reddit topic?` (no need to `@dot`)
- `@dot How many requests for Alexandria last week?`
