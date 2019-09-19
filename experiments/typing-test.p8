pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
text = "hai mate!"
-- the +1 is to wait 1s before typing
start_typing_at = t() + 1
delay_between_characters = 0.08

function _draw()
		cls(1)
		if start_typing_at < t() then
				chars_to_draw = flr((t() - start_typing_at) / delay_between_characters)
				print(sub(text,1,chars_to_draw),1,50)
		end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
