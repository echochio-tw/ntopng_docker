# ntop_docker

pull docker
-----------
     docker pull echochio/ntopng
 
exec docker  echochio/ntopng
-----------
 
 netflow come from 9996 udp 

     docker run -d -e Flow=9996 -e Local=192.168.0.0/16 -p 3000:3000 -p 9996:9996/udp --name=ntopng echochio/ntopng
