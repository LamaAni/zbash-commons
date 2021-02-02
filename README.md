# zbash-commons

A common bash library that adds loging, regex and other usefull commands to bash

# To install 

```shell
curl -Ls "https://raw.githubusercontent.com/LamaAni/zbash-commons/master/install?ts_$(date +%s)=read" | sudo bash
```

# To use in a script

At the head of your script add,
```shell
#!/bin/bash
source zbash_commons || echo "zbash_commons not found. See https://github.com/LamaAni/zbash-commons for install instructions" && exit 1
```