# ssh auto creator

### Makes keyfiles, creates or appends an ssh config file, and copies the new public key to a target host

I made this because I wanted to have unique keys for all my different hosts

I thought writing a script would be easier than using commands each time, and figured other people might agree

_How does it work?_

Follow the prompts in this simple script when it asks:

*What would you like to name the connection?
*What kind of key would you like to generate?
*With which host will you be using your new key?
*Does the host require a special port?

After generating the key, it'll automatically copy the public key to the specified host's `authorized_hosts` file.

Example output:

```
$ ./ssh-auto-creator.sh

ssh auto creator is a simple tool to create ssh keys, a config file, and copy your keys to your specified host

What alias would you like to give your ssh key? (Something you'll remember to initiate a connection)
Enter alias: pg

What host will this key be used with?
Enter hostname: pengui

What is your username for this host?
Enter username: avery

Do you connect using a special port? Enter 22 if not
Enter port: 22

What algorithm would you like to use?  (enter 'rsa', 'dsa', or 'ed25519'): ed25519


What strength would you like your key to be?  (enter '1024', '2048', or '4096'): 4096


Confirm you want to create a ed25519 4096 key called pg?
Press enter to continue or ctrl-c to abort...


Note: passphrase is optional
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/avery/.ssh/pg
Your public key has been saved in /home/avery/.ssh/pg.pub
The key fingerprint is:
SHA256:H5kWbtGOEXyJ6IepnSu9xpljbnpMJAUBtico6+rI0s0 avery@pengui
The key's randomart image is:
+--[ED25519 256]--+
|    o.oo o.. .   |
|   o .  o ooo    |
|. . o .o o+..    |
| o   o. =..O     |
|.      =SoO .    |
|.     . ++ .     |
| o o   = +.      |
|= . E . &        |
|=o    .Ooo       |
+----[SHA256]-----+


Confirmation that your key has been created:
-rw-------  1 avery avery           399 Aug 11 23:17 pg
-rw-r--r--  1 avery avery            94 Aug 11 23:17 pg.pub

Appending your ssh config file:

Your config file has been appended with your settings,
Now you can type 'ssh pg' to initiate an ssh connection
Will attempt to copy your ssh key to pengui:
You can check the authorized_keys file on the host
 If the copy fails, or is not possible for other reasons, copy the key manually based on the host's requirements
Note: The key is named ~/.ssh/pg on this machine

All done!

avery@pengui's password:
```

_Then you can log in using the simple command ssh <alias>_

```
$ ssh pg

Welcome to Pengui!
Last login: Tue Aug 11 23:09:54 2020 from 192.168.1.25
avery@pengui:~$
```
