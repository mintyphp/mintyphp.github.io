---
layout: page
title: API
permalink: /api/
menu: true
---

This is a reference of the all global variables and functions.

## Standard

| Type    | Function                           | Location      | Purpose         |
| ------- | ---------------------------------- | ------------- | --------------- | 
|         | e($variable)                       | *.phtml       | Output string   |
|         | d($variable)                       | *             | Debugging       |
| array   | DB::select($sql,...)               | *.php         | Database query  |
| array   | DB::selectOne($sql,...)            | *.php         | Database query  |
| string  | DB::selectValue($sql,...)          | *.php         | Database query  |
| array   | DB::selectPairs($sql,...)          | *.php         | Database query  |
| array   | DB::selectValues($sql,...)         | *.php         | Database query  |
| integer | DB::insert($sql,...)               | *.php         | Database query  |
| integer | DB::update($sql,...)               | *.php         | Database query  |
| integer | DB::delete($sql,...)               | *.php         | Database query  |
| array   | Curl::call($method,$url,$data)     | *.php         | Curl API call   |
| array   | Curl::navigate($method,$url,$data) | *.php         | Curl API call   |
| bool    | Auth::login($username,$password)   | *.php         | Logging in      |
| bool    | Auth::logout()                     | *.php         | Logging out     |
| bool    | Auth::register($username,$password)| *.php         | Adding users    |
|         | Flash::set($type,$message)         | *.php         | Flash message   |
| array   | Flash::get()                       | *.php         | Flash message   |
|         | Router::addRoute($req,$loc)        | routes.php    | Routing         |
|         | Router::redirect($url)             | *.php         | Redirection     |
|         | Router::json($object)              | *.phtml       | Return JSON     |
| string  | Session::getCsrfInput()            | *.phtml       | Form security   |

## Advanced

| Type    | Function                           | Location      | Purpose         |
| ------- | ---------------------------------- | ------------- | --------------- | 
| bool    | Loader::register($path,$namespace) | loader.php    | Loading classes |
|         | Buffer::set($name,$string)         | *.php         | Set raw HTML    |
| bool    | Buffer::get($name)                 | *.phtml       | Get raw HTML    |
|         | Buffer::start($name)               | *.phtml       | Nested template |
|         | Buffer::end($name)                 | *.phtml       | Nested template |
