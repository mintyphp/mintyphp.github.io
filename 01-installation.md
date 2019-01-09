---
layout: page
title: Installation
permalink: /installation/
menu: true
---

MintyPHP is simple and easy to install. 
The minimum requirements are a web server and a copy of MintyPHP, that’s it! 
MintyPHP will run on a variety of web servers and operating systems.

## Requirements

- Apache or nginx (rewrite is not required)
- PHP 5.4.0 or greater
- mysqli PHP extension

While a database engine isn’t required, most applications will utilize one. 
MintyPHP supports MariaDB (and other MySQL compatible databases).

## Download

You can download the latest version as a zip archive by clicking the button below.

<br>
<a href='http://github.com/mintyphp/mintyphp/archive/v2.0.4.zip' style="text-decoration: none; color: white; background-color: #21a900; padding: 10px 20px;">Download MintyPHP v2.0.4</a>
<br>
<br>

Unzip the archive and run the start.sh script with the following command:

```
unzip mintyphp-2.0.4.zip
cd mintyphp-2.0.4
bash start.sh
```

It should download composer.phar and adminer and install the latest versions of all PHP dependencies. 
Then it should start the application in debug mode on [http://localhost:8000/](http://localhost:8000/).

## Configure

The configurator will start. You need to enter your MySQL credentials and press "Test and Save".
Now the application starts and you can explore the demo functionality on your own machine.
