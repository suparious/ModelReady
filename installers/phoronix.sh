#!/bin/bash
sudo apt install -y php-cli php-xml php-common psmisc cpufrequtils unzip zip
echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
sudo systemctl restart cpufrequtils
wget http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_10.8.4_all.deb -O phoronix-test-suite_10.8.4_all.deb
sudo dpkg -i phoronix-test-suite_10.8.4_all.deb

## Basic CPU test
# phoronix-test-suite benchmark smallpt
# phoronix-test-suite benchmark pts/compress-7zip
# phoronix-test-suite benchmark pts/compress-gzip
# phoronix-test-suite benchmark pts/compress-pbzip2

## Server CPU test collection
phoronix-test-suite benchmark server-cpu-tests

## NVIDIA GPU test collection
phoronix-test-suite benchmark nvidia-gpu-compute

## SuperTest
# phoronix-test-suite benchmark 2206086-NE-ALMALINUX77

## Not required if you installed cpufrequtils
# echo performance | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
