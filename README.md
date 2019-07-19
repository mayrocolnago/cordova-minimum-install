# Apache Cordova - Minimum install requirements
Here follows a script I came up with to make it easier and clean to install Apache Cordova with less storage space usage possible using only terminal command line environment.

This bash script will automatically install:

* Android-SDK platform-19 built-tools-29.0.1
* Gradle 4.10.3 + GooglePlayServices
* Java JDK8 Headless
* Apache Cordova
* NodeJS
* NPM

(Tested with Ubuntu 16.04. Installed straight from each one of tool's the respective repositories)


Just copy and paste the following code into your terminal:
```
#!/bin/bash
## You can disconsider the first line if running straight from the terminal
df &&
export GRADLECVER=4.10.3 &&
export ANDROID_HOME=/usr/lib/android-sdk &&
export ANDROIDSDKURI=sdk-tools-linux-4333796.zip &&
sudo apt update &&
echo "# Installing Java JDK8 Headless..." &&
sudo apt -y install nodejs npm openjdk-8-jdk-headless &&
echo ... &&
echo "# Installing Android SDK tools..." &&
wget https://dl.google.com/android/repository/$ANDROIDSDKURI &&
sudo mkdir -p $ANDROID_HOME &&
sudo unzip $ANDROIDSDKURI -d $ANDROID_HOME &&
rm $ANDROIDSDKURI &&
echo ... &&
echo "# Installing Gradle..." &&
wget https://services.gradle.org/distributions/gradle-$GRADLECVER-bin.zip &&
sudo mkdir /opt/gradle &&
sudo unzip -d /opt/gradle gradle-$GRADLECVER-bin.zip &&
rm gradle-$GRADLECVER-bin.zip &&
echo ... &&
echo "# Setting environment variables..." &&
export ANDROID_SDK_ROOT=$ANDROID_HOME &&
export PATH=$PATH:/opt/gradle/gradle-$GRADLECVER/bin:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin &&
export CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL=https\\://services.gradle.org/distributions/gradle-$GRADLECVER-bin.zip &&
echo "export ANDROID_HOME=$ANDROID_HOME" > ~/.bash_aliases &&
echo "export ANDROID_SDK_ROOT=\$ANDROID_HOME" >> ~/.bash_aliases &&
echo "export PATH=\$PATH:/opt/gradle/gradle-$GRADLECVER/bin:\$ANDROID_HOME/tools:\$ANDROID_HOME/tools/bin" >> ~/.bash_aliases &&
echo "export CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL=https\\://services.gradle.org/distributions/gradle-$GRADLECVER-bin.zip" >> ~/.bash_aliases &&
echo ... &&
echo "# Updating NPM and Installing Cordova..." &&
npm -g install npm &&
npm -g install cordova &&
sudo apt autoremove -y &&
echo ... &&
echo "# Configuring SDKManager..." &&
sudo chmod -R 777 $ANDROID_HOME &&
sudo yes | sdkmanager --update &&
sudo yes | sdkmanager "platforms;android-19" "build-tools;29.0.1" "extras;google;google_play_services" &&
sudo yes | sdkmanager --licenses &&
df

```
