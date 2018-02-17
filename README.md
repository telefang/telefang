A partial disassembly of Telefang Power Version.

To build, the following ROMs of Telefang Power and Speed are required:

```
$ md5sum baserom_pw.gbc baserom_sp.gbc
04f7ea139fef2bc2e3f70b2c23933d2e  baserom_pw.gbc
ebfe05828463cc004898e6a95ee57fea  baserom_sp.gbc
```

If your Power Version base ROM has an md5 of 8b0a1b6667040a52f6957c0eeea1dbd7,
then you have a known bad dump. You should replace it with a fresh dump from a
legitimate Keitai Denjuu Telefang Power Version cartridge. The correctness
checks in this project will fail if you use a bad dump.