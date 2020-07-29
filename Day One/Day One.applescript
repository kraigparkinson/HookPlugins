use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on openItem()
	
end openItem

-- Relies on: 
--	1. A Keyboard Maestro Macro called Get Name. This in turn depends on #2 and #3.
--	2. A Keyboard Maestro Macro called Trigger Context menu. 
--		Why? I use KM to simulate mouse clicks. For reasons unbeknownst to me,
--		the usual 'AXPress' action on the item is not responding purely via AppleScript.
--	3. JSON Helper, because I'm lazy and it was the closest available JSON parser. 
--		https://apps.apple.com/us/app/json-helper-for-applescript/id453114608?mt=12
on getName()
	tell application "Keyboard Maestro Engine"
		-- Replace the key below with the UUID of the Get Name macro in your library.
		do script "75997582-CA67-4297-A731-B2B4B6737BCE"
		-- or: do script "Get Name"
		-- or: do script "AA1810E9-3A37-47F1-AC87-9515A637F8A7" with parameter "Whatever"
		
		set theName to getvariable "Current Hook Resource Name"
		return theName
	end tell
	
end getName

-- Relies on: 
--	1. A Keyboard Maestro Macro called Get Address. This depends on #2.
--	2. A Keyboard Maestro Macro called Trigger Context menu. 
--		Why? I use KM to simulate mouse clicks. For reasons unbeknownst to me,
--		the usual 'AXPress' action on the item is not responding purely via AppleScript.
on getAddress()
	tell application "Keyboard Maestro Engine"
		-- Replace the key below with the UUID of the Get Address macro in your library.
		do script "020C0E13-26F2-4905-9164-C0A95884F69B"
		-- or: do script "Get Address"
		
		set theAddress to getvariable "Current Hook Resource Address"
		return theAddress
	end tell
	
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
