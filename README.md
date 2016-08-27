```
docker build -t schmich/purify .
sudo docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN --restart always schmich/purify --log-facility=- --log-queries
sudo docker run -d -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN --restart always schmich/purify --log-facility=-
```
