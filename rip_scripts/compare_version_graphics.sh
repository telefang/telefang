#USAGE: Run in main directory with POWER version graphics in gfx/ and SPEED version in versions/speed/gfx.
#You may need to re-rip some graphics or w/e.

find gfx -type f -exec cmp '{}' versions/speed/'{}' \;
