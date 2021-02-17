# PyInstaller Docker Images

Use non-root Docker containers to ease compiling Python applications to binaries / exe files.

> ppolxda/pynstaller-linux

## Usage

```bash
docker run --rm -v "$(pwd):/src/" ppolxda/pyinstaller-linux
```

```bash
docker run --rm -v "$(pwd):/src/" --entrypoint /bin/sh ppolxda/pyinstaller-linux -c "apt-get update -y && apt-get install -y wget && /entrypoint.sh"
```

```bash
docker run --rm -v "$(pwd):/src/" ppolxda/pyinstaller-linux "pyinstaller your-script.py"
```

## Build

```bash
docker build --rm --tag=ppolxda/pyinstaller-linux .
```

```bash
docker build --rm --tag=ppolxda/pyinstaller-linux --build-arg PYPI_INDEX_URL_ARG=https://pypi.douban.com/simple/ . 
```
