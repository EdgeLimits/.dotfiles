# How to install Blender

## 1. Download Blender from the [official website](https://www.blender.org/download/)

## 2. Move Blender into `/opt`

Extract it:
```
tar -xvf blender-*-linux-x64.tar.xz
```

Move to the extracted folder into `/opt`:
```
sudo mv blender-* /opt/blender
```
```
```

## 3. Create a symlink so Blender works from terminal

```
sudo ln -s /opt/blender/blender /usr/local/bin/blender
```

## 4. Add Blender to the App Launcher

Create:
```
nano ~/.local/share/applications/blender.desktop
```


Paste this:

```
[Desktop Entry]
Version=5.0
Type=Application
Name=Blender
Comment=3D Creation Suite
Exec=/usr/local/bin/blender
Icon=/opt/blender/blender.svg
Terminal=false
Categories=Graphics;3DGraphics;AudioVideo;
```

Save, then:
```
chmod +x ~/.local/share/applications/blender.desktop
update-desktop-database ~/.local/share/applications
```

