# netsimon (NET Speed Index MONitoring) v1.0

Netsimon is an application that monitors the speed index of a web pages.

Kibana Dashborad Image
![Screenshot](https://raw.githubusercontent.com/bashow0316/monitoring-speedindex/master/images/Screenshot-SpeedIndex-Kibana.png)

## Make Docker container

## QuickStart

ubuntu

### 1. Install netsimon

``` shell
git clone https://github.com/bashow0316/netsimon.git
```

#### 2. APT install app

``` shell
sudo apt install chromium-browser
sudo apt install npm
```

#### 3. npm install

cd dir

Install puppeteer & speedline

``` shell
cd netsimon/script
npm i puppeteer
npm i speedline
```

### 4. docker-compose

``` shell
cd netsimon
sudo mkdir elastic01-data && sudo chown -R 1000:1000 elastic01-data
sudo docker-compose up -d
```

### 5. Testing

``` shell
cd netsimon/script
./speedline.sh
```

Access kibana

http://localhost:5601

Check elasticsearch index

`Management` > `Index patterns` > `Create index pattern`

Index pattern

```
index-*
```

Click `Discover`

### 6. cron.d

Change user at cron.d/netsimon

``` shell
cd netsimon/cron.d
vi netsimon
(Change user)
```

Move cron.d/netsimon

``` shell
cd netsimon/cron.d
sudo cp netsimon /etc/cron.d/
sudo systemctl restart cron.service
```

### 7. Kibana dashboard

Make kibana dashboard

Sample dashboard

``` text
netsimon/kibana-object/export.ndjson
```

### Option

Change Web page list

Chage file

``` text
netsimon/script/speedline.conf
```

Sample

``` text
name URL
```

## Speed Index

- https://developers.google.com/web/tools/lighthouse/audits/speed-index
- https://sites.google.com/a/webpagetest.org/docs/using-webpagetest/metrics/speed-index

## Use application

- Docker
- Docker-compose
- puppeteer
- speedline
- Elasticsearch
- Kibana

### Docker

- https://www.docker.com/


### Docker-compose

- https://docs.docker.com/compose/

### puppeteer

- https://developers.google.com/web/tools/chrome-devtools
- https://github.com/puppeteer/puppeteer


Page tracing

- https://github.com/puppeteer/puppeteer/blob/master/docs/api.md#pagetracing
- https://github.com/puppeteer/puppeteer/blob/master/docs/api.md#class-tracing

### speedline

- https://developers.google.com/web/tools/lighthouse/audits/speed-index
- https://sites.google.com/a/webpagetest.org/docs/using-webpagetest/metrics/speed-index
- https://github.com/paulirish/speedline

## Respect applications

- https://github.com/netdata/netdata
- https://developers.google.com/web/tools/chrome-devtools/
- https://github.com/GoogleChrome/lighthouse
