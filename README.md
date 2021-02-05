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
2021/01/28 14:35:06 Version: 1.1.24
2021/01/28 14:35:06 Hash: 3e85ca5e44e4f9f24c9195309e0a65f1e2548df3
2021/01/28 14:35:06 Build date: 2021-01-28 13:56:50 +0000 UTC
appix> exit
```
