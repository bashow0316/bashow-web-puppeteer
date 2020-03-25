#!/bin/bash

# web-speedline.sh
# author : bashow
# 2020/03/20

VERSION="0.0.987"

tjson=trace-json
slout=speedline-out
pjson=parse-json

mkdir -p $tjson
mkdir -p $pjson



cat speedline.conf | while read name url
do
  ## timestamp
  current_time=$(date -u "+%Y-%m-%dT%H:%M:%S")

  echo "Start puppeter and speedline"
  echo $url
  echo $name

  ## puppeteer and speedline
  node trace-speedline.js $url $tjson/trece-$name.json $pjson/parse-$name.json

  echo "End puppeteer and speedline"

  echo "Start elasticsearh post"

  ## input elasticsearch
  curl -s -H "Content-type: application/json" -X POST http:\/\/localhost:9200/index-$name/$name-speedline/$current_time -d @$pjson/parse-$name.json > /dev/null 2>&1

  echo "End elasticsearh post"

done

## Remove json csv
# rm $tjson/*
# rm $pjson/*
