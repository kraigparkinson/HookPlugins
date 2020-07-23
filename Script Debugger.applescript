use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on openItem()
	tell application "Script Debugger"
		open "$0"
	end tell
end openItem

on getName()
	tell application "Script Debugger"
		get name of current document of first script window
	end tell
end getName

on getAddress()
	tell application "Script Debugger"
		tell first script window
			tell current document
				set theFile to file spec
				return POSIX path of theFile
			end tell
		end tell
	end tell
end getAddress

on newItem()
	
end newItem
