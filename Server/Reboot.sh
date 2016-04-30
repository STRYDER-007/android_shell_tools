#!/usr/bin/env bash
source /media/adriandc/AndroidDev/Server/Vars.rc;

# Work in Progress
cd $LogsDir/;
if [ ! -z $(find * -mtime -0,003 | tail -1) ]; then
  exit;
fi;

# PushBullet Notification
PushBulletComment="Server rebooting !";
curl --header "Access-Token: $PushBulletToken" \
     --header "Content-Type: application/json" \
     --data-binary "{\"body\":\"$PushBulletComment\",\"title\":\"\",\"type\":\"note\",\"url\":\"$PushBulletNoteUrl\",\"created\":\"$(date +%s)\", \"active\":\"true\",\"sender_name\":\"$PushBulletUser\"}" \
     --request POST https://api.pushbullet.com/v2/pushes >/dev/null;

# Reboot the server
/sbin/shutdown -r now;
