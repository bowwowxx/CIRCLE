name=$(docker inspect -f '{{.Id}}' circle)
echo $name
sudo cp *.sql /var/lib/docker/btrfs/subvolumes/$name/tmp/
sudo cp load.sh /var/lib/docker/btrfs/subvolumes/$name/tmp/load.sh
PID=`docker  inspect  --format "{{ .State.Pid }}" circle `
sudo nsenter --target $PID --mount --uts --ipc --net --pid
