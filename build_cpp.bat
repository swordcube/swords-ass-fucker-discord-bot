@echo off
cls
haxe build_cpp.hxml
cd bin/cpp
Main.exe
cd ../../