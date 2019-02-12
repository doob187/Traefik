#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################

# Create Variables (If New) & Recall
main() {
   local file=$1 val=$2 var=$3
   [[ -e $file ]] || printf '%s\n' "$val" > "$file"
   printf -v "$var" '%s' "$(<"$file")"
}

# Questions
main2() {
   local file=$1 val=$2 var=$3

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  ESTABLISHING: $var
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️  NOTE: To store required information!

EOF
read -p 'Type Requested Info | Press [ENTER]: ' typed < /dev/tty
echo $typed > $file
}

# Deploy
deploy() {
   local file=$1 val=$2 var=$3

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  STORING INFO - $fprovider
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌎 REQUESTED INFORMATION >>> $var

EOF
read -p 'Type Info | Press [ENTER]: ' typed < /dev/tty
echo $typed > $file
}

## Check for Traefik Running
deployed=$(docker ps --format '{{.Names}}' | grep traefik)

if [ "$deployed" == "traefik" ]; then
  deployed="TRAEFIK Deployed"; else
  deployed="TRAEFIK NOT Deployed"; fi

# Menu Interface
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Traefik - Reverse Proxy Interface Menu
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Top Level Domain App: [$tld]
[2] Domain Provider     : [$provider]
[3] Domain Name         : [$domain]
[4] EMail Address       : [$email]
[5] Deploy Traefik      : [$deployed]
[6] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Standby
read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
      bash /opt/plexguide/menu/pgcloner/traefik.sh
      bash /opt/traefik/traefik.sh
      primestart ;;
    2 )
      bash /opt/plexguide/menu/pgshield/pgshield.sh
      primestart ;;
    3 )
      bash /opt/plexguide/menu/pgcloner/pgclone.sh
      bash /opt/pgclone/gdrive.sh
      primestart ;;
    4 )
      bash /opt/plexguide/menu/pgbox/pgboxselect.sh
      primestart ;;
    5 )
      bash /opt/plexguide/menu/pgcloner/pgpress.sh
      bash /opt/pgpress/pressmain.sh
      primestart ;;
    6 )
      bash /opt/plexguide/menu/pgcloner/pgvault.sh
      bash /opt/pgvault/pgvault.sh
      primestart ;;
    7 )
      bash /opt/plexguide/menu/interface/cloudselect.sh
      primestart ;;
    8 )
      bash /opt/plexguide/menu/tools/tools.sh
      primestart ;;
    9 )
      bash /opt/plexguide/menu/settings/settings.sh
      primestart ;;
    z )
      bash /opt/plexguide/menu/ending/ending.sh
      exit ;;
    Z )
      bash /opt/plexguide/menu/ending/ending.sh
      exit ;;
    * )
      primestart ;;
esac



  if [ "$typed" == "1" ]; then
  bash /opt/traefik/tld.sh
elif [ "$typed" == "2" ]; then
  bash /opt/traefik/provider.sh
elif [ "$typed" == "3" ]; then
  main2 /var/plexguide/server.domain NOT-SET domain
elif [ "$typed" == "4" ]; then
  main2 /var/plexguide/server.email NOT-SET email

elif [ "$typed" == "5" ]; then

    a="NOT-SET"
    if [ "$tld" == "$a" ] || [ "$provider" == "$a" ] || [ "$domain" == "$a" ] || [ "$email" == "$a" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️ WARNING! - Cannot Deploy! You Must Set All of the Variables First!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 3
    bash /opt/traefik/traefik.sh
    exit; fi

fprovider=$(cat /var/plexguide/traefik.provider)
  if [ "$fprovider" == "cloudflare" ]; then
  deploy /var/plexguide/CLOUDFLARE_EMAIL NOT-SET CLOUDFLARE_EMAIL
  deploy /var/plexguide/CLOUDFLARE_API_KEY NOT-SET CLOUDFLARE_API_KEY
elif [ "$fprovider" == "duckdns" ]; then
  deploy /var/plexguide/DUCKDNS_TOKEN NOT-SET DUCKDNS_TOKEN
elif [ "$fprovider" == "gandiv5" ]; then
  deploy /var/plexguide/GANDIV5_API_KEY NOT-SET GANDIV5_API_KEY
elif [ "$fprovider" == "vultr" ]; then
  deploy /var/plexguide/VULTR_API_KEY NOT-SET VULTR_API_KEY
elif [ "$fprovider" == "godaddy" ]; then
  deploy /var/plexguide/GODADDY_API_KEY NOT-SET GODADDY_API_KEY
  deploy /var/plexguide/GODADDY_API_SECRET NOT-SET GODADDY_API_SECRET
elif [ "$fprovider" == "digitalocean" ]; then
  deploy /var/plexguide/DO_AUTH_TOKEN NOT-SET DO_AUTH_TOKEN
elif [ "$fprovider" == "namecheap" ]; then
  deploy /var/plexguide/NAMECHEAP_API_USER NOT-SET NAMECHEAP_API_USER
  deploy /var/plexguide/NAMECHEAP_API_KEY NOT-SET NAMECHEAP_API_KEY
elif [ "$fprovider" == "ovh" ]; then
  deploy /var/plexguide/OVH_ENDPOINT NOT-SET OVH_ENDPOINT
  deploy /var/plexguide/OVH_APPLICATION_KEY NOT-SET OVH_APPLICATION_KEY
  deploy /var/plexguide/OVH_APPLICATION_SECRET NOT-SET OVH_APPLICATION_SECRET
  deploy /var/plexguide/OVH_CONSUMER_KEY NOT-SET OVH_CONSUMER_KEY
elif [ "$fprovider" == "gcloud" ]; then
  deploy /var/plexguide/GCE_PROJECT NOT-SET GCE_PROJECT
  deploy /var/plexguide/GCE_SERVICE_ACCOUNT_FILE NOT-SET GCE_SERVICE_ACCOUNT_FILE
fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 ZOOM ZOOM - Deploying Traefik! I Luv PlexGuide!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

sleep 3
ansible-playbook /opt/traefik/common.yml
ansible-playbook /opt/traefik/$fprovider.yml

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 🍖 NOM NOM - Rebuilding Your Containers!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 3
bash /opt/traefik/rebuild2.sh

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ WOOT WOOT - Traefik Deployed! Become a PG Sponsor Today!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

sleep 5

elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
  exit
else
bash /opt/plexguide/menu/traefik/traefik.sh
fi

bash /opt/traefik/traefik.sh
exit


main /var/plexguide/traefik.provider NOT-SET provider
main /var/plexguide/server.email NOT-SET email
main /var/plexguide/server.domain NOT-SET domain
main /var/plexguide/tld.program NOT-SET tld
main /var/plexguide/traefik.deploy 'Not Deployed' deploy

traefikmain
