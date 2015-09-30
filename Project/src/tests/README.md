# Quick guide

## Installation for Linux

### Install lua 5.3.1

Run the following commands:
```
sudo apt-get install libreadline-dev
curl -R -O http://www.lua.org/ftp/lua-5.3.1.tar.gz
tar zxf lua-5.3.1.tar.gz
cd lua-5.3.1
make linux test
sudo make linux install
```
Verify that everything works by running:
```
lua -v
```
The respons should be something like "Lua 5.3.1 ..."
 
### Clone this repo

git clone ...

### Install lunit/lunitx

Navigate to "tests/lunit/":
```
cd tests/lunit
```


Then run:
```
sudo sh install.sh
```


### Install luacov

Navigate to "tests/luacov/luacov-0.8/":
```
cd tests/luacov/luacov-0.8
```

Then run:
```
sudo sh install.sh
```


## Run tests

Navigate to the project root folder.

Then run tests like this:

```
lua tests/main.lua
```

## How to write tests

```
TODO
```

# Links
http://lemock.luaforge.net/userguide.html

https://github.com/dcurrie/lunit/blob/master/DOCUMENTATION

http://luacov.luaforge.net/