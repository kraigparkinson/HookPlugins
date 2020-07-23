use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on openItem()
	set macroId to "$0"
	
	tell application "Keyboard Maestro"
		editMacro macroId
	end tell
end openItem

on getName()
	tell application "Keyboard Maestro"
		set theName to ""
		
		set theMacros to selectedMacros
		set selectedMacroID to first item of theMacros
		
		set matchingMacros to macros whose id is selectedMacroID
		if ((count of matchingMacros) is greater than 0) then
			set theName to name of first item of matchingMacros
		else
			set matchingMacroGroups to macro groups whose id is selectedMacroID
			if ((count of matchingMacroGroups) is greater than 0) then
				set theName to name of first item of matchingMacroGroups
			end if
		end if
		
		return theName
	end tell
end getName

on getAddress()
	tell application "Keyboard Maestro"
		set theMacros to selectedMacros
		return "keyboardmaestro:///m=" & first item of theMacros
	end tell
end getAddress

on newItem()
	tell application "Keyboard Maestro"
		make new macro with properties {name:"$title"}
	end tell
end newItem