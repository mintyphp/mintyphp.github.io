# Curl

This class is for calling a HTTP API using Curl. It provides 2 public methods.

## Call

```
Curl::call($method,$url,$data,$headers,$options)
```

Executes Curl call:

```
$result = Curl::call('GET','http://www.bing.com/search',array('q'=>$query));
```

Note that the $data, $headers and $options parameters are optional. The $data parameter can either be an array (normally) or a string (for raw POST). In the view (.phtml) file we can show the returned status ('200' on success), the data (returned body) and the response headers:

```
<?php e($result['status']);?>
<?php e($result['data']);?>
<?php e(var_export($result['headers'], true));?>

```

## Navigate

```
Curl::navigate($method,$url,$data,$headers,$options)
```

Executes Curl call (and follow redirects):

```
$result = Curl::navigate('GET','http://www.bing.com/search',array('q'=>$query));
```

Note that the $data, $headers and $options parameters are optional. In the view (.phtml) file we can show the effective URL (of the last redirect):

```
<?php e($result['url']);?>
```