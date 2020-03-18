#!/bin/bash

# web-speedline.sh
# author : bashow
# 2020/03/11

VERSION="0.0.9"

tjson=trace-json
slout=speedline-out
pjson=parser-json

mkdir -p $tjson
mkdir -p $slout
mkdir -p $pjson



cat web-speedline.conf | while read name url
do
  ## timestamp
  current_time=$(date "+%Y.%m.%d-%H.%M.%S")

  # echo $url
  # echo $name

  ## puppeteer and speedline
  node trace.js $url $tjson/trece-$name.json
  speedline $tjson/trece-$name.json > $slout/speedline-$name
  ## parser
  python3 speedline-parser.py $slout/speedline-$name $pjson/parser-$name.json

  ## input elasticsearch
  curl -s -H "Content-type: application/json" -X POST http:\/\/localhost:9200/index-$name/$name-speedline/$current_time -d @$pjson/parser-$name.json # > /dev/null 2>&1
done

## Remove json csv
# rm trace-json/*
# rm speedline-csv/*
# rm jq-json/*
