# Üterbot

![Üter Zörker](http://vignette2.wikia.nocookie.net/simpsons/images/5/5f/Tapped_Out_Uter_Unlock_Artwork.png/revision/latest?cb=20151004202729)

A menubot for slack

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
