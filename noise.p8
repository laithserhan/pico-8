pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
seed = 52.4
phase = 2

current = 0

cur = {}
pix = {}
gentime = seed -- start off at seed value

function _init()
		cur.x = -1
		cur.y = 0
		
		for x=0,128 do
				pix[x] = {}
		end
end

function nextpix()
		cur.x += 1
		if cur.x == 128 then
				cur.x = 0
				cur.y += 1
				if cur.y == 128 then
						cur.y = 0
						gentime += 0.2
						phase += 0.1
				end
		end
end

function _update60()
		for i=0,210 do
				nextpix()
				val = noise((cur.x/128) * phase,(cur.y/128) * phase,gentime)
 			pix[cur.x][cur.y] = val
 			
					 if val < -0.5 then
					 		col = 1
					 elseif val < 0 then
					 		col = 2
					 elseif val < 0.5 then
					 		col = 8
					 else
					 		col = 14
					 end
					 
					 pset(cur.x,cur.y,col)
		end
end

function _draw()
		current += 1
		if current == 16 then
				current = 0
		end
		pset(1,1,current)
end





-- copyright (c) 2016 takashi kitao
-- released under the mit license
local _p_f={}
local _p_p={}
local _p_permutation={151,160,137,91,90,15,
  131,13,201,95,96,53,194,233,7,225,140,36,103,30,69,142,8,99,37,240,21,10,23,
  190,6,148,247,120,234,75,0,26,197,62,94,252,219,203,117,35,11,32,57,177,33,
  88,237,149,56,87,174,20,125,136,171,168,68,175,74,165,71,134,139,48,27,166,
  77,146,158,231,83,111,229,122,60,211,133,230,220,105,92,41,55,46,245,40,244,
  102,143,54,65,25,63,161,1,216,80,73,209,76,132,187,208,89,18,169,200,196,
  135,130,116,188,159,86,164,100,109,198,173,186,3,64,52,217,226,250,124,123,
  5,202,38,147,118,126,255,82,85,212,207,206,59,227,47,16,58,17,182,189,28,42,
  223,183,170,213,119,248,152,2,44,154,163,70,221,153,101,155,167,43,172,9,
  129,22,39,253,19,98,108,110,79,113,224,232,178,185,112,104,218,246,97,228,
  251,34,242,193,238,210,144,12,191,179,162,241,81,51,145,235,249,14,239,107,
  49,192,214,31,181,199,106,157,184,84,204,176,115,121,50,45,127,4,150,254,
  138,236,205,93,222,114,67,29,24,72,243,141,128,195,78,66,215,61,156,180
}

for i=0,255 do
  local t=shr(i,8)
  _p_f[t]=t*t*t*(t*(t*6-15)+10)

  _p_p[i]=_p_permutation[i+1]
  _p_p[256+i]=_p_permutation[i+1]
end

local function _p_lerp(t,a,b)
  return a+t*(b-a)
end

local function _p_grad(hash,x,y,z)
  local h=band(hash,15)
  local u,v,r

  if h<8 then u=x else u=y end
  if h<4 then v=y elseif h==12 or h==14 then v=x else v=z end
  if band(h,1)==0 then r=u else r=-u end
  if band(h,2)==0 then r=r+v else r=r-v end

  return r
end

function noise(x, y, z)
  y=y or 0
  z=z or 0

  local xi=band(x,255)
  local yi=band(y,255)
  local zi=band(z,255)

  x=band(x,0x0.ff)
  y=band(y,0x0.ff)
  z=band(z,0x0.ff)

  local u=_p_f[x]
  local v=_p_f[y]
  local w=_p_f[z]

  local a =_p_p[xi  ]+yi
  local aa=_p_p[a   ]+zi
  local ab=_p_p[a+1 ]+zi
  local b =_p_p[xi+1]+yi
  local ba=_p_p[b   ]+zi
  local bb=_p_p[b+1 ]+zi

  return _p_lerp(w,_p_lerp(v,_p_lerp(u,_p_grad(_p_p[aa  ],x  ,y  ,z  ),
                                       _p_grad(_p_p[ba  ],x-1,y  ,z  )),
                             _p_lerp(u,_p_grad(_p_p[ab  ],x  ,y-1,z  ),
                                       _p_grad(_p_p[bb  ],x-1,y-1,z  ))),
                   _p_lerp(v,_p_lerp(u,_p_grad(_p_p[aa+1],x  ,y  ,z-1),
                                       _p_grad(_p_p[ba+1],x-1,y  ,z-1)),
                             _p_lerp(u,_p_grad(_p_p[ab+1],x  ,y-1,z-1),
                                       _p_grad(_p_p[bb+1],x-1,y-1,z-1))))
end

