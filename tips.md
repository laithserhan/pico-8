# Pico-8 Tips and Tricks

Randomly collected from across the BBS and all, just a working doc for me when actively doing stuff.


## Music

Tracks 0-7 are reserved for instruments, use 8+ for regular music tracks.

Instruments by harshness:

    7 0 5 1 3 4 2
    S S S M H H H

Creating a traditional 3-note chippy effect instrument:

    spd 03
    loop 03
    notes 0-1-2 will loop like a chiptune arp
    instruments 0-5-0 sound nice
    octave 2 will make it sound normal when using it

### Extra Music Effects

There's some memory dedicated to special effects which you can't get through the regular tracker GUI:

- `0x5f40`: play channel at half speed
- `0x5f41`: play channel with reverb/unison (a very short delay)
- `0x5f42`: distort the channel (rounds the output waveform to min or max)
- `0x5f43`: play channel with a low-pass filter

For each of these values, bits 0 to 3 correspond to channels 1 to 4 respectively (for example, `poke(0x5f42,2+4)` will apply distortion to channels 2 and 3). Bits 4 to 7 seem to be unused.

Music channel bits are represented as:  `1248`

Might be cool to low-pass music when paused.
