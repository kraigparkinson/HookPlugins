use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on openItem()
	
end openItem

on getName()
	tell application "Keyboard Maestro Engine"
		do script "75997582-CA67-4297-A731-B2B4B6737BCE"
		-- or: do script "Get Name"
		-- or: do script "AA1810E9-3A37-47F1-AC87-9515A637F8A7" with parameter "Whatever"
		
		set theName to getvariable "Current Hook Resource Name"
		return theName
	end tell
	
end getName

on getAddress()
	tell application "Keyboard Maestro Engine"
		do script "020C0E13-26F2-4905-9164-C0A95884F69B"
		-- or: do script "Get Address"
		
		set theAddress to getvariable "Current Hook Resource Address"
		return theAddress
	end tell
	
end getAddress

on newItem()
	set entryText to "$title"
	set theResult to do shell script "/usr/local/bin/dayone2 new \"" & entryText & "\""
	set theRegex to "(?:(?:.*)Created new entry with uuid: )([\\d|\\w]{32})"
	tell script "Text" to set theResult to (search text theResult for theRegex using pattern matching)
	set theUUID to foundText of first item of foundGroups of first item of theResult
	set theEntryAddress to "dayone2://view?entryId=" & theUUID
	get theEntryAddress
end newItem

--getAddress()
tell application "Day One" to activate
tell application "System Events"
	
	tell process "Day One"
		try
			tell button 3 of group 1 of splitter group 1 of window "Existential"
				set {xPosition, yPosition} to position
				set {xSize, ySize} to size
			end tell
			-- modify offsets if hot spot is not centered:
			click at {xPosition + (xSize div 2), yPosition + (ySize div 2)}
		end try
		
		--		perform action "AXPress" of button 3 of group 1 of splitter group 1 of window "Existential"
		select button 3 of group 1 of splitter group 1 of window "Existential"
		
		--click button 1 of group 2 of toolbar 1 of window 1
	end tell
end tell