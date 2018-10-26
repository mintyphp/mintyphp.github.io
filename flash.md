# Flash

The instance is stored in the global "Flash" class.

Typical usage is that a page does something and then redirects or reloads. To show the status of the action on the next page 'flash messages' are used. They are typically represented in the view with a green yellow or red bar with a message inside.

## set

```
Flash::set($type,$message)
```

This stores a flash message of the specified type in the session. Every type can hold one single message. Last write wins. Example:

```
Flash::set('success','Your changes have been saved.')
```

NB: This should be called from an action (.php) not a view (.phtml), because then the session is already closed and cannot be written anymore.

## get

```
Flash::get()
```

This gets and removes all flash messages from the session. Since the messages are removed you shoudl only call this function once. Example:

```
$flash=Flash::get();
```

NB: This should be called from an action (.php) not a view (.phtml), because then the session is already closed and cannot be written anymore.
