#!/bin/sh
printf "\nssh auto creator is a simple tool to create ssh keys, a config file, and copy your keys to your specified host\n"
printf "\nWhat alias would you like to give your ssh key? (Something you'll remember to initiate a connection)\nEnter alias: "
read alias
printf "\nWhat host will this key be used with?\nEnter hostname: "
read hostname
printf "\nWhat is your username for this host?\nEnter username: "
read username
printf "\nDo you connect using a special port? Enter 22 if not\nEnter port: "
read port
printf "\nWhat algorithm would you like to use?  (enter 'rsa', 'dsa', or 'ed25519'): "
read algorithm
printf "\n\nWhat strength would you like your key to be?  (enter '1024', '2048', or '4096'): "
read strength
printf "\n\nConfirm you want to create a $algorithm $strength key called $alias?"
printf "\nPress enter to continue or ctrl-c to abort...\n"
read continue
printf "\nNote: passphrase is optional\n"
ssh-keygen -t $algorithm -b $strength -C $username@$hostname -f ~/.ssh/$alias
printf "\n\nConfirmation that your key has been created:\n"
ls -lah ~/.ssh | grep $alias
printf "\nAppending your ssh config file:\n"
cat <<EOT >>~/.ssh/config 
 
Host $alias
  HostName $hostname
  User $username
  Port $port
  IdentityFile ~/.ssh/$alias
EOT
printf "\nYour config file has been appended with your settings,\n"
printf "Now you can type 'ssh $alias' to initiate an ssh connection\n"
printf "\nWill attempt to copy your ssh key to $hostname on exit\n"
printf "\nYou can check the authorized_keys file on the host\n"
printf "\nIf the copy fails, or is not possible for other reasons, copy the key manually based on the host's requirements (e.g. web interface, etc.)\n\n"
printf "Note: The key is named ~/.ssh/$alias on this machine"
printf "\n\nAll done!\n\n"
ssh-copy-id -i ~/.ssh/$alias -p $port $username@$hostname >/dev/null 2>&1