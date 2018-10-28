---
layout: page
title: Authentication
permalink: /docs/authentication/
---

In the "Auth" class you find 3 functions that you can use anywhere.

## Login

```
Auth::login($username,$password)
```

Call this function to authenticate a user, example:

```
if (Auth::login($username, $password)) {
  Router::redirect("admin");
} else {
  $error = "Username/password not valid";
}
```

## Logout

```
Auth::logout()
```

Call this function to de-authenticate a user, example:

```
Auth::logout();
Router::redirect("login");
```

## Register

```
Auth::register($username,$password)
```

Call this function to register a new user, example:

```
if (Auth::register($username, $password)) {
  Auth::login($username, $password);
  Router::redirect("admin");
} else {
  $error = "User can not be registered";
}
```

# Passwordless

In the "NoPassAuth" class you find 4 functions that you can use anywhere.

## Token

```
NoPassAuth::token($username)
```

Call this function to retrieve a login token, example:

```
$token = NoPassAuth::token($username);
if ($token) {
  mail($username,'token',Router::getBaseUrl().'login/'.$token);
} else {
  $error = "Username not valid";
}
```

## Login

```
NoPassAuth::login($token)
```

Call this function to authenticate a user, example:

```
if (NoPassAuth::login($token)) {
  Router::redirect("admin");
} else {
  $error = "Token not valid";
}
```

## Logout

```
NoPassAuth::logout()
```

Call this function to de-authenticate a user, example:

```
NoPassAuth::logout();
Router::redirect("login");
```

## Register

```
NoPassAuth::register($username)
```

Call this function to register a new user, example:

```
if (NoPassAuth::register($username)) {
  $token = NoPassAuth::token($username);
  mail($username,'token',Router::getBaseUrl().'login/'.$token);
} else {
  $error = "User can not be registered";
}
```