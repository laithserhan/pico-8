pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- star-smatter
-- pixienop (daniel oaks) 2018
scene = "0"
scene_just_entered = true
scene_start_time = 0
base_time = 0

scene_list = {
		"intro-pixienop",
		"intro-starsmatter",
		"intro-black",
		"intro-popin",
}
-- here, we input times in a relative way,
-- but _init turns them into absolutes.
--
-- todo(dan): should we do this with ms to
-- prevent floating point scene/music desyncs?
scene_end_time = {}
scene_end_rtime = {}
scene_end_rtime["intro-pixienop"] = 3
scene_end_rtime["intro-starsmatter"] = 3
scene_end_rtime["intro-black"] = 1.25
scene_end_rtime["intro-popin"] = 15

tprint_current_i = {} -- default is 0 so it prints on first char

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
		if scene == "intro-pixienop" then
				if scene_just_entered then
						music(-1)
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
				if st < 0.25 then
						tstate = 0
				elseif st < 1.35 then
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

				if st < 0.5 or 1.9 < st then
						pal()
						color(1)
						local stf = st
						local fp = 0b0
						if st < 0.5 then
  						fp = 0b0000000000000000
  						while 0.02 < stf do
  								fp = shl(fp, 1)
  								fp += 0b1
  								stf -= 0.02
  						end
  				elseif 1.9 < st then
  						fp = 0b1111111111111111
  						while 1.9 < stf do
  								fp = shl(fp, 1)
  								stf -= 0.035
  						end
  				end
						fillp(fp + 0b0.1)
						rectfill(0, 40, 128, 80)
						fillp()
				end
		elseif scene == "intro-starsmatter" then
				if scene_just_entered then
						music(1)
				end
				
				cls()
				color(1)
				rectfill(0, 0, 128, 128)
				
				if 128 < st*100 then				
						color(0)
						rectfill(0, 61 - min(st*100-128, 128)*0.85, 128, 67 + min(st*100-128, 128)*0.85)

  				color(1)
  				rectfill(0, 61, 128, 67)
				end
				
				color(7)
				rectfill(0, 60, min(st*100, 128), 60)
				rectfill(128 - min(st*100, 128), 68, 128, 68)
				
				tprint("star-smatter", scene_start_time, demotime(), 0.05, nil, 41, 62)
		elseif scene == "intro-black" then
  		color(0)
  		rectfill(0, 128, 128, 128 - min(st*100, 128))
		elseif scene == "intro-popin" then
				-- dodgy sky -- to make betr latr
  		color(1)
  		rectfill(0, 128, 128, 128 - min(st*100, 128))
				
				-- draw charge-up
				if 9.25 < st then
						-- do it
				end
				
				-- draw the lazar
				pal(1, 6)
				pal(4, 5)
				pal(2, 0)
				color(13)
				spr(153, 38, 97 + 50 - 50 * min(st * 0.1, 1), 6, 3)
				pal()
				
				-- draw mountains
				spr(96, 0, 104 + 128 - min(st*100, 128), 16, 3)

				-- draw buildings
				pal(4, 0)
  		spr(144, 0, 112 + 128 - min(st*100, 128), 8, 2)
  		spr(144, 64, 112 + 128 - min(st*100, 128), 8, 2)
  		pal()
  		
				color(7)
				if 8.75 < st then
						print("project star-smatter.", 20, 62)
						tprint("our last hope.", scene_start_time+8.75, demotime(), 0.1, nil, 20, 68)
				elseif 6.75 < st then
						tprint("project star-smatter.", scene_start_time+6.75, demotime(), 0.075, nil, 20, 62)
				elseif 4.7 < st then
						print("we all knew that this", 20, 62)
						print("day would come...", 20, 68)
				elseif 3.6 < st then
						print("we all knew that this", 20, 62)
						tprint("day would come...", scene_start_time+3.6, demotime(), 0.05, nil, 20, 68)
  		elseif 2.5 < st then
						tprint("we all knew that this", scene_start_time+2.5, demotime(), 0.05, nil, 20, 62)
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
		_tprint("1", text, start_time, current_time, per_char_delay, per_char_sound, x, y, col)
end
function tprint2(text, start_time, current_time, per_char_delay, per_char_sound, x, y, col)
		_tprint("2", text, start_time, current_time, per_char_delay, per_char_sound, x, y, col)
end

