-- Remap Caps Lock to Right Control at the driver level (no System Settings step needed)
hs.execute([[hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E4}]}']])

local controlTapped = false

hs.eventtap
	.new({ hs.eventtap.event.types.flagsChanged }, function(event)
		local rawFlags = event:rawFlags()
		if (rawFlags & 0x00002000) ~= 0 then -- NX_DEVICERCTLKEYMASK (right ctrl only)
			controlTapped = true
		else
			if controlTapped then
				hs.eventtap.keyStroke({}, "escape")
			end
			controlTapped = false
		end
		return false
	end)
	:start()

-- If any key is pressed while holding, it's not a tap
hs.eventtap
	.new({ hs.eventtap.event.types.keyDown }, function(event)
		controlTapped = false
		return false
	end)
	:start()
