This is a Dockerfile setup for transmission - https://www.transmissionbt.com

To run:

```
docker run -d --name="transmission" -v /path/to/transmission/conf:/config -v /path/to/downloads:/downloads -v /etc/localtime:/etc/localtime:ro -p 9091:9091 -p 51413:51413 pcjacobse/transmission
```
