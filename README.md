![docker forge](https://github.com/sabs21/forge-mod-dev-docker/assets/18126892/4308de19-b1e1-474a-8e02-3c2094733700)
# Dockerized Minecraft Forge Mod Development
Develop Minecraft Forge mods without worrying about dependencies when collaborating with others.
## How it works
![docker forge diagram edited](https://github.com/sabs21/forge-mod-dev-docker/assets/18126892/06e42696-ee18-4a4f-9bf9-8bd34ea6c70a)
- `mc-dev` is where mod development happens. Uses the forge MDK.
- `mc-server` is where your minecraft server lives. Your mod will sync to the server's mods folder on performing `./gradlew build` within the `mc-dev` container. You'll need to restart the `mc-server` container to see changes take effect.
- `mod-build` contains the compiled mod resulting from running `./gradlew build`. On running `copy_mod_to_client.bat`, the contents of this volume gets transferred to your Minecraft mods folder.
## Requirements
1.  [Visual Studio Code](https://code.visualstudio.com/)
    -   Install extension: [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2.  [Docker](https://www.docker.com/get-started/)
3.  [Minecraft](https://www.minecraft.net/en-us/download)
4.  [Forge](https://files.minecraftforge.net/net/minecraftforge/forge/)
5.  Windows 10/11
## Steps
1. Install all requirements.
2. Clone this repo.
3. Open Docker Desktop and VS Code.
4. In VS Code, open into the cloned repo folder.
5. Adjust the Minecraft and Forge versions in the `.env` file to suit your needs.
6. In VS Code, hit F1 and select "Dev Containers: Reopen in Container".
7. Wait for everything to build! This may take between 2-10 minutes depending on your internet speeds and PC specs.
8. Once complete, you should have a running Minecraft server with VS Code displaying the contents of the Forge MDK from the `mc-dev` container.

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
