Copied from here: 
   https://github.com/vergecurrency/Docker-Verge-Daemon

To build:
---
    docker build --rm -t mkinney/verge:2.0.0-ubuntu14 .


Before running:
---
Place VERGE.conf in /tmp/verge/.VERGE/VERGE.conf on the HOST system. You probably want something a directory other than /tmp,
I am just using it to test that everything works. It will need to have at least these two values (like this):

    rpcuser=bitcoinrpc
    rpcpassword=Bnec4eGig52MTEAkzk4uMjsJechM7rA9EQ4NzkDHLwpG


Test that the docker runs:
---
    mkdir -p tmpverge/.VERGE
    echo "rpcuser=bitcoinrpc" > tmpverge/.VERGE/VERGE.conf
    echo "rpcpassword=Bnec4eGig52MTEAkzk4uMjsJechM7rA9EQ4NzkDHLwpG" >> tmpverge/.VERGE/VERGE.conf


To run:
---
    docker run -d --name verge:ubuntu14 -v `pwd`/tmpverge:/coin/home -p 20102:20102 -p 21102:21102 verge

This command should return a container id. You can use this id (or the first few characters of it to refer to later. We added a name option above so we can just refer to it as 'verge'.)

To watch the debug log:
---
    tail -f tmpverge/.VERGE/debug.log

To connect to the running container
---
    docker exec -it verge:ubuntu14 bash

To kill the running container:
---
    docker kill verge:ubuntu14

To remove the stopped container:
---
    docker rm verge:ubuntu14


To run on a Synology:
1. Create a folder that will have the verge wallet configuration. Open up 'Filestation', select 'home', then 'create folder'. I'll use 'verge'.
2. This folder should be visible to your computer, because you will need to create a configuration file in this folder. Follow the instructions at: https://github.com/vergecurrency/VERGE for more info. Be sure to create the VERGE.conf in a folder called ".VERGE". I have "home" mounted to my mac, so I see it as '/Volumes/home/verge/.VERGE/VERGE.conf'. Be sure to *NOT* set 'daemon=1', if so the container will keep stopping.
3. Start docker. Click 'main menu', then 'Docker'. (If you do not see that option, you will have install the package.)
4. Click on 'Image', then 'Add', 'from URL', and enter 'https://hub.docker.com/r/mkinney/verge/'
5. Wait for it to download.
6. Click on the image in the list, then click 'Launch', feel free to change the 'Container Name' or ports (but the defaults should be fine).
7. Accept (or change if you want) the Step 2 options (resource limitation, shortcut on desktop, enable auto-restart). I
   think it makes sense to check "shortcut" and "auto restart".
8. Summary (click the 'Advanced settings' button - this is easy to miss!)
9. Under 'Volume', click 'add folder' and select a folder (I'm using '/homes/mkinney/verge'). For the 'Mount path', enter '/coin/home'
10. Start up the container. You should see files in the .VERGE directory.
