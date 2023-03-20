@echo off
cls
haxe build_neko.hxml
cd bin/neko
neko main.n
cd ../../