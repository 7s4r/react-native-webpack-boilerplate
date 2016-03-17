# Pull base image
FROM node:argon

# fetch & install
RUN \
  mkdir -p /app && \
  git clone https://github.com/7s4r/react-native-webpack-starter-kit.git /app && \
  cd /app && \
  npm install

# Install watchman from source
RUN \
  apt-get update && apt-get install -y python-dev && \
  mkdir -p /tmp/watchman && \
  wget https://github.com/facebook/watchman/archive/$WATCHMAN_VERS.tar.gz && \
  tar --strip-components=1 -xzf $WATCHMAN_VERS.tar.gz -C /tmp/watchman && \
  cd /tmp/watchman && \
  ./autogen.sh && ./configure && make && make install && \
  rm -f $WATCHMAN_VERS.tar.gz && rm -rf /tmp/watchman

# Mount to local file system
VOLUME /app/src

# Set current working directory
WORKDIR /app

# Run it
CMD ["npm", "start"]

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082
