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
bash <(curl -s https://raw.githubusercontent.com/mayrocolnago/cordova-minimum-install/master/installscript.sh)

```
