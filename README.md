# coesra-singularity-vscode
Singularity definition file and instruction to create a singularity container

## Build singularity container using singularity definition file
```
singularity build <singularity-container-name> <singularity-definition-file>
```

## Check vscode installed in container properly 
```
singularity shell <singularity-container-name>

code --version
```

## Execute command in singularity container 
```
singularity exec <container-name> <command>
```

## Run singularity container in CoESRA desktop
* Create container in /nfs/containers reposity in desktop node
* Cretae a desktop file in /usr/share/applications 
```
[Desktop Entry]
Exec=/usr/local/bin/vscode
Icon=/usr/share/pixmaps/vscode.png
Type=Application
Terminal=false
Name=VS Code
Categories=coesra;droneworkbench;
```

* create a bash script in /usr/local/bin 
```
#!/bin/bash

exec /usr/bin/singularity run -B /var/run/dbus -B /var/run/user/$UID <container-name> code
```
* Give permission to bash scipt to run
```
chmod +x <bash-script-file>
```

