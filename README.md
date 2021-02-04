# zbash-commons

A common bash library that adds loging, regex and other usefull commands to bash

## BETA

# To install

```shell
curl -Ls "https://raw.githubusercontent.com/LamaAni/zbash-commons/master/install?ts_$(date +%s)=$RANDOM" | sudo bash
```

# To use in a script

At the head of your script add,

```shell
#!/bin/bash
source zbash_commons
if [ $? -ne 0 ]; then
  echo "zbash_commons not found. Please see: https://github.com/LamaAni/zbash-commons"
fi

```

# methods

# Licence

Copyright ©
`Zav Shotan` and other [contributors](../../graphs/contributors).
It is free software, released under the MIT licence, and may be redistributed under the terms specified in [LICENSE](LICENSE).
