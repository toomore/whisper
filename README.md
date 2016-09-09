whisper
========

Write some notes by using the GPG encrypts.

Usage:
-------

```
Usage: ./whisper.sh [command]

Commands:
  new  Create an new txt
  e    Encrypt all txt
  env  Show user key info
```

User Info:
-----------

    pub   4096R/8AFC3169 2016-05-26
    Key fingerprint = 422B 779C D894 982B C41E  85EE 3624 CAD7 8AFC 3169
    uid Toomore Chiang <toomore0929@gmail.com>

Get public Key

    gpg -v --recv-keys 422b779cd894982bc41e85ee3624cad78afc3169
