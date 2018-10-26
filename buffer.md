# Buffer

The instance is stored in the global "Buffer" class.

## get/set

```
Router::get($name)
```

This prints a string stored in a 'buffer' with the specified name or returns false when the buffer is not found. The name of the view buffer is 'html'.

```
Router::set($name, $string)
```

This stores a string into a 'buffer' with the specified name.

## start/end

```
Router::start($name)
```

This starts a 'buffer' with the specified name.

```
Router::end($name)
```

This end a 'buffer' with the specified name.
