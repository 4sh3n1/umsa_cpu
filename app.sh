#!/bin/bash

# Load environment variables
if [ -f .env ]; then
    echo "Loading .env..."
    source .env
else
    echo ".env file doesn't exist. Using local enviroment variables"
fi


get_env_value() {
    local variable_name="$1"
    local value="${!variable_name}"
    if [ -z "$value" ]; then
        echo "Error: Env variable not found '$variable_name'"
        exit 1
    else
        echo "$value"
    fi
}

SIA_CPU_USERNAME=$(get_env_value "SIA_CPU_USERNAME")
SIA_CPU_PASSWORD=$(get_env_value "SIA_CPU_PASSWORD")

# Verify CI parameter
if [ $# -eq 0 ]; then
    echo "Please add parameter to search app.sh <CI>" >&2
    exit 1
fi
dip="$1"

folder="download"
if [ ! -d "$folder" ]; then
    # Si la carpeta no existe, crearla
    mkdir -p "$folder"
    echo "Folder '$folder' created"
else
    echo "Folder '$folder' already exists"
fi

# Define function for MD5 hashing
md5() {
    echo -n $1 | md5sum | awk '{print $1}'
}
# Authentication function
auth() {
    url="https://sia.umsa.bo/cpu/j_spring_security_check"
    payload="j_username=${SIA_CPU_USERNAME}&j_password=$(md5 ${SIA_CPU_PASSWORD})"
    header1="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
    header2="Accept-Language:en-US,en;q=0.9"
    header3="Cache-Control: max-age=0"
    header4="Connection: keep-alive"
    header5="Content-Type: application/x-www-form-urlencoded"
    header6="Origin: https://sia.umsa.bo"
    header7="Referer: https://sia.umsa.bo/cpu/authentication/login"
    cookie_file=$(mktemp)
    response=$(curl -s -X  POST -H "${header1}" -H "${header2}" -H "${header3}" -H "${header4}" -H "${header5}" -H "${header6}" -H "${header7}"  -d "${payload}" -L "${url}" -c "${cookie_file}")
    session=$(grep "JSESSIONID" "${cookie_file}" | awk '{print $NF}')
    echo "${session}"
}

# Define payload and headers
header1="Content-Type: application/json"
header2="Cookie: JSESSIONID=$(auth)"

payload=''

# Define filename
format=$(date +"%Y-%m-%d_%H-%M-%S")
name="raw_${dip}_${format}.txt"
echo "${name}"

# Send request
echo "Sending request..."
curl -s -X POST -H "${header1}" -H "${header2}"  --data-raw "{\"dip\": \"$dip\"}" -L "https://sia.umsa.bo/cpu/estudiante/listarEstudiantes" -o ./download/${name}

# Process response
echo "End: ${name}"
rm -f "${cookie_file}"