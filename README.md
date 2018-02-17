An English-language translation project for Telefang Power & Speed Versions.

To build, the following ROMs of Telefang Power and Speed are required:

```
$ md5sum baserom_pw.gbc baserom_sp.gbc
04f7ea139fef2bc2e3f70b2c23933d2e  baserom_pw.gbc
ebfe05828463cc004898e6a95ee57fea  baserom_sp.gbc
1aaaca6108aae2e85d5fac18eabbe221  baserom_patch.gbc
```

If your Power Version base ROM has an md5 of 8b0a1b6667040a52f6957c0eeea1dbd7,
then you have a known bad dump. You should replace it with a fresh dump from a
legitimate Keitai Denjuu Telefang Power Version cartridge.

baserom_patch.gbc should be the most recent version of the patch - it's required
for extracting the font metrics out of, at least until I remove some terrible
kludges. The md5sum doesn't really matter either - just patch Power or Speed
version with the latest released IPS and call it a baserom.

This disassembly requires rgbds version 0.3.3 to operate. Newer versions may
be incompatible with the custom object files this project generates. In the
event that a new rgbds version is released with a new object file format, we
will update our project to only be compatible with that new version. If you are
using an incompatible version of rgbds, your build will likely fail with errors
such as:

    error: script/mainscript_data.o: Invalid file or object file version [RGB5]
    
In this case, if you are using a newer version of rgbds, then you should file a
bug report and we will upgrade the project to the newer version.