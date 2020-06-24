# luacon_bin
Luacon binary executable by terminal
![alt text](https://github.com/coalio/luacon_bin/blob/master/demo/demo1.PNG)

<b>The initial release does not support multiple shells</b>

## Compile source
Source was compiled using https://github.com/LuaDist/srlua

Source is available on this repository

A compiled binary is available in this repository

## Installation
Create an utils folder (Generally inside your "Codes" folder) and add it to your environment `PATH` variable

Add `luacon.exe` `luacon_config` `luacon_utils` to your utils folder, then type `luacon` in your console, you will notice the initialization motd and `>>` prefix waiting for input

## General usage

<h4>Commands:</h4>

```

:q :quit : exit the current luacon instance
:e : collect all entries and save them to a file
```

<hr>

<h4>Aliases:</h4>

`--set` following arguments declare a variable

`luacon --set EXIT_AFTER_EXECUTION true main.lua`

```

EXIT_AFTER_EXECUTION: (true/false) exit luacon after script finished execution
EXIT_IF_EMPTY: (true/false) exit luacon if entry entered was empty or nil
CHANGED_NAME_WARNING: (true/false) in case the executable was renamed, this will show a warning
ENVIRONMENT: (script/none) variables declared will be pushed to the environment specified, if environment is none, any global variables declared will be collected as garbage

```

<hr>

<h4>Config:</h4>

`luacon_config` will be executed as lua everytime luacon starts, meaning, any variables declared within it will be available at the global luacon scope, even if `ENVIRONMENT` was set to none.

Available configuration is documented at `luacon_config`

## Example usage:

Current path: `C:/luaprojects/crenderwrap/`

`luacon --set EXIT_IF_EMPTY true --set debug true init.lua`

Runs `init.lua` at current path and sets `debug` `EXIT_IF_EMPTY` to `true`, they can be accessed from within `init.lua`

<hr>

Current path: `C:/luaprojects`

`luacon --set EXIT_IF_EMPTY true --set debug true crenderwrap/init.lua`

Runs `init.lua` at relative path `crenderwrap/init.lua` and sets `debug` `EXIT_IF_EMPTY` to `true`, they can be accessed from within `init.lua`

<hr>

Current path: `C:/luaprojects/crenderwrap/`

`luacon direct_sheet.lua readAsText --set EXIT_IF_EMPTY true --set debug true init.lua`

Runs `init.lua` at current path and sets `debug` `EXIT_IF_EMPTY` to `true` and they can be accessed from within `init.lua`

`init.lua` will have access to arguments, that is:

```
--> _G['arg']: pairs output
------------------------------
1: direct_sheet.lua

2: readAsText

3: --set

4: EXIT_IF_EMPTY

5: true

6: --set

7: debug

8: true

9: init.lua

0: <luacon.exe absolute path>

```
