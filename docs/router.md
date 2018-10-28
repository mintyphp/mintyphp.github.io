---
layout: page
title: Router
permalink: /docs/router/
---

The instance is stored in the global "Router" class.

## Routes

```
Router::addRoute($request, $location)
```

This should be called from the router configuration (in "config/router.php").
Typically this is used to route the empty requested URL "/" to a specific location.
It does not update the URL in the address bar.
If you do want to update the URL in the address bar you should use the "redirect" function.

## Request

```
Router::getRequest()
```

With this call you can read the requested URL.
Normally this is the same as "$_SERVER['REQUEST_URI']".

## URL

```
Router::getUrl()
```

With this call you can find the effective routed URL.
This does not contain parameters and/or trailing slashes.
It does also show the redirected target, not the entered URL.

```
Router::getBaseUrl()
```

With this call you can find the routed URL prefix.
When not loaded in a subdirectory this should be "/".
It can be configured in the "config/config.php" file in the "Router" section.

## View

```
Router::getView()
```

This gets the path to the view file that is loaded.
For example on this page it returns: "pages/docs/router(docs).phtml".

## Action

```
Router::getAction()
```

This gets the path to the action file that is loaded.
For example on this page it returns: false.

## Template

```
Router::getTemplateView()
```

This gets the path to the template view file that is loaded.
For example on this page it returns: "templates/docs.phtml".

```
Router::getTemplateAction()
```

This gets the path to the template action file that is loaded.
For example on this page it returns: false.

## Redirect

```
Router::redirect($url)
```

This "redirect" function redirects directly to another URL.

## JSON

```
Router::json($object)
```

This "json" function outputs a JSON object as a full response.
