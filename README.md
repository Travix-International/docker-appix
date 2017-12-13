## Docker-Appix

Image embedding the releases of [`appix`](https://github.com/Travix-International/appix/tree/master)

The tag are following the [releases](https://github.com/Travix-International/appix/releases) from the `appix` repository.

It starts from the version [1.1.6](https://github.com/Travix-International/appix/releases/tag/1.1.16).

For using 

### Usage

```bash
$> docker run -e APPIX_AUTH=$(cat ./auth.json | base64) -it travix/appix
appix> echo $APPIX_AUTH > ~/.appix/auth.json
appix> appix version
2017/12/13 17:24:54 Version: 1.1.16
2017/12/13 17:24:54 Hash: a4a1892ffe7433bae294c22fa58d0ecf325297d4
2017/12/13 17:24:54 Build date: 2017-07-03 14:03:28 +0000 UTC
appix> exit
```
