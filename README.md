# Keitai Denjuu Telefang (携帯電獣テレファング)

This is a partial disassembly of *[Keitai Denjuu Telefang](https://en.wikipedia.org/wiki/Keitai_Denj%C5%AB_Telefang)*, a wonderful RPG and creature collection game for the Game Boy Color.

## Fan Translation

The English fan translation can be found **[here](https://github.com/telefang/telefang/tree/patch)**, on the `patch` branch of this repository!

## Who are we?

We're **Tulunk Village**, the internet's first, probably only, and definitely coolest Telefang community! We can be found at [Telefang.net](http://telefang.net/), from where you can find all sorts of Telefang resources.

Like Telefang? Wanna talk to the programmers and translators? Just want to talk with some like-minded people? We run **[a Discord for everything Telefang](https://discord.gg/BMqRucb)**, and we'd be happy to see you there!

## Problems

If you find any problems with the disassembly, or there's something you'd like changed or added, you can [open an issue here on GitHub](https://github.com/telefang/telefang/issues) about it (or even fix it yourself and open a pull request, if you're feeling up to it).

## Technical stuff

### ROMs built

This disassembly builds the following ROMs:
* Keitai Denjuu Telefang: Power Version (`telefang_pw.gbc`, MD5 `04f7ea139fef2bc2e3f70b2c23933d2e`)
* Keitai Denjuu Telefang: Speed Version (`telefang_sp.gbc`, MD5 `ebfe05828463cc004898e6a95ee57fea`)

### How to build

To build the finished ROMs, two base ROMs are required: `baserom_pw.gbc` (*Power Version*), `baserom_sp.gbc` (*Speed Version*).

After placing them in the top-level directory, you can check their hashes to make sure you've got the right files:

```
$ md5sum baserom_pw.gbc baserom_sp.gbc
04f7ea139fef2bc2e3f70b2c23933d2e  baserom_pw.gbc
ebfe05828463cc004898e6a95ee57fea  baserom_sp.gbc
```

If your *Power Version* base ROM has an MD5 hash of `8b0a1b6667040a52f6957c0eeea1dbd7`, it's a known bad dump. In that case, replace it with a correct dump from a legitimate Keitai Denjuu Telefang Power Version cartridge.

#### Windows 10 and Linux

If you're on Windows 10 or higher, you'll first of all have to [install and use the Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

The following needs to be installed in order to build:

* Python (on Linux or Windows with the Linux subsystem, it'll most likely already be installed)
* [RGBDS](https://github.com/rednex/rgbds#2-building-rgbds-from-source) version 0.3.6 (follow the instructions in the readme on the GitHub page to install)

#### Windows 8 and Lower

[Download and install Cygwin](http://cygwin.com/install.html) with `make`, `git`, `gcc-core` and `python3`.

[Download the Windows release of RGBDS](https://github.com/rednex/rgbds/releases/) and copy the exe and dll files into `C:\cygwin64\usr\local\bin`.

#### Build

Once that's all in order, just run `make` (or `make -j4` if you don't have all day), and the finished ROMs will be built.
