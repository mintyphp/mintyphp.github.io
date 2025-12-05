---
layout: page
title: Installation
permalink: /installation/
menu: true
---

MintyPHP is simple and easy to install. 
The minimum requirements are a web server and a copy of MintyPHP, that’s it! 
MintyPHP will run on any Linux (LAMP) web server running PHP + MySQL + Memcache.

## Requirements

- PHP 8 or greater
- mysqli PHP extension (for MariaDB)
- memcached PHP extension (for MemcacheD)

## Download

You can download the latest version as a zip archive by clicking the button below.

<br>
<a href='http://github.com/mintyphp/mintyphp/archive/v3.1.0.zip' style="text-decoration: none; color: white; background-color: #21a900; padding: 10px 20px;">Download MintyPHP v3.1.0</a>
<br>
<br>

Unzip the archive and run the start.sh script with the following command:

```
unzip mintyphp-3.1.0.zip
cd mintyphp-3.1.0
bash start.sh
```

It should download composer.phar and adminer and install the latest versions of all PHP dependencies. 
Then it should start the application in debug mode on [http://localhost:8000/](http://localhost:8000/).

## Configure

The configurator will start. You need to enter your MySQL credentials and press "Test and Save".
Now the application starts and you can explore the demo functionality on your own machine.
