#!/bin/bash

checkPID() {
    local PID=$1
    if [[ -z $PID ]]; then
        return 0
    fi
    echo $(ps -p $PID -o args | grep -v ARGS )
}

startWebserver() {
    ruby app.rb &> /dev/null &
    PID=$(( $$ + 1 ))
    echo $PID > server.pid
    echo "Webserver started."
}

getPID() {
    if [ -f 'server.pid' ]; then
        echo $(cat server.pid)
    fi
}

stopWebserver() {
    PID=$(getPID)
    status=$(checkPID $PID)
    if [[ -z $status ]]; then
        echo "The webserver is not running."
    else
        kill $PID
        rm server.pid
        echo "Webserver stopped."
    fi
}

statusWebserver() {
    PID=$(getPID)
    if [[ ! -z $(checkPID $PID) ]]; then
        echo "The webserver is running."
    else
        echo "The webserver is not running."
    fi
}

main() {
    if [[ $# -eq 0 ]]; then
        echo "Usage for \"$0\": \`./$0 start|status|stop\`"
        return 1
    else
        if [ 'start' == $1 ]; then
            startWebserver
        elif [ 'stop' == $1 ]; then
            stopWebserver
        elif [ 'status' == $1 ]; then
            statusWebserver
        else
          echo "Usage for \"$0\": \`./$0 start|status|stop\`"
          return 1
      fi
    fi
}

main $@

