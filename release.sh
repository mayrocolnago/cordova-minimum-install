#!/bin/bash
echo '#'
echo '# Release script by Mayro Colnago (mayrocolnago@gmail.com)'
echo '# Helper code to automatically check and create certs, also align apk
echo '#'
if [ "$1" == "" ]; then
  echo 'No project set'
else
  echo 'Accessing project home directory...'
  cd ~/cordova/$1
  echo 'Building unsigned apk file...'
  cordova build android --release
  echo 'Searching for a keystore pair chain...'
  if [ -f "$1.keystore" ]; then
      echo 'Keystore file exists'
  else 
      echo 'Generating new certification key...'
      keytool -genkey -v -keystore $1.keystore -alias $1 -keyalg RSA -keysize 2048 -validity 10000
  fi
  echo 'Setting key file directory:'
  TEMPKEYSTOREFILE=~/cordova/$1/platforms/android/app/build/outputs/apk/release
  echo $TEMPKEYSTOREFILE
  echo 'Signing apk with jarsigner...'
  jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore $1.keystore $TEMPKEYSTOREFILE/app-release-unsigned.apk $1
  echo 'Deleting old signed files...'
  rm $TEMPKEYSTOREFILE/app-release.apk
  echo 'Running zipalign on apk release...'
  zipalign -v 4 $TEMPKEYSTOREFILE/app-release-unsigned.apk $TEMPKEYSTOREFILE/app-release.apk
fi
echo 'Done'
