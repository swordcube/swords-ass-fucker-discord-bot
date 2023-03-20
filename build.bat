@echo off
cls
haxe build.hxml
cd bin/cpp
Main.exe
cd ../../