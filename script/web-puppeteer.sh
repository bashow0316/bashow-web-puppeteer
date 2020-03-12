#!/bin/bash

# web-puppeteer.sh
# author : bashow
# 2020/03/11

## timestamp
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

## puppeteer trace

### http://www.wide.ad.jp/
node trace.js json/wide.json http://www.wide.ad.jp/

### https://www.sindan-net.com/
node trace.js json/sindan.json https://www.sindan-net.com/

### https://www.google.com/
node trace.js json/google.json https://www.google.com/

## Elasticsearch post

### wide.json
curl -s -H "Content-type: application/json" -X POST http:\/\/localhost:9200/wide-index/wide-puppeteer/$current_time -d @json/wide.json > /dev/null 2>&1

### sindan.json
curl -s -H "Content-type: application/json" -X POST http:\/\/localhost:9200/sindan-index/sindan-puppeteer/$current_time -d @json/sindan.json > /dev/null 2>&1

### google.json
curl -s -H "Content-type: application/json" -X POST http:\/\/localhost:9200/google-index/google-puppeteer/$curent_time -d @json/google.json > /dev/null 2>&1

## Remove json
rm -rf json/*
