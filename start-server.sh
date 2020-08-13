#!/bin/bash

if [ ! -d "/home/openttd/.openttd/baseset" ]; then
  mkdir -p /home/openttd/.openttd/baseset
fi

if [ ! "$(ls -A /home/openttd/.openttd/baseset)" ]; then
  echo "Downloading OpenGFX $OPENGFX_VERSION ..."
  mkdir -p ~/.openttd/baseset && wget -q -O /tmp/opengfx.zip https://cdn.openttd.org/opengfx-releases/$OPENGFX_VERSION/opengfx-$OPENGFX_VERSION-all.zip && unzip /tmp/opengfx.zip -d ~/.openttd/baseset && rm -f /tmp/opengfx.zip
fi

exec /usr/games/openttd -D0.0.0.0:3979
