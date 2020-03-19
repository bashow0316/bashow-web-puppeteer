#!/bin/bash

# delete-elasticsearch-index.sh
# author : bashow
# 2020/03/19

VERSION="0.0.9"

cat speedline.conf | while read name url
do
  curl -X DELETE localhost:9200/index-$name > /dev/null 2>&1
done

