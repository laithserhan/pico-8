pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- demo skeleton
current_scene = -2
final_scene = 900 -- set during running

continue_scene = 0

scene_updated_this_pattern = false
scene_just_entered = false

show_debug = false

_demotime_start = 0
_scenetime_start = 0

function demotime()
		return time() - _demotime_start
end

function scenetime()
		return time() - _scenetime_start
end

scene_just_entered = true

function demo_update()
		if stat(20) < 5 then
				if not scene_updated_this_pattern then
						scene_updated_this_pattern = true
						
						if 0 < continue_scene then
								continue_scene -= 1
						else
  						scene_just_entered = true
  						current_scene += 1
  						if final_scene < current_scene then
  								current_scene = 0
  								continue_scene = 0 -- prevent overflows
  						end
  						_scenetime_start = time()
 					end
 					
 					if current_scene == 0 then
								_demotime_start = time()
 					end
				end
		else
				scene_updated_this_pattern = false
		end

		if btnp(4) then
				show_debug = not show_debug
		end
end
-->8
-- runtime
function _init()
		music(0)
end

function _update()
		demo_update()
end

function _draw()
		-- setup
		local dt = demotime()
		local st = scenetime()

		-- drawing
		sc = -1
		if current_scene == sc then
				-- do nothing
				
				-- temp green fill
				color(11)
				rectfill(0, 0, 127, 127)
		end
		
		sc += 1
		if current_scene == sc then
				inpix = min(128, st * 250)

				pnop_x = 28
				pnop_y = 42
				if 127 < inpix then
						cls(0)
						spr(176, pnop_x, pnop_y, 9, 5)
				else
						color(0)
  				for i = 0, 64 do
   					-- left pixels
   					y = i+i
   					line(-1, y, inpix, y)
   
   					-- right pixels
   					y += 1
   					line(128, y, 128-inpix, y)
  				end
  		end
		end
		
		sc += 1
		if current_scene == sc then
				color(3)
				rectfill(0, 0, 127, 127)

				color(11)
				print("welcome to da demo", 30, 50 + sin(dt)*5)
				print("scene "..current_scene, 90 + cos(dt)*4.9, 90 + sin(-dt)*5.9)
		end
		
		sc += 1
		if current_scene == sc then
				if scene_just_entered then
						continue_scene = 1
				end
		
				color(4)
				rectfill(0, 0, 127, 127)
				
				color(15)
				print("welcome to da demo", 30, 50 + sin(dt)*5)
				print("scene "..current_scene, 90 + cos(dt)*4.9, 90 + sin(-dt)*5.9)
		end
		
		if scene_just_entered then
				final_scene = sc
		end
		
		-- print debug info
		if show_debug then
  		-- print scene time lol
  		color(1)
  		rectfill(103, 0, 128, 12)
  		rectfill(0, 0, 40, 18)
  		
  		color(14)
  		print(current_scene, 104, 1)
  		print(st, 104, 1+6)

  		color(7)
  		print("cpu:" .. stat(1), 1, 1)
  		print("    " .. stat(2), 1, 1+6)
  		print("fps:" .. stat(7) .. "/" .. stat(8), 1, 1+6+6)
  end
		
		-- remove scene_just_entered
		if scene_just_entered then
				scene_just_entered = false
		end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000a00000000000aa00000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000aa0000000000a000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000a0000000000a000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000aaaaaa000000000000000000000000a0000000000a000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aa000000a00000000000000000000000aa000000000a000000000000000000000000000000000000000000000000000000000000000000000000000
00000000a00000000a000000000000000000000000a000000000a000000000000000000000000000000000000000000000000000000000000000000000000000
0000000a000000000a000000000000000000000000aa0000000aa000000000000000000000000000000000000000000000000000000000000000000000000000
000000a0000000000a000008808800000000000000aa0000000a0000000000000000000000000000000000000000000000000000000000000000000000000000
00000a00000000000a000080080080000000000000a0a000000a0000000000000000000000000000000000000000000000000000000000000000000000000000
0000a000000000000a000080000080000000000000a0a000000a0000000000000000000000000000000000000000000000000000000000000000000000000000
0000a000000000000a000080000080000000000000a00a00000a0000000000000000000000000000000000000000000000000000000000000000000000000000
000a0a0000000000a0000008000080000000000000a00a00000a0000000000000000000000000000000000000000000000000000000000000000000000000000
00a000a000000000a0000000800080000000000000a000a0000a0000000000000000000000000000000000000000000000000000000000000000000000000000
00a0000a00000000a0000000080800000000000000aa00a0000a00000000000000aa000000000000000000000000000000000000000000000000000000000000
000a000a0000000a000000000080000000000000000900a0000a00000a000000aa0aa00000000000000000000000000000000000000000000000000000000000
00000000a00000a00000000000000000000a00000009000900aa0000a0a000aa00000a0000000000000000000000000000000000000000000000000000000000
00000000900000a000000000000000000aa0a00000090009009a000a000a00a000000aa000000000000000000000000000000000000000000000000000000000
000000000900090000000000000000000a00a000000900009099000a000aa0a0000000a000000000000000000000000000000000000000000000000000000000
00000000090090000000000000000000a00a0000000900009099000a0000a00a00000aa000000000000000000000000000000000000000000000000000000000
00000000009900000000000a000a000aa00a000000090000909900090000a00a00000a0000000000000000000000000000000000000000000000000000000000
0000000000990000a000a00a000a000a0090000000090000999900900000a00a0000aa0000000000000000000000000000000000000000000000000000000000
0000000009900000a000a0a0000a00090900000000090000099000900009900a000aa00000000000000000000000000000000000000000000000000000000000
0000000000090000a0000aa0000990090000000800080000088000900009000a0aaa000000000000000000000000000000000000000000000000000000000000
00000000000900000a00099000009009000000800008000000800080000900099900000000000000000000000000000000000000000000000000000000000000
00000000000900000900099000009008000088000000000000800088008000090000000000000000000000000000000000000000000000000000000000000000
00000000000080000900090900009000888800000000000000800008880000090000000000000000000000000000000000000000000000000000000000000000
00000000000080000900090090008000000000000000000000800000000000080000000000000000000000000000000000000000000000000000000000000000
00000000000080000800800099000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000
00000000000008000080800008000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000
00000000000008000080800000000000000000000aaa099908800888000000800000000000000000000000000000000000000000000000000000000000000000
0000000000000800000000000000000000000000000a090900800808000000800000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000aaa090900800888000000800000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000a00090900800808000000800000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000aaa099908880888000008800000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c105
0110000014155141551414514135131551315513145131350f1550f1550f1450f135111551115511145111350e1550e1550e1450e135131551315513145131351615516155161451613514155141551414514135
01100020275561d5052755611505115001d5001c5001c50000000265002650027500000002d50029500265002650027500295002b5002c5002e50000000000000000000000000000000000000000000000000000
__music__
00 08424344
00 094a4344
00 094a4344
03 090a4344

