---
layout: page
title: Functions
permalink: /docs/functions/
---

The two "shortcut" functions "d()" and "e()" can be used anywhere in your application.

## Escaped echo

```
e($variable)
```

In the views one should use "<?php e($variable);?>" to echo and NOT the normal "echo".
This function escapes the variable (using "htmlspecialchars" with ENT_QUOTES flag and 'UTF-8' encoding)
to prevent Cross-Site-Scripting (XSS) attacks.

## Debug

```
d($variable)
```

The "d" (for debug) function logs the contents of a variable to the "Logging" panel of the debugger.
In the debugger the file and line number of the invocation will also be logged.
If the debugger is not loaded (in production) then calls to the function are ignored.
To reduce memory usage this function limits the output:

1.  Only the first 100 characters of each string are logged.
2.  Only the first 25 elements of an array are logged.
3.  Only the first 10 levels of nested objects/arrays are logged.

These 3 limits can be set using 3 optional parameters in the above order.
Hence, calling "d($variable)" is equal to calling "d($variable,100,25,10)".