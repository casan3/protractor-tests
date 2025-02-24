#!/bin/bash

# Start Xvfb
Xvfb :99 -screen 0 1024x768x16 &

# Wait for Xvfb to be ready
sleep 1

# Update and start webdriver-manager
webdriver-manager update
webdriver-manager start --detach

# Wait for webdriver to be ready
sleep 5

# Run the tests
protractor protractor.conf.js
