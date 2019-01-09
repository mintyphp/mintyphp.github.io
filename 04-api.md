---
layout: page
title: API
permalink: /api/
menu: true
---

This is a reference of the all global variables and functions.

## Standard

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `e($variable)                               ` | *.phtml       | Output string   |
| `d($variable)                               ` | *             | Debugging       |
| `DB::select($sql,...):array                 ` | *.php         | Database query  |
| `DB::selectOne($sql,...):array              ` | *.php         | Database query  |
| `DB::selectValue($sql,...):string           ` | *.php         | Database query  |
| `DB::selectPairs($sql,...):array            ` | *.php         | Database query  |
| `DB::selectValues($sql,...):array           ` | *.php         | Database query  |
| `DB::insert($sql,...):integer               ` | *.php         | Database query  |
| `DB::update($sql,...):integer               ` | *.php         | Database query  |
| `DB::delete($sql,...):integer               ` | *.php         | Database query  |
| `Curl::call($method,$url,$data):array       ` | *.php         | Curl API call   |
| `Curl::navigate($method,$url,$data):array   ` | *.php         | Curl API call   |
| `Auth::login($username,$password):bool      ` | *.php         | Logging in      |
| `Auth::logout():bool                        ` | *.php         | Logging out     |
| `Auth::register($username,$password):bool   ` | *.php         | Adding users    |
| `Flash::set($type,$message)                 ` | *.php         | Flash message   |
| `Flash::get():array                         ` | *.php         | Flash message   |
| `Router::addRoute($req,$loc)                ` | routes.php    | Routing         |
| `Router::redirect($url)                     ` | *.php         | Redirection     |
| `Router::json($object)                      ` | *.phtml       | Return JSON     |
| `Session::getCsrfInput():string             ` | *.phtml       | Form security   |

## Advanced

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `Buffer::set($name,$string)                 ` | *.php         | Set raw HTML    |
| `Buffer::get($name):bool                    ` | *.phtml       | Get raw HTML    |
| `Buffer::start($name)                       ` | *.phtml       | Nested template |
| `Buffer::end($name)                         ` | *.phtml       | Nested template |
