#!/bin/bash

# init
function pause(){
   read -p "$*" 1>&2 
}

TEMP_DIR=${TMPDIR:=/tmp}
THIS_DIR=$( dirname $BASH_SOURCE )

if  [ "${PLDOC_OUTPUT}" == "" ]
then 
        pause WARN: Environment variable PLDOC_OUTPUT not set.  Creating output in ${TEMP_DIR} 
	PLDOC_OUTPUT=${TEMP_DIR}
fi


echo "${THIS_DIR}"/pldoc.sh -doctitle '"PLDoc Drag and Drop Output"' -d "${PLDOC_OUTPUT}" "$@"
"${THIS_DIR}"/pldoc.sh -doctitle '"PLDoc Drag and Drop Output"' -d "${PLDOC_OUTPUT}" "$@"

open ${PLDOC_OUTPUT}/index.html 

