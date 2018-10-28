---
layout: page
title: Buffer
permalink: /docs/buffer/
---

The instance is stored in the global "Buffer" class.

## get/set

```
Buffer::get($name)
```

This prints a string stored in a 'buffer' with the specified name or returns false when the buffer is not found. The name of the view buffer is 'html'.

```
Buffer::set($name, $string)
```

This stores a string into a 'buffer' with the specified name.

## start/end

```
Buffer::start($name)
```

This starts a 'buffer' with the specified name.

```
Buffer::end($name)
```

This end a 'buffer' with the specified name.
