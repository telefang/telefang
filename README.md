A partial disassembly of Telefang Power Version with English translation patch
changes on top, building on top of the last non-version-controlled patch
version, v108.  The IPS patch for this version is included in this repo
and should produce the correct baserom_patch.gbc when patched on top
of a Japanese Telefang Power ROM (md5sum` 8b0a1b6667040a52f6957c0eeea1dbd7`).

To build, the following ROMs of Telefang Power and Speed are required:

```
$ md5sum baserom_pw.gbc baserom_sp.gbc
8b0a1b6667040a52f6957c0eeea1dbd7  baserom_pw.gbc
ebfe05828463cc004898e6a95ee57fea  baserom_sp.gbc
1aaaca6108aae2e85d5fac18eabbe221  baserom_patch.gbc
```

This disassembly uses the `overlay` feature of RGBDS currently only
present in Sanqui's fork: https://github.com/Sanqui/rgbds
