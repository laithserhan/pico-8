pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- peace and tranquility tunnel
-- shoutout to g4b~
tun2loadcols={0,5,6,5}
tun2cols={8,9,138,139,12,13,141,14}

function tunneldist(x1,y1,x2,y2)
	return sqrt((x1-x2)^2+(y1-y2)^2)
end

function asin(y)
 return atan2(sqrt(1-y*y),-y)
end

function tun2(x,y,tx,ty)
	dist=tunneldist(x,y,tx,ty)
	depth=(((127-dist)/127)^6)*150/1.5
	angle=asin(abs(y-ty)/dist)
	if (x-tx)<=0 then
		angle=angle*-1
	end
	if (y-ty)<0 then
		angle=angle*-1
	end
	return depth+sin(angle*20+depth*.1)
end

for i=0,15 do
	pal(i,tun2loadcols[1+flr((i/4)%4)],1)
end

st=t()
tuncx=64
tuncy=64
for y=0,127 do
	for x=0,127 do
		pset(x,y,tun2(x,y,tuncx,tuncy))
	end
end
rst=t()

::w::
st=t()-rst
tuncx=64+cos(st/100)*15*min(1,st/60)
tuncy=64+sin(st/100)*15*min(1,st/60)

et=max(0,st-4.5)
redraw_y=(st*105)%128

for y=redraw_y,redraw_y+5 do
	for x=0,127 do
		mx=x+sin(y/60)*sin(et/60)*10
		my=y+cos(x/28)*sin(et/60)*10
		pset(x,y,tun2(mx,my,tuncx,tuncy))
	end
end

txt="peace and tranquility"
tt=st
cc=-st*40+2
for i=1,min(et*8,#txt) do
	tt-=.04
	print(sub(txt,i,i), 13+(i-1)*5+sin(tt/5)*10.9, 110+sin(tt)*3.9, cc)
end

--rectfill(1,1,30,5,1)
--print(stat(1),1,1,13)

for i=0,15 do
	pal(i,tun2cols[1+flr((i/2+st*20)%8)],1)
end

flip()goto w
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
