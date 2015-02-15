if [ $# != 3 ]; then
        echo "Expecting three parameters: Param1 = placeholder and param2 = filename, param3 = config-file-name you sure you have passed 3 parameters? "
        exit
fi
PLACEHOLDER=$1
if [[ ${PLACEHOLDER} != __* ]] ; then
        echo "soemthing wrong , make sure you passed the right placeholder"
        exit
fi
FILENAME=$2
CONFIGFILE=$3
if [ -e "${FILENAME}" ] || [ -e "${CONFIGFILE}" ]; then
        echo "Replacing PLACEHOLDER ${PLACEHOLDER} in file ${FILENAME}"
        sed -i "s/${PLACEHOLDER}/$( grep ${PLACEHOLDER} ${CONFIGFILE} | awk -F"::" '{print $2}')/g" ${FILENAME}


else
        echo "the filename/s don't exist, please check"
        exit
fi
