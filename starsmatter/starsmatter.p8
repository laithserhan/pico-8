pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- starsmatter
-- pixienop (daniel oaks) 2018
scene = "0"
scene_just_entered = true
scene_start_time = 0
base_time = 0

scene_list = {
		"intro-popup",
}
-- here, we input times in a relative way,
-- but _init turns them into absolutes.
--
-- todo(dan): should we do this with ms to
-- prevent floating point weirdness when
-- moving times over?
scene_end_time = {}
scene_end_rtime = {}
scene_end_rtime["intro-popup"] = 3

tprint_current_i = 0 -- 0 so it prints on first char

-- demotime returns the current time,
-- fixed for demo replays and such :)
function demotime()
		return time() - base_time
end

function scenetime()
		return demotime() - scene_start_time
end

function _init()
		print("initializing")
		
		-- set initial scene
		scene = scene_list[1]
		
		-- make proper scene end times
		local stime = 0
		for i=1, #scene_list do
				local sname = scene_list[i]
				stime += scene_end_rtime[sname]
				scene_end_time[sname] = stime
		end
		
		base_time = time()
end

function _update()
		if scene_end_time[scene] < demotime() then
				scene_just_entered = true
				for i=1, #scene_list do
						if scene_list[i] == scene then
								if i == #scene_list then
										-- restart the demo
										scene = scene_list[1]
										base_time = time()
								else
										scene = scene_list[i+1]
								end
								break
						end
				end
		end
end

function _draw()
--		print("scene " .. scene .. " - time " .. demotime())

		-- update scene start time
		if scene_just_entered then
				scene_start_time = demotime()
		end
		local st = scenetime()

		-- draw scene details
		if scene == "intro-popup" then
				if scene_just_entered then
						sfx(1)
				end
		
				cls()
				color(1)
				rectfill(0, 0, 128, 128)

				-- draw the logo grey first
				pal()
				pal(10, 6)
				pal(9, 6)
				pal(8, 5)
				spr(176, 25, 39, 9, 5)
				
				color(7)
				pal()
				
				local tstate = st
				if st < 0.7 then
						tstate = 0
				elseif st < 1.5 then
						tstate = st - 0.5
						tstate *= 11
						tstate = flr(tstate)
						while 3 < tstate do
								tstate -= 3
						end
				else
						tstate = 4
				end
				
				if tstate == 0 then
						palt(8, true)
						palt(9, true)
						palt(10, true)
				elseif tstate == 1 then
						palt(8, true)
						palt(10, true)
				elseif tstate == 2 then
						palt(8, true)
						palt(9, true)
				elseif tstate == 3 then
						palt(9, true)
						palt(10, true)
				end
				spr(176, 25, 39, 9, 5)

				if st < 0.5 then
						pal()
						color(1)
						local fp = 0b0000000000000000
						local stf = st
						while 0.02 < stf do
								fp = shl(fp, 1)
								fp += 0b1
								stf -= 0.02
						end
						fillp(fp + 0b0.1)
						rectfill(0, 40, 128, 80)
						fillp()
				end
		end

		-- centre line
		--rectfill(63, 0, 64, 128)
		
		-- make sure starting scene marker is disabled
		if scene_just_entered then
				scene_just_entered = false
		end
end

-- typewriter print, takes:
-- - text
-- - started time of printing
-- - current time of printing
-- - per-character delay in secs
-- - per-character sound effect
-- - <other standard print() args>
function tprint(text, start_time, current_time, per_char_delay, per_char_sound, x, y, col)
		far_i = 1
		for i=1, #text do
				if start_time + per_char_delay * (i - 1) <= current_time then
						far_i = i
				end
		end
		if tprint_current_i != far_i then
				tprint_current_i = far_i
				-- skip spaces
				if sub(text, far_i, far_i) != " " then
  				if per_char_sound != nil then
  						sfx(per_char_sound)
  				end
 		end
		end
		if col != nil then
				print(sub(text, 1, far_i), x, y, col)
		elseif x != nil and y != nil then
				print(sub(text, 1, far_i), x, y)
		else
				print(sub(text, 1, far_i))
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
00000000000008000080800000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000
00000000000008000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000008800000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000002d565295552b5452856529555265452453528535245252852524515285122850100001000001865418641186311862118615000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011800001d3241d325180051c30521324213251c305213051a3241a32500000243051832418325000001c3051d3241d325180051c3051c3241c3251c30521305213242132500000243051f3241f325000001c305
011800000214502145021450214500145001450014500145051450514505145051450414504145051450714502145021450214502145001450014500145001450914509145071450714504145041450514505145
011800000e225002000e225002001c7000e1171c7001d7000c225002000c225002001c7000e1161d1141d125132251322513225002000e4150e4250e4250e435102250020010225002001a225002001a22500200
011800001a33300000000001d6051d655000001a333000001a333300003c6140000000000000001d655000001a33300000000001d655000001d655000001d6551a333000001a333000001d655000001d6551d654
__music__
01 090a0b4c
00 090a0b4c
00 090a0b0c
02 090a0b0c

