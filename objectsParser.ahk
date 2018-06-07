vanillaObjects := []
monolithicObjects := []

;Parses the vanilla objects from Vanilla Objects.txt
parseVanillaObjects(){
    global vanillaObjects
    global vanillaObjectsFile
    if (FileExist("Vanilla Objects.txt")){
        ;MsgBox, , Title, exists
    } else {
        MsgBox, , Title, does not exists
    }
    Loop, Read, Vanilla Objects.txt
    {
        vanillaObjects[A_Index] := new ObjectAbstraction( A_LoopReadLine, "")
    }


}

;Parses extras located in the user set "extras" folder
parseExtras(){
    global vanillaObjects
    parseAdditionalPaths()
    monolithicParser()
    IniRead, pdExtrasFolder, settings.ini, Folders, extrasFolder , error
    if ( pdExtrasFolder=error ){
        ;TrayTip, Pd AutoComplete, Error in parsin extras`nPlease set pd folder, 5000
        ;Sleep 5000
        MsgBox, , PD AutoComplete error, Please set the extras directory in your puredata folder`nIt should look like that, for example:`nC:\PureData\pd-0.47-1.msw\pd\extra
        FileSelectFolder, pdExtrasFolder
        if ( pdExtrasFolder = "" ){ ;canceled
            MsgBox, , Error, Operation canceled`nOnly vanilla objects will be available.
            return
        }
            
        MsgBox, % pdExtrasFolder
        IniWrite, %pdExtrasFolder%, settings.ini, Folders, extrasFolder
    } else {
        TrayTip, Pd AutoComplete, parsing extras in `n%pdExtrasFolder%, 1000
    }
    parseFolder(pdExtrasFolder)
    ;C:\Users\User\Dropbox\PureData\pd-0.47-1.msw\pd\extra
}

;parse folder given as argument
parseFolder( path ){
    global vanillaObjects
    ;FileDelete, test.txt
    extensions := "pd|dll"
    ;extensionsLoop:
    Loop, Parse, extensions , |
    {
        currentExtension := A_LoopField
        ;MsgBox, % "parsing extension " . currentExtension
        ;folder:
        Loop, Files, %path%\*.*, D ;directories (D) and not files (F)
        {
            parentFolder := A_LoopFileName
            ;MsgBox, % "entering folder: " . parentFolder
            ;subfolders:
            Loop, Files, %path%\%parentFolder%\*.%currentExtension%, F ;files
            {   
                ;MsgBox, ,, ParentFolder = %parentFolder%`nFile number %A_Index% is %A_LoopFileName%.
                StringRight, end, A_LoopFileName, 8
                if ( end != "-help.pd" ){
                    libraryName := parentFolder
                    StringLeft, objectName, A_LoopFileName, StrLen(A_LoopFileName)-StrLen(currentExtension)-1
                    ;FileAppend, %libraryName%/%objectName%`n, test.txt
                    temp := new ObjectAbstraction( libraryName . "/" . objectName, "")
                    ;TrayTip, heh, % "reading object " . libraryName . "/" . objectName
                    ;Sleep, 100
                    vanillaObjects.push(temp)
                }


            }

        }
    }
    ;MsgBox, , Title, Done
}

;Paths installed externals and abstractions
;To get the paths ser by the user in the pure data's window "edit->preferences->path" we look at the registry at:
;HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Pd
parseAdditionalPaths(){
    Loop,
    {
        RegRead, reg, HKEY_LOCAL_MACHINE, SOFTWARE\Wow6432Node\Pd, path%A_Index%
        If (ErrorLevel!=0){
            TrayTip, Pd Autocomplete, % " Done reading extras on " . reg . " additional folders", 1-
            ;Sleep, 1000
            break
        }
        TrayTip, Pd Autocomplete, reading extras on folder`n%reg%, 1
        parseFolder( reg )
    }
}

;Parses the objects contained in monolithicLibs.txt
monolithicParser(){
    ;lists made by using the source of this page
    ;with this regex
    ;(?<=">).*(?=<\/td>)(?=.*\n.*zexy)
    ;http://blog.joehahn.ws/list-puredata-objects-and-extended-objects
    global monolithicObjects
    if (FileExist("monolithicLibs.txt")){
        ;MsgBox, , Title, exists
    } else {
        MsgBox, , PD AutoComplete, ERROR: could not "find monolithicLibs.txt". Could not load externals from the monolithic libs.
        return
    }
    Loop, Read, monolithicLibs.txt
    {
        ;TrayTip, title, %A_Index%, 3000
        slashIndex := InStr(A_LoopReadLine, "/" )
        libName := SubStr(A_LoopReadLine, 1, slashIndex-1)
        objName := SubStr(A_LoopReadLine, slashIndex+1)
        temp := new ObjectAbstraction( objName, libName)
        monolithicObjects.push(temp)
    }

}






