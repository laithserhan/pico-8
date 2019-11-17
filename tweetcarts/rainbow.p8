pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
_pal={0,8,9,10,3,12,140,2}
for i,c in pairs(_pal) do
	pal(i-1,c,1)
end

function saw(t,m)
		m *= 0.5
		return m + m*(((m+t)%1)*2-1)
end

::w::
st=t()

cls(0)

for i=0,6 do
for y=0,127 do
x=35+i*10+sin(st+i*0.2+y*0.02)*5.9
--pset(y,x,i+1)
line(y,x,y,128,i+1)
end
end

flip()
goto w
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000