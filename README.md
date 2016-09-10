# Menubot slack

## Setup
1. Install the `dotenv` gem
```
$ gem install dotenv
```

2. Create a .env, as below
```
SLACK_TOKEN=<Slack slash command token>
LOCU_API_KEY=<locu menu api key>

LATITUDE=<latitude of geo-coordinate to center from>
LONGITUDE=<longitude of geo-coordinate to center from>
RADIUS=<radius (in meters) of restaurant search from provided geo-coordinate>
```

## Run
Start the server using `dotenv`
```
$ dotenv rackup
```
