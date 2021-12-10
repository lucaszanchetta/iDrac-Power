#!/bin/bash
# Add, remove or change iDrac names and IPs here
idrac1Name="Development Server"
idrac1IP="192.168.1.178"

idrac2Name="Storage Server"
idrac2IP="192.168.1.120"

idrac3Name="Network Server"
idrac3IP="192.168.1.121"

powerinfo() {
  ip=$1
  ssh root@$ip racadm serveraction powerstatus
}

poweron() {
  ip=$1
  ssh root@$ip racadm serveraction powerup
}

poweroff() {
  ip=$1
  ssh root@$ip racadm serveraction powerdown
}

powercycle() {
  ip=$1
  ssh root@$ip racadm serveraction powercycle
}

echo $idrac1Name 'Power State:'
powerinfo $idrac1IP

# Gets power states of iDrac servers
# Add anthoer echo statement like this for additional iDracs or remove to have less than 3
echo ''
echo $idrac2Name 'Power State:'
powerinfo $idrac2IP

echo ''
echo $idrac3Name 'Power State:'
powerinfo $idrac3IP
echo ''
echo '+++++++++++++++++++++++++++++++++++++++++++++++++'

echo 'Enter server to manage power state on'
echo '    _________________________'
echo '    '$idrac1Name '[1] '
echo '    '$idrac2Name '[2] '
echo '    '$idrac3Name '[3] '
echo '    None         [n] '
echo '    _________________________'

read -n1 -p "Enter Option [1,2,3,n]: " serverSelect

# Add/remove cases here for additional iDracs follwing the examples
case $serverSelect in
  1) selectedIDrac=$idrac1IP ;;
  2) selectedIDrac=$idrac2IP ;;
  3) selectedIDrac=$idrac3IP ;;
  n|N) echo OK ;;
  *) echo Enter Valid Option ;;
esac

echo ''
echo '------------------------------------------'
echo 'Server IP:' $selectedIDrac
powerinfo $selectedIDrac

echo '   ___________________'
echo '   | Power On [1]    |'
echo '   | Power Off [2]   |'
echo '   | Power Cycle [3] |'
echo '   | None [n]        |'
echo '   |-----------------|'

read -n1 -p "Enter Option [1,2,3,n]: " powerOption

# Add/remove cases for less or more iDracs
case $powerOption in
  1) poweron $selectedIDrac ;;
  2) poweroff $selectedIDrac ;;
  3) powercycle $selectedIDrac ;;
  n|N) echo OK ;;
  *) echo Enter Valid Option ;;
esac
