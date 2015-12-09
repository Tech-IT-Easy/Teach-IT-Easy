# Lua Code Analyser
Generates a UML class diagram of the project

A bit like LuaDoc, it analyses the code but this draws a UML diagram.
The comments in the LUA files have to respect the LUADoc standard to work on some points (inheritance)
The comments have to respect the Tech It Easy coding style to generate more information (such as composition)

## TIELuaAnalyser/
In this folder you can find a project that you can import in Eclispe

## umlgenerator.jar
Executable to generate UML diagram

*How to execute?* `java -jar umlgenerator.jar --src=src --path=`pwd`/src/;cat tie-uml.txt | pbcopy`

*Responsible person:* Laurent Fite
