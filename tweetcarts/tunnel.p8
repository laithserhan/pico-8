pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--<3
pal(3,136,1)pal(4,143,1)pal(6,137,1)c={12,1,2,3,8,14,15,4,6,9,10,12,1,2,3,8,14,15,4,6,9,10}::w::st=t()/2
cs=((1+t()*.9)%1)*(#c/2)
for i=1,250 do st -= .001+sin(st/5)*.003
cx=64+sin(st)*30
cy=64+cos(st)*30
circ(cx,cy,i/2,c[flr(#c/2+(i/250)*(#c/2)-cs)+1])end
flip()goto w
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
