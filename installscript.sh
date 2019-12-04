#!/bin/bash
## You can disconsider the first line if running straight from the terminal
df &&
sudo apt update &&
echo "# Install NodeJS 12.x..." &&
sudo apt remove -y nodejs &&
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - &&
sudo apt-get install -y nodejs &&
echo "# Installing Java JDK8 Headless..." &&
sudo apt -y install openjdk-8-jdk-headless build-essential libssl-dev zip zipalign &&
echo ... &&
echo "# Installing Android SDK tools..." &&
wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip &&
sudo mkdir -p /usr/lib/android-sdk &&
sudo unzip sdk-tools-linux-4333796.zip -d /usr/lib/android-sdk &&
rm sdk-tools-linux-4333796.zip &&
echo ... &&
echo "# Installing Gradle..." &&
wget https://services.gradle.org/distributions/gradle-4.10.3-bin.zip &&
sudo mkdir /opt/gradle &&
sudo unzip -d /opt/gradle gradle-4.10.3-bin.zip &&
rm gradle-4.10.3-bin.zip &&
echo ... &&
echo "# Setting environment variables..." &&
export ANDROID_SDK_ROOT=/usr/lib/android-sdk &&
export PATH=$PATH:/opt/gradle/gradle-4.10.3/bin:/usr/lib/android-sdk/tools:/usr/lib/android-sdk/tools/bin &&
export CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL=https\\://services.gradle.org/distributions/gradle-4.10.3-bin.zip &&
echo "export ANDROID_HOME=/usr/lib/android-sdk" >> ~/.profile &&
echo "export ANDROID_SDK_ROOT=\/usr/lib/android-sdk" >> ~/.profile &&
echo "export PATH=\$PATH:/opt/gradle/gradle-4.10.3/bin:\/usr/lib/android-sdk/tools:\/usr/lib/android-sdk/tools/bin" >> ~/.profile &&
echo "export CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL=https\\://services.gradle.org/distributions/gradle-4.10.3-bin.zip" >> ~/.profile &&
source ~/.profile &&
echo ... &&
echo "# Updating NPM and Installing Cordova..." &&
sudo npm -g install npm &&
sudo npm -g install cordova &&
sudo apt autoremove -y &&
echo ... &&
echo "# Configuring SDKManager..." &&
sudo chmod -R 777 /usr/lib/android-sdk &&
sudo yes | sdkmanager --update &&
sudo yes | sdkmanager "platforms;android-19" "build-tools;29.0.1" "extras;google;google_play_services" &&
sudo yes | sdkmanager --licenses &&
df
