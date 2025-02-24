FROM node:18-slim

WORKDIR /tmp

ENV CHROME_BIN=/usr/bin/chromium \
    DBUS_SESSION_BUS_ADDRESS=/dev/null \
    DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:99.0

# Update package lists, install dependencies, download and install Google Chrome 114
RUN apt-get update --fix-missing && \
    apt-get install -y xvfb wget openjdk-17-jre-headless libgconf-2-4 libexif12 && \
    wget https://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/google-chrome-stable_114.0.5735.198-1_amd64.deb && \
    dpkg -i google-chrome-stable_114.0.5735.198-1_amd64.deb || apt-get -fy install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* google-chrome-stable_114.0.5735.198-1_amd64.deb && \
    mkdir -p /usr/share/desktop-directories && \
    mkdir -p /var/run/dbus && \
    mkdir -p /var/run/chrome && \
    chmod -R 777 /var/run/chrome

RUN mkdir /protractor && \
    npm install -g protractor

RUN webdriver-manager update

WORKDIR /protractor

# Copy package files first
COPY package*.json ./

# Install dependencies using npm ci
RUN npm ci

# Copy the rest of the files
COPY . .

# Make sure the script is executable
RUN chmod +x protractor.sh

CMD ["./protractor.sh"]
