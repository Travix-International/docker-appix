## Docker-Appix

Image embedding the releases of [`appix`](https://github.com/Travix-International/appix/tree/master)

The tag are following the [releases](https://github.com/Travix-International/appix/releases) from the `appix` repository.

It starts from the version [1.1.6](https://github.com/Travix-International/appix/releases/tag/1.1.16).

For using 

### Usage

```bash
$> docker run -e APPIX_AUTH=$(cat ./auth.json | base64) -it travix/appix
```
