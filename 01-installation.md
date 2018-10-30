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

You can download the latest version as a zip or tarball from:

<br>
<a href='http://github.com/mintyphp/mintyphp/archive/v2.0.1.zip' style="text-decoration: none; color: #111; font-weight: bold; background-color: #51d927; padding: 10px 20px;">Download MintyPHP v2.0.1</a>
<br>
<br>

Unzip/untar the archive and run the start.sh script with the following command:

```
bash start.sh
```

It should download composer.phar and install the latest versions of all dependencies. 
Then it should start the application in debug mode on [http://localhost:8000/](http://localhost:8000/).
