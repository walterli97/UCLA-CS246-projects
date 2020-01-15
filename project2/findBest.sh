#!/bin/bash

curl -XPOST 'http://localhost:9200/task2/_close'
k1=(0.00 0.80 1.20 1.60 2.00)
b=(0.00 0.25 0.50 0.75 1.00)
for k1 in 0.00 0.80 1.20 1.60 2.00 
do
    for b in 0.00 0.25 0.50 0.75 1.00
    do
        curl -XPOST 'http://localhost:9200/task2/_close'
        sleep 1
        curl -XPUT 'http://localhost:9200/task2/_settings' -d '
        {
            "index": {
                "similarity": {
                    "default": {
                        "type": "BM25",
                        "k1": '$k1',
                        "b": '$b'
                    }
                }
            }
        }'
        sleep 1
        curl -XPOST 'http://localhost:9200/task2/_open'
        sleep 1
        ./benchmark.sh task2
        echo $k1  $b
        sleep 1
    done
done
