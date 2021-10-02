#!/usr/bin/bash

# provision gcloud server

PROJECT=""
SERVICE_ACCOUNT=""

for SERVER_NAME in "webserver-1" "webserver-2"
do
    gcloud compute instances create $SERVER_NAME --project=$PROJECT --zone=us-central1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,subnet=default --metadata=ssh-keys=dedsec:ssh-rsa\ AAAAB3NzaC1yc2EAAAADAQABAAABgQCYG7YxMtLs3y2/\+qxAFH6eseb\+GCFAsgp0geC1Xbigd7qcetYOtq1VVWop\+xsG51xrhyUCK5JRcaZrR2crxCkmq\+CsHNz9JSDfe1ANVH3NXSHgEBdqD0uOwzt/RWEmZT6veVlDydKJV5Rzx2gkpBlT56Q0di4Rvu1JqwJsp93F6yjcHIRGnBoLP93O1eLUrrlfwTb90kA5zHGP1bxRI4ik9QrUBuyuBO4f2IW24sws14dFXZsdZuhn/OmjVEYU2AOnT5AwbbZjaOkk726ZhnAj\+JbcQGGPyXbmlF/3Ck7UPlCUJdugggfcgcp\+8xR1g2OVdiTNgt\+zN09Q63HjcI45Yfg2WT6EyRkBXyCGfLllTrNhOuhUaPJeN80CgWJeiMtgHtigS2tzMQdwNknCT9fFjwlO6IuMTJCDOnQzyoq1gQJE\+Tz1Iyg7SZ4TbpQd7buWK9e9jFmthEOs7E2\+\+pphNYri8cLUQDXr96TyoyArJqN3QkVDFreRntCKwbn5P4s=\ dedsec@fucker --maintenance-policy=MIGRATE --service-account=$SERVICE_ACCOUNT --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server --create-disk=auto-delete=yes,boot=yes,device-name=$SERVER_NAME,image=projects/centos-cloud/global/images/centos-7-v20210916,mode=rw,size=30,type=projects/playground-s-11-ec2a0295/zones/us-central1-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
done

# enable http firewall on gcloud
gcloud compute --project=$PROJECT firewall-rules create http --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=0.0.0.0/0 --target-tags=http-server