# MongoDB
function mongodb(){
  method=$1;
  if [ "$method" = "start" ]; then
    shift; mongod --dbpath /data/db $*
	elif [ "$method" = "stop" ]; then    
    pid=`pidof mongod`
    shift
    kill -2 $pid $*
  elif [ "$method" = "repair" ]; then
    shift; mongod --dbpath /data/db --repair $*
	elif [ "$method" = "shell" ]; then
    shift; mongo $*
  else
    mongo $*
  fi
}