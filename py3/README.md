# Run a Python IDE with VSCode through noVNC with a docker container

## Setup
Install Docker Desktop: https://www.docker.com/products/docker-desktop

## Start noVNC desktop
```bash
./start.sh
```

## Using the desktop
The start.sh will start the noVNC desktop in a docker container. To access the desktop, open a browser and put in the url: http://localhost:6901

To start VSCode, click on "Applications" (top-left corner) -> "Run Program" -> Type in: `code` and hit enter