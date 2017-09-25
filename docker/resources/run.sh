#!/bin/bash
NAME=`dd if=/dev/urandom count=1 2>/dev/null | md5sum | cut -d' ' -f1`
docker run -d --name $NAME ir_lab_image /lab01 /sbin/nothingtosee /bin/sleep 600
docker exec -it --name $NAME /bin/bash
