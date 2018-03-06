# Telefang – The English fan translation

This right here is a work-in-progress English fan translation of *[Keitai Denjuu Telefang](https://en.wikipedia.org/wiki/Keitai_Denj%C5%AB_Telefang)*, a wonderful RPG and creature collection game for the Game Boy Color!

![Title screen](https://i.imgur.com/WhgvKU8.png)

More screenshots can be found [below](#screenshots).

## How to download and play

To play Telefang in English, let these simple steps lead you to success!

1. Obtain a ROM for *Keitai Denjuu Telefang*, either *Power Version* or *Speed Version* depending on which one you want to play.
2. Download the latest version of the translation patch from **[the releases page](https://github.com/telefang/telefang/releases)** – click the link that ends in `.ips` and corresponds to the version you have!
3. Use an IPS patching program (like [Floating IPS](https://www.romhacking.net/utilities/1040/), for example) to patch the original ROM with the IPS file.
4. Play your English Telefang ROM on an emulator or a flash cart! Enjoy!

Don't forget to tell people about the translation if you like it! Tweeting about it, telling friends about it, or lasering "CHECK OUT THE TELEFANG FAN TRANSLATION" into the moon's surface are all hugely appreciated.

## Who are we?

We're **Tulunk Village**, the internet's first, probably only, and definitely coolest Telefang community! We can be found at [Telefang.net](http://telefang.net/), from where you can find all sorts of Telefang resources.

Like Telefang? Wanna talk to the programmers and translators? Just want to talk with some like-minded people? We run **[a Discord for everything Telefang](https://discord.gg/BMqRucb)**, and we'd be happy to see you there!

## Problems

Have you found a bug? Is there something you'd like us to change? Please [open an issue here on GitHub](https://github.com/telefang/telefang/issues) about it (or even fix it yourself and open a pull request, if you're feeling up to it)!

## Technical stuff

### ROMs built

This repository builds the following ROMs:

* Telefang: Power Version (`telefang_pw_english.gbc`)
* Telefang: Speed Version (`telefang_speed_english.gbc`)
* Telefang: Power Version without RTC (`telefang_pw_english_nortc.gbc`)
* Telefang: Speed Version without RTC (`telefang_sp_english_nortc.gbc`)

The latter two may be useful for testing the game without RTC on emulator. On actual hardware, the two ROMs will play exactly the same.

### How to build

This project uses a bunch of Linux tools to build, so if you're on Windows, you'll first of all have to [install and use the Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

To build the finished ROMs, three base ROMs are required: `baserom_pw.gbc` (*Power Version*), `baserom_sp.gbc` (*Speed Version*), and `baserom_patch.gbc`. The latter is the latest version of the patch, which you can get by copying either a *Power* or *Speed* ROM and patching it with the latest IPS. Eventually, `baserom_patch` won't be required... but for the moment, that's the way this imperfect world works.

After placing them in the top-level directory, you can check their hashes to make sure you've got the right files:

```
$ md5sum baserom_pw.gbc baserom_sp.gbc
04f7ea139fef2bc2e3f70b2c23933d2e  baserom_pw.gbc
ebfe05828463cc004898e6a95ee57fea  baserom_sp.gbc
```

If your *Power Version* base ROM has an MD5 hash of `8b0a1b6667040a52f6957c0eeea1dbd7`, it's a known bad dump. In that case, replace it with a correct dump from a legitimate Keitai Denjuu Telefang Power Version cartridge.

The following needs to be installed in order to build:

* Python (on Linux or Windows with the Linux subsystem, it'll most likely already be installed)
* [RGBDS](https://github.com/rednex/rgbds#2-building-rgbds-from-source) version 0.3.5 (follow the instructions in the readme on the GitHub page to install)

Once that's all in order, just run `make` (or `make -j4` if you don't have all day), and the finished ROMs will be built.

## Screenshots

![Screenshots](https://i.imgur.com/LVaVBuR.png)

[Back up ↑](#readme)
