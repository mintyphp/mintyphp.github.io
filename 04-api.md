---
layout: page
title: API
permalink: /api/
menu: true
---

This is a reference of all global variables and functions.

## Functions

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `e($variable)                               ` | *.phtml       | Output string (escaped) |
| `d($variable)                               ` | *             | Debugging       |
| `t($id,...)                                 ` | *             | Translation     |

## Database

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `DB::select($sql,...):array                 ` | *.php         | Select all rows |
| `DB::selectOne($sql,...):array\|false       ` | *.php         | Select first row |
| `DB::selectValue($sql,...):mixed            ` | *.php         | Select single value |
| `DB::selectValues($sql,...):array           ` | *.php         | Select column values |
| `DB::selectPairs($sql,...):array            ` | *.php         | Select key-value pairs |
| `DB::insert($sql,...):int                   ` | *.php         | Insert record   |
| `DB::update($sql,...):int                   ` | *.php         | Update records  |
| `DB::delete($sql,...):int                   ` | *.php         | Delete records  |
| `DB::query($sql,...):mixed                  ` | *.php         | Execute query   |
| `DB::close():void                           ` | *.php         | Close connection |

## HTTP Client

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `Curl::call($method,$url,$data,...):array   ` | *.php         | HTTP request    |
| `Curl::navigate($method,$url,$data,...):array` | *.php        | HTTP with redirects |
| `Curl::callCached($exp,$method,$url,...):array` | *.php       | Cached HTTP request |
| `Curl::navigateCached($exp,$method,...):array` | *.php        | Cached with redirects |

## Authentication

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `Auth::login($user,$pass,$totp=''):array   ` | *.php         | Login user      |
| `Auth::logout():bool                        ` | *.php         | Logout user     |
| `Auth::register($user,$pass):int            ` | *.php         | Register user   |
| `Auth::update($user,$pass):int              ` | *.php         | Update password |
| `Auth::updateTotpSecret($user,$secret):int  ` | *.php         | Enable 2FA      |
| `Auth::exists($user):bool                   ` | *.php         | Check user exists |

## Passwordless Auth

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `NoPassAuth::token($user):string            ` | *.php         | Generate login token |
| `NoPassAuth::login($token,$rem=false,...):array` | *.php      | Login with token |
| `NoPassAuth::logout():bool                  ` | *.php         | Logout user     |
| `NoPassAuth::register($user):int            ` | *.php         | Register user   |
| `NoPassAuth::remember():bool                ` | *.php         | Restore session |
| `NoPassAuth::update($user):int              ` | *.php         | Reset password  |
| `NoPassAuth::updateTotpSecret($user,$sec):int` | *.php        | Enable 2FA      |

## Router

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `Router::redirect($url,$perm=false):void    ` | *.php         | Redirect to URL |
| `Router::json($object):void                 ` | *.php         | Output JSON     |
| `Router::download($name,$data):void         ` | *.php         | Download data   |
| `Router::file($name,$path):void             ` | *.php         | Download file   |
| `Router::getUrl():string                    ` | *.php         | Get current URL |
| `Router::getBaseUrl():string                ` | *.php         | Get base URL    |
| `Router::getRequest():string                ` | *.php         | Get request URI |
| `Router::getView():string                   ` | *.php         | Get view path   |
| `Router::getAction():string                 ` | *.php         | Get action path |
| `Router::getTemplateView():string           ` | *.php         | Get template view |
| `Router::getTemplateAction():string         ` | *.php         | Get template action |
| `Router::getParameters():array              ` | *.php         | Get URL parameters |
| `Router::getCanonical():string              ` | *.php         | Get canonical URL |
| `Router::getRedirect():?string              ` | *.php         | Get redirect URL |

## Session

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `Session::getCsrfInput():void               ` | *.phtml       | Output CSRF field |
| `Session::checkCsrfToken():bool             ` | *.php         | Verify CSRF token |
| `Session::start():void                      ` | *.php         | Start session   |
| `Session::end():void                        ` | *.php         | End session     |
| `Session::regenerate():void                 ` | *.php         | Regenerate session |

## Buffer

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `Buffer::start($name):void                  ` | *.phtml       | Start buffer    |
| `Buffer::end($name):void                    ` | *.phtml       | End buffer      |
| `Buffer::set($name,$string):void            ` | *.php         | Set buffer content |
| `Buffer::get($name):bool                    ` | *.phtml       | Output buffer   |

## Cache

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `Cache::get($key):mixed                     ` | *.php         | Get cached value |
| `Cache::set($key,$val,$exp=0):bool          ` | *.php         | Set cache value |
| `Cache::delete($key):bool                   ` | *.php         | Delete from cache |
| `Cache::add($key,$val,$exp=0):bool          ` | *.php         | Add if not exists |
| `Cache::replace($key,$val,$exp=0):bool      ` | *.php         | Replace if exists |
| `Cache::increment($key,$val=1):int\|false   ` | *.php         | Increment value |
| `Cache::decrement($key,$val=1):int\|false   ` | *.php         | Decrement value |

## Internationalization

| Function                                    | Location      | Purpose         |
| ------------------------------------------- | ------------- | --------------- | 
| `I18n::translate($id):string                ` | *.php         | Translate string |
| `I18n::price($val,$min=2,$max=2):string     ` | *.php         | Format price    |
| `I18n::currency($val,$min=2,$max=2):string  ` | *.php         | Format currency |
| `I18n::date($str):string                    ` | *.php         | Format date     |
| `I18n::datetime($str):string                ` | *.php         | Format datetime |
| `I18n::time($h,$m,$s=0):string              ` | *.php         | Format time     |
| `I18n::duration($sec,$trim=false):string    ` | *.php         | Format duration |
| `I18n::weekDay($day):string                 ` | *.php         | Get weekday name |
| `I18n::monthName($month):string             ` | *.php         | Get month name  |
| `I18n::datetimeShort($str):string           ` | *.php         | Format datetime short |
