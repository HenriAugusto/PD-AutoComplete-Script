# PD AutoComplete

**DISCONTINUED: If you're using Vanilla you should use [PD AutoComplete Plugin](https://github.com/HenriAugusto/PD-AutoComplete-Plugin).**

This is an autocomplete script made for Pure Data. It uses [Auto Hotkey](https://autohotkey.com/) so right now it's a windows only solution. Since now there is a native (TLC) plugin for PD vanilla i'm keeping this repo online only because it might be useful for people using Purr Data.


![gif demo](https://github.com/HenriAugusto/PD-AutoComplete/blob/master/demo%20images/PD%20AutoCOmplete%20demo.gif)

## Download

See the [releases page](https://github.com/HenriAugusto/PD-AutoComplete/releases)

## PD AutoComplete - Help

**Press ' (apostrophe) to make PD AutoComplete listen to the hotkeys below
all hotkeys only works when a pd window is active**

While PD AutoComplete is listening for hotkeys you can just type the name of the object you want. It will immediately look for it and display a list of matches. 
What you type will appear in the app's bar. You can use the up/down arrow and PgUp/PgDown to navigate. 

After finding the desired object press Enter and PD AutoComplete will type it for you!
How does it works? There is a 'Vanilla Objects.txt' file that it uses to know what are the pd's vanilla objects. It also scans automatically your externals located in the folders you've set into the pd window

**"edit->preferences->path"**

### Options

#### Search modes: exact and skipping

The normal search operation looks for exact occurrences of what you type. Ex: if you're looking for [zexy/polyfun] you could type 'poly' or 'polyfun'.

There is a special operation that looks for the occurentes of the chars you type allowing for 'skips'
For example if instead of typing 'polyfun' you type '.plf' (notice the period before plf!). The app bar will turn green. You might see the results

1. zexy/polyfun
2. mrpeach/life2x

because it found the characters p, l and f in that order

1. zexy/[p]o[l]y[f]un
2. mr[p]each/[l]i[f]e2x

#### Searching monolithic libs

Some libraries like zexy have a file that contains a group of externals. If you're on windows and using zexy for example it will be "zexy.dll"

There are two particularities on this case

1. You can't use a forward declaration to create those objects. For example, you can NOT create a [zexy/demux] object
for that you must use [declare -lib zexy] and then type just [demux]
2. PD AutoComplete can not guess what abstractions are located inside that files.

For that reason there is a "monolithicLibs.txt" where you can write the objects that are contained inside the monolithic libs.
Those are separated in the standard search because of their unique declaration (you must use [declare]) so in order to search them you
must use an "," before the search words. For example if you want to type [demux] search for:

*",demux"*

The app bar will turn purple to indicate you're searching monolithic abstraction. After pressing enter it will ignore the "zexy/" from [zexy/demux] and type just [demux].
