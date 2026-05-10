#!/bin/bash

# Enable Nvidia GPU support if detected
if which nvidia-smi > /dev/null 2>&1 && ls -A /dev/dri 2>/dev/null && [ "${DISABLE_ZINK}" == "false" ]; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

# Default settings
if [ ! -d "${HOME}"/.config/xfce4/xfconf/xfce-perchannel-xml ]; then
  mkdir -p "${HOME}"/.config/xfce4/xfconf/xfce-perchannel-xml
  cp /defaults/xfce/* "${HOME}"/.config/xfce4/xfconf/xfce-perchannel-xml/
fi

# Autostart OpenVSCode Server as abc user
if [ -x /usr/local/bin/openvscode-server ]; then
  echo "[startwm] Starting OpenVSCode Server..."
  /usr/local/bin/openvscode-server --folder-uri "file:///config" &
  echo "[startwm] OpenVSCode Server started on port 3535"
fi

# Start DE
exec dbus-launch --exit-with-session /usr/bin/xfce4-session > /dev/null 2>&1
