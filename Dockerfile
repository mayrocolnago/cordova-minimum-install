FROM ubuntu:18.04

# Updating repositories and tools...
RUN apt-get update -y && \
    apt-get install -y wget curl apt-utils

# Installing NodeJS 12.x...
RUN apt-get remove -y nodejs && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs

# Installing Java JDK8 Headless...
RUN apt-get install -y openjdk-8-jdk-headless build-essential libssl-dev zip zipalign

# Installing Android SDK tools...
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    mkdir -p /usr/lib/android-sdk && \
    unzip sdk-tools-linux-4333796.zip -d /usr/lib/android-sdk && \
    rm sdk-tools-linux-4333796.zip

# Installing Gradle...
RUN wget https://services.gradle.org/distributions/gradle-4.10.3-bin.zip && \
    mkdir /opt/gradle && \
    unzip -d /opt/gradle gradle-4.10.3-bin.zip && \
    rm gradle-4.10.3-bin.zip

# Updating NPM and Installing Cordova...
RUN npm -g install npm && \
    npm -g install cordova && \
    npm -g install gulp

# Clearing remaining files...
RUN apt-get autoremove -y

# Setting environment variables...
ENV ANDROID_HOME="/usr/lib/android-sdk"
ENV ANDROID_SDK_ROOT="/usr/lib/android-sdk"
ENV PATH="/tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/gradle/gradle-4.10.3/bin:/usr/lib/android-sdk/tools:/usr/lib/android-sdk/tools/bin:/usr/lib/android-sdk/platform-tools"
ENV CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL="https\\://services.gradle.org/distributions/gradle-4.10.3-bin.zip"

# Configuring SDKManager...
RUN yes | sdkmanager --update && \
    yes | sdkmanager "platforms;android-19" "build-tools;28.0.3" "extras;google;google_play_services" && \
    yes | sdkmanager --licenses

WORKDIR /workspace