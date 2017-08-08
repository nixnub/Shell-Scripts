#!/bin/bash

#############################################################
#                                                           #
# DigitalOcean create a droplet in random DC                #
#                                                           #
# Description   : Create a droplet on digitalocean.com      #
# Author        : nixnub, nixnub@gmail.com                  #
# License       : GPL <http://www.gnu.org/licenses/gpl.html #
#                                                           #
#############################################################

domain=$1

if [[ $# != 1 ]] ; then

    echo "Usage: $0 <domain>  (ex: $0 example.com)"
    exit 1
fi

# Enter your digitalocean token here
TOKEN=""

generate_random_region() {
cat <<-EOF
    {
    "name":"$domain",
    "region":"$(rand_region)",
    "size":"512mb",
    "image":"_paste_image_id_here",
    "ssh_keys":["_paste_your_ssh_key_here_"]}
EOF

}

rand_region(){

        arr[0]="nyc1"
        arr[1]="ams1"
        arr[2]="sfo1"
        arr[3]="ams2"
        arr[4]="sgp1"
        arr[5]="lon1"
        arr[6]="nyc3"
        arr[7]="ams3"
        rand=$[ $RANDOM % 8 ]
        echo ${arr[$rand]}
}

# create the new droplet from image

echo -e " ==> Creating droplet $domain\n"

curl -i \
-H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
-X POST --data "$(generate_random_region)" "https://api.digitalocean.com/v2/droplets"
