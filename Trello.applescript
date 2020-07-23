use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on openItem()
	
end openItem

on getName()
	tell application "System Events"
		tell process "Trello"
			keystroke "t"
			keystroke "a" using command down
			keystroke "c" using command down
			key code 53
			
			set theName to the clipboard
			return theName
		end tell
	end tell
	
	
end getName

on getAddress()
	tell application "System Events"
		tell process "Trello"
			click menu item "Copy Current URL" of menu "Edit" of menu bar item "Edit" of menu bar 1
			set theURL to the clipboard
			return theURL
		end tell
	end tell
end getAddress

on newItem()
	
end newItem