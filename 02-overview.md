---
layout: page
title: Overview
permalink: /overview/
menu: true
---

This is the documentation of the MintyPHP framework.

## Presentation/logic separation

The "pages" folder holds both the HTML for dynamic pages (view) and the PHP part (action) of these pages (if it has one).
The "web" and the "templates" folder hold the static files and the templates that are used by the views.
Note that every pages must have a "view" file and can optionally have an "action" file that holds its logic.

## Front controller

All URL's hit the "web/index.php" file. This is achieved using URL rewriting (with "mod_rewrite" in Apache).
The paradigm of routing every request through one file is called "front controller".
The file loads all configuration from the files in the config directory and these are thus the first files you will edit.

## Default routing

The page files (in the "pages" folder) have an URL on which they can be reached.
They may reside in a sub-folder and their filename is constructed like this: "hello(default).phtml".
In this example the "name" is set to the value "hello" and the "template" is set to "default".
Both the folder path and the "name" segment are part of the URL.
Files with the name "index" can be used to serve the directory URL.

The "phtml" files can have a corresponding "php" file. The filename is constructed like this: "customers($id).php".
This means that when you access the URL "/customers/23", the router will match the "customers" page and PHP variable "$id" is set to "23".
You may also set parameters using a get parameter in the query string. 
This means that when you access the URL "/customers?id=23", the router will match the "customers" page and PHP variable "$id" is set to "23".
If you provide too many arguments the page will ignore the extra parameters.
If you provide not enough parameters, then the missing parameters will be set to NULL. 

The router has a "addRoute" method, that allows you to map certain URL's to other URL's.
A simple redirect that most projects have is that the "/" URL is redirected to some page in the project.
These routes need to be defined in the "config/router.php" configuration file.

Note that there is a dynamic page named "404", that will be rendered when a page is not found.

## PHP templating

The "template" folder holds all templates. Normally the action is executed and the corresponding view is rendered.
The output is captured and can be printed using the "Buffer::get('html')" function.
A template will call this where the rendered view needs to be placed.
If you do not want to use a template you can use the "none" template.
In this case the view will be rendered directly.

## Database abstraction layer

The "DB" class holds your database connection.
It allows you to execute SQL queries very simple (using the "select", "insert", "update" and "delete" methods).
It protects you against SQL injection attacks.

Note that these methods are not suited for large datasets that exceed the PHP memory limit (streaming output).

## Curl API caller

The "Curl" class provides you means to call HTTP RESTful APIs.
It provides integration with the debugger, just like the DB class.
Not much logic is added to the basic Curl functionlity of PHP.
You can enable cookies for the API calls and the cookies are stored in the user's session.

## Cache by Memcache

The "Cache" class provides simplified Memcache support.
It provides integration with the debugger, just like the DB class.
It can be used to speed up your application by caching data that is expensive to retrieve.

## Authentication

A basic example for registering users and logging them in is included. This example shows some security best practises.
It uses session cookies and stores bcrypt hashed passwords that are secured with a salt using "password_hash" and "password_verify".
Passwordless login is also supported.

## Security

Protection mechanisms against SQL injection, Cross-Site-Scripting (XSS) and Cross-Site-Request-Forgery (CSRF) are provided.
In the views one should use the "e()" function for escaping output in order to protect against XSS.
The forms should use the "post" method and must call the "Session::getCsrfInput()" function to protect against CSRF.

## Firewall

To avoid Denial of Service attacks against your web application a firewall is provided.
It relies on the Cache component to count (and limit) the number of concurrent requests per IP address.
If too many concurrent requests happen, they will be slowed down to avoid overloading the web server.

## Debugger

There is a debug mode that enables the web debug toolbar. This toolbar gives you access to the debugger.
The debugger shows you everything you need to know about the last 10 requests.
Loaded files, chosen routes, executed queries and many more things can be found.
