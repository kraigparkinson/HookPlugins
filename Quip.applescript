use AppleScript version "2.4" -- Yosemite (10.10) or later
use scripting additions

on openItem()
	
end openItem

on getName()
	tell application "System Events"
		tell process "Quip"
			tell window 1
				get title
			end tell
		end tell
	end tell
end getName

on getAddress()
	tell application "System Events"
		tell process "Quip"
			tell window 1
				
				set UP_ARROW to 126
				--			key code down_arrow
				key code UP_ARROW using command down
				keystroke "a" using {command down, shift down}
				delay 0.5
				get the clipboard
			end tell
		end tell
	end tell
end getAddress

on newItem()
	tell application "Quip" to activate
	
	tell application "System Events"
		tell process "Quip"
			click menu item "New Document" of menu "File" of menu bar item "File" of menu bar 1
			
			tell window 1
				
				set UP_ARROW to 126
				--			key code down_arrow
				key code UP_ARROW using command down
				keystroke "a" using {command down, shift down}
				delay 0.5
				get the clipboard
			end tell
		end tell
	end tell
end newItem