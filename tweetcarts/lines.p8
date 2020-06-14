pico-8 cartridge // http://www.pico-8.com
version 18
__lua__


::w::
u=t()
cls()
srand()

for i=0,50 do
	a,b=0,0
	for j=0,1 do
		c,d=a,b
		a=rnd(250)+(u+j/200)*rnd(120)
		if .5<rnd(1) then
			a*=-1
		end
		b=rnd(250)+(u+j/200)*rnd(120)
		if .5<rnd(1) then
			b*=-1
		end
	end
	line(a%250-50,b%250-50,c%250-50,d%250-50,rnd(16))
end


flip()goto w
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
