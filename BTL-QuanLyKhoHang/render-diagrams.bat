@echo off
chcp 65001 > nul
echo Dang render so do PlantUML voi UTF-8...
java "-Dfile.encoding=UTF-8" -jar plantuml.jar -charset UTF-8 plantuml/*.puml -o ../diagrams/
echo Hoan tat!
pause
