tmux
====

For an example configuration see https://github.com/remiprev/tmuxfiles

The tmux man page defines the following elements:

1 tmux `server` process for all session

1 or many tmux client `sessions`

1 or many `windows` in a session

At the bottom of the session there is the `status line`.

A window can be split into 2 or more `panes`.

tmux OPTIONS
============

The appearance and behaviour of tmux may be modified by changing the value of various options.

http://manpages.ubuntu.com/manpages/utopic/en/man1/tmux.1.html#contenttoc8

There are three types of options: server options, session options and window options.

1. `Global options` of the tmux server
--------------------------------------

They do not apply to any particular window or session.

Alter global optipns:

    set-option -s

Display global options:

    show-options -s



2. Session options
------------------

Sessions which do not have a particular option configured inherit the value from the global session options.

List the current options:
  
  show-options

Set or unset session options, list the available server and session options:

  set-option

3. Window Options
-----------------

Windows which do not have a particular option configured inherit the value from the global window options.

List the current options:

    show-window-options

Set or unset session window options, list the available server and session window options:

    set-window-option


Set format
----------

Set the format in which the window is displayed in the
status line window list.

See the `status-left` option for details of special 
character sequences available.  

   `window-status-format` string

The default is ‘#I:#W#F’.
 


Format for current window
-------------------------

Like `window-status-format`, but is the format used when
the window is the current window:

   `window-status-current-format` string


Format for window with activity
-------------------------------

Set status line style for the currently active window:

   `window-status-current-style` style

*For how to specify style, see the message-command-style option*


Format for window with activity alert
-------------------------------------

Set status line style for windows with an activity alert:

   `window-status-activity-style` style


Format for window with bell alert
---------------------------------

Set status line style for windows with a bell alert;

   `window-status-bell-style` style

Format for window with content alert
------------------------------------

Set status line style for windows with a content alert:

   `window-status-content-style` style


Format for window with last activity
------------------------------------

Set status line style for the last active window:

   `window-status-last-style` style


Format for seperator between windows in status line
---------------------------------------------------

Sets the separator drawn between windows in the status
line.  The default is a single space character:

   `window-status-separator` string


*************************************


String will be passed through strftime(3) and
formats (see FORMATS) will be expanded.

It may also contain any of the following special
character sequences:

    Character pair    Replaced with
    #(shell-command)  First line of the command's
                      output
    #[attributes]     Colour or attribute change
    ##                A literal ‘#’

The #(shell-command) form executes ‘shell-command’ and
inserts the first line of its output.  Note that shell
commands are only executed once at the interval specified
by the status-interval option: if the status line is
redrawn in the meantime, the previous result is used.
Shell commands are executed with the tmux global
environment set (see the ENVIRONMENT section).

For details on how the names and titles can be set see
the NAMES AND TITLES section.  For a list of allowed
attributes see the message-command-style option.

Examples are:

    #(sysctl vm.loadavg)
    #[fg=yellow,bold]#(apm -l)%%#[default] [#S]

Where appropriate, special character sequences may be
prefixed with a number to specify the maximum length, for
example ‘#24T’.

By default, UTF-8 in string is not interpreted, to enable
UTF-8, use the status-utf8 option.
