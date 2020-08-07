use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on openItem()
	
end openItem

on getName()
	tell application "System Events"
		tell process "Day One"
			set entryText to value of text area 1 of scroll area 1 of group 1 of splitter group 1 of window 1
			get first paragraph of entryText
		end tell
	end tell
end getName

on getAddress()
	set the clipboard to ""
	delay 0.05
	
	tell application "System Events"
		tell process "Day One"
			set entryPane to group 1 of splitter group 1 of window 1
			set theEntryMenuButton to (first button where its accessibility description = "Entry Menu") of entryPane
			click theEntryMenuButton
			
			delay 0.05
			set entryMenu to menu 1 of theEntryMenuButton
			set shareMenu to menu item "Share" of entryMenu
			click shareMenu
			
			delay 0.05
			click menu item "Copy Entry URL" of menu 1 of shareMenu
		end tell
		
		repeat 50 times -- poll clipboard for ~2.5 seconds
			try
				if (the clipboard) is not equal to "" then
					exit repeat
				end if
			end try
			delay 0.05
		end repeat
		
		set theAddr to (the clipboard) as text
		
	end tell
	
	return theAddr
end getAddress

-- Relies on two items: 
-- 		1. Text script library, from https://github.com/mattneub/applescript-stdlib, installed in ~/Script Libraries
--		2. Day One 2.0 CLI, from https://help.dayoneapp.com/en/articles/435871-command-line-interface-cli
on newItem()
	set entryText to "$title"
	set theResult to do shell script "/usr/local/bin/dayone2 new \"" & entryText & "\""
	set theRegex to "(?:(?:.*)Created new entry with uuid: )([\\d|\\w]{32})"
	tell script "Text" to set theResult to (search text theResult for theRegex using pattern matching)
	set theUUID to foundText of first item of foundGroups of first item of theResult
	set theEntryAddress to "dayone2://view?entryId=" & theUUID
	get theEntryAddress
end newItem