-- 'shard' is a rough way to handle
-- multiple tprints at once
function _tprint(shard, text, start_time, current_time, per_char_delay, per_char_sound, x, y, col)
		if tprint_current_i[shard] == nil then
				tprint_current_i[shard] = 0
		end

		far_i = 1
		for i=1, #text do
				if start_time + per_char_delay * (i - 1) <= current_time then
						far_i = i
				end
		end
		if tprint_current_i[shard] != far_i then
				tprint_current_i[shard] = far_i
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
00000000000000000000000000000066660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000006666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000666666666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000556666656666665660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000055555556555555566666660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000005555555555555555556556666000000000000000000000000000000000000000000000000000000000000000000066666000000000000000
00000000000005555555555555555555555555666660000000000000000000000000000000000000000000000000000000000000666666666660000000000000
00000000000555555555555555555555555555566666660000000000000000000000000000000000000000000000000000000066666665566666000000000000
00000000005555555555555555555555555555555666666660000000000000000000000000000000000000000000000000066666665555566666655000000000
00000055555555555555555555555555555555555556665666650000000000000000000000000000000000000000000055566666666666665556665550000000
00055555335555555555555555555555555555555555555555665555000000000000000000000000000000000000055555666555555555555555555555550000
55353333333355555555555555555555555555555555555555555555555000000000000000000000000000000055555556665555556665555555555555555555
33333333333335555555555555333333355555333355555555555555555550000000000000000000000000005555566666555555665555555566566555555555
33333333333333335555553333333333335553333335555555555555555555550000000000000000000005555556655555555555555555555556666555555555
33333333333333333555333333333333355533333335553335533555355555555500000000000000055555555556555555555555555555555555556655555555
33333333333333333333333333355333333333333333533333333333333555555555555000005555555555555555555555555555555555555555555665555555
33333553333333333333333333553333333333333333533333333333333355555555555555555555555555555555555555533333333333355555555555553355
33333333333333333333333335555333333333333333333333333333333335555555555555555555555555333355335555333333333333335533335555533335
33333333333533333333333333333353333333333333333333333333333333355555553333355555555533333333333533333333333333333333333333333333
33333333333333333333333333333333333533333333333333333333333333333333333333333555555333333333333333333333333333333333333333333333
33335533333533333333333333333353333333333333333333555333353333333333333333333355553333333333333333333533333333333333333333333333
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000444400000000000000000004440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000411400000000000000000044540000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000441400000000000000000045540044440444400000000000044400000000001111100000000001111111111111111000000000011111000000000
4444000000004140004440000000000004454004114441144000000000444d400000000001444410000000000144444444444410000000000144441000000000
4554400444444144404d440000000004445544044141111140000000444ddd440000000011111111444444441111111111111111444444441111111100000000
4555444411111111444dd444400044445555544411111111444440044dddddd40000000014222222111111111111111111111111111111112222224100000000
5555555516611661dddddddd44004544566554541111666111414404ddd6dddd0000000012444244444442444444421444444244444442144444422100000000
5666556511111111dddd6ddd54444545555555551611111111115444d6dd6d6d0000000014442444444424444444214444442444444421444444211100000000
5555565511116161d6d6dd6d55555555555665551111116111615555dddddd6d000000001442444344424446444214444442444c444214444442144100000000
5655665511611111dddddd6d56556665555555651161661111115565dd6d66dd000000001421444444244444442144e444244444442444b44421444100000000
5565556511111611d6d6d6dd55565555565555551611116116115565d66ddddd0000000012144444424474644244444442144144424444444244444100000000
5555555511111111dddddddd55555555555555551111111111115555dddddddd0000000011444444244444442444e44421444444244434442444444100000000
0000000000000000000000000000000000000000000000000000000000000000000000001444e442444644424444444214444442444444424444442100000000
00000000000000000000000000000000000000000000000000000000000000000000000014444424444444244444442144444424444444244444424100000000
00000000000000000000000000000000000000000000000000000000000000000000000014444244444442444444421444444244444442444444244100000000
000000000000000000000000000000000000000000000000000000000000000000000000144421444444244c4444214444442444444424444442444100000000
00000000000000000000000000000000000000000000000000000a000000000000000000144214444442444444424444444244444442444444244b4100000000
0000000000000000000000000000000000000000a00000000000aa00000000000000000014214444442444444424444444244444442444444244444100000000
0000000000000000000000000000000000000000aa0000000000a000000000000000000012144444424444444244444442444444424444442444444100000000
00000000000000000000000000000000000000000a0000000000a000000000000000000011444444244444442444444424444444244444424444442100000000
00000000000aaaaaa000000000000000000000000a0000000000a000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aa000000a00000000000000000000000aa000000000a000000000000000000000000000000000000007000000000000000000000000000000000000
00000000a00000000a000000000000000000000000a000000000a000000000000000000000000000007000000067600000000000000000000000000000000000
0000000a000000000a000000000000000000000000aa0000000aa000000000000000000000070000076700000777770000000000000000000000000000000000
000000a0000000000a000008808800000000000000aa0000000a0000000000000000000000000000007000000067600000000000000000000000000000000000
00000a00000000000a000080080080000000000000a0a000000a0000000000000000000000000000000000000007000000000000000000000000000000000000
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

