#!/bin/bash

do_build=false
do_cluster=false
do_help=false

if [[ $# -eq 0 ]]
then
  do_help=true
fi

param=$1
while [ "$param" != "" ]
do
  param=$(echo $param | awk '{print  toupper($0)}')

  case $param in
    "-B")
      do_build=true
      ;;

    "-H")
      do_help=true
      ;;

    "-C")
      do_cluster=true
      ;;
  esac

  shift
  param=$1
done

if [ "$do_help" = true ]
then
  cat <<EOF

***********************************************
Options:

-b : Build the Image
-c : Run the Helm Chart to build the Cluster
-h : Show this message

***********************************************
EOF
fi