![docker forge](https://github.com/sabs21/forge-mod-dev-docker/assets/18126892/4308de19-b1e1-474a-8e02-3c2094733700)
# Containerized Minecraft Forge Mod Development
A Minecraft Forge mod development environment that aims to make collaborating between developers easier.
## How it works
![forge-docker-mod-dev-diagram](https://github.com/sabs21/forge-mod-dev-docker/assets/18126892/cd2beef5-bd0f-423e-9c4a-b56dc4ea94fd)
- The contents of `com` are bound to the `/usr/local/proj/src/main/java/com` folder in the container. This means editing the source code within the container will also edit the source code on your machine. Since git will pick up on these changes, you can manage git version control outside of Docker.
- `mc-dev` is where mod development happens. Uses the forge MDK.
- `mc-server` is where your minecraft server lives. Your mod will sync to the server's mods folder on performing `./gradlew build` within the `mc-dev` container. You'll need to restart the `mc-server` container to see changes take effect.
- `builds` contains the compiled mod resulting from running `./gradlew build`. On running `copy_mod_to_client.bat`, the contents of this volume gets transferred to your Minecraft mods folder.
## Requirements
1.  [Visual Studio Code](https://code.visualstudio.com/)
    -   Install extension: [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2.  [Docker](https://www.docker.com/get-started/)
3.  [Minecraft](https://www.minecraft.net/en-us/download)
4.  [Forge](https://files.minecraftforge.net/net/minecraftforge/forge/)
5.  Windows 10/11
6.  4 GB of free space
## Steps
1. Install all requirements.
2. Clone this repo.
3. Place existing source code (located in `/src/main/java/com` within the forge MDK) you may have into the `com` folder. This will be copied into the development container on build. 
4. Open Docker Desktop and VS Code.
5. In VS Code, open into the cloned repo folder.
6. Rename `.env.example` to `.env`.
7. In `.env`, set both the minecraft version and forge version.
8. In VS Code, hit F1 and select "Dev Containers: Reopen in Container".
9. Wait for everything to build! This may take between 2-10 minutes depending on your internet speeds and PC specs.
10. Once complete, you should have a running Minecraft server with VS Code displaying the contents of the Forge MDK from the `mc-dev` container.

NOTE: If you don't want to use VS Code, then use `docker compose up` in the repo folder to build all Docker containers.

## Using Git
The `com` folder will reflect any changes made within the `/usr/local/proj/src/main/java/com` folder in the Docker container. This allows you to perform git actions on your host machine, completely outside of Docker.

## Building/Compiling your mod
Execute `gradlew build` within the `mc-dev` container. You will need to restart your `mc-server` container to see changes take effect.

## Transfer Mod from Docker to Minecraft Client
To migrate your mod from Docker to your Minecraft client, simply run `copy_mod_to_client.bat`. 

This batch script assumes your Minecraft client is located in `%userprofile%\AppData\Roaming\.minecraft\mods`. If your mods folder exists somewhere else, you'll have to edit the `minecraftModsPath` variable in the script.

## Connect to your Minecraft server
Within your Minecraft client... 
1. Navigate to Multiplayer
2. Click 'Add Server'
3. Name the server and set Server Address to 127.0.0.1:25565
4. Click 'Done'
5. When the `mc-server` container is running, you should be able to connect to your server. Make sure that you've run `copy_mod_to_client.bat` to sync your client's mods folder with the server's mods.

## Closing Docker
To close the development containers, you can either close each container through Docker Desktop or perform `CTRL + C` within the container terminal in VS Code.
