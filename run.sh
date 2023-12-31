#!/bin/bash
project="blue-project"
echo "Old containers running for $project?"
cont=$(docker ps -aqf "name=$project")
if [ -z "$cont" ]
then
	echo "No old containers running to stop..."
else
    echo "Yes, Stopping old containers..."
    docker stop $cont
fi
echo "Building angular image..."
docker build -t $project ./.docker/node
echo "$project image built successfully!"
echo "Running $project image..."
docker run -dit --rm --name $project -v $(pwd):/var/www/html/$project -p 4200:4200 $project
echo "Installing node packages... 0%"
docker exec -d $project npm install
#for i in {1..10}; do echo "Installing node packages... $(( 10*i ))%"; sleep 5; done
echo "npm packages installed"
echo "Compiling $project app... 0%"
docker exec -d $project npm run local
for i in {1..10}; do echo "Compiling $project app... $(( 10*i ))%"; sleep 5; done
echo "App launched, please go to http://localhost:4200 [if not launched and no errors, its compiling]"
