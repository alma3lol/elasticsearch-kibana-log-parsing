#!/bin/bash
# ========== [ CHECK ROOT ] ==========
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
# ========== [ INSTALL FILEBEAT ] ==========
filebeat_dir=$(ls -d filebeat* | grep -v filebeat.service)
filebeat_folder="$PWD/$filebeat_dir"
filebeat_service_content=$(sed "s#\$PWD#$filebeat_folder#g;s#\$EXE#$filebeat_folder/filebeat -c $filebeat_folder/filebeat.yml#g" filebeat.service)
echo "$filebeat_service_content" > /lib/systemd/system/filebeat.service
# ========== [ INSTALL HEARTBEAT ] ==========
heartbeat_dir=$(ls -d heartbeat* | grep -v heartbeat.service)
heartbeat_folder="$PWD/$heartbeat_dir"
heartbeat_service_content=$(sed "s#\$PWD#$heartbeat_folder#g;s#\$EXE#$heartbeat_folder/heartbeat -c $heartbeat_folder/heartbeat.yml#g" heartbeat.service)
echo "$heartbeat_service_content" > /lib/systemd/system/heartbeat.service
# ========== [ INSTALL METRICBEAT ] ==========
metricbeat_dir=$(ls -d metricbeat* | grep -v metricbeat.service)
metricbeat_folder="$PWD/$metricbeat_dir"
metricbeat_service_content=$(sed "s#\$PWD#$metricbeat_folder#g;s#\$EXE#$metricbeat_folder/metricbeat -c $metricbeat_folder/metricbeat.yml#g" metricbeat.service)
echo "$metricbeat_service_content" > /lib/systemd/system/metricbeat.service
