![docker forge](https://github.com/sabs21/forge-mod-dev-docker/assets/18126892/4308de19-b1e1-474a-8e02-3c2094733700)
# Dockerized Minecraft Forge Mod Development
Develop Minecraft Forge mods in a dockerized dev environment
## Requirements
1.  [Visual Studio Code](https://code.visualstudio.com/)
    -   Install extension: [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2.  [Docker](https://www.docker.com/get-started/)
3.  Windows 10/11
## Steps
1. Install all requirements.
2. Clone this repo.
3. Open Docker Desktop and VS Code.
4. In VS Code, open into the cloned repo folder.
5. Adjust the Minecraft and Forge versions in the `.env` file to suit your needs.
6. In VS Code, hit F1 and select "Dev Containers: Reopen in Container".
7. Wait for everything to build! This may take between 2-10 minutes depending on your internet speeds and PC specs.
## Transfer Mod from Docker to Minecraft Client
To migrate your mod from Docker to your Minecraft client, simply run `copy_mod_to_client.bat`. 

This batch script assumes your Minecraft client is located in `%userprofile%\AppData\Roaming\.minecraft\mods`. If your mods folder exists somewhere else, you'll have to edit the `minecraftModsPath` variable in the script.
