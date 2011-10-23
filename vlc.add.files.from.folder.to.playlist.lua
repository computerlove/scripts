--[[
 Add from directory 

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
--]]

--[[ Extension description ]]

	function descriptor()
		return { title = "Add from folder" ;
				 version = "1.0" ;
				 author = "Marvin Bredal Lillehaug <marvin.lillehaug@gmail.com>" ;
				 shortdesc = "Add files from folder to playlist";
				 description = "<h1>Add from folder</h1>"
							.. ".."
							.. "..";
				 capabilities = { "input-listener", "meta-listener" } }
	end

--[[ Global vars ]]
	path = nil
	target = nil


--[[ Hooks ]]

	-- Activation hook
	function activate()
		vlc.msg.dbg("[Add from folder] Activated")
		start()
	end

	-- Deactivation hook
	function deactivate()
		vlc.msg.dbg("[Add from folder] Deactivated")
	end


--[[ Start ]]

	function start()
		item = vlc.item or vlc.input.item() -- check if an item is playing
		find_similar(item) -- starts the "Find Similar" process
	end

	
function find_similar(item)
	vlc.msg.dbg("[Add Similar] File selected: "..vlc.strings.decode_uri((item:uri())))
	
	-- Check the protocol (currently, only file:/// is supported)
	if string.find(item:uri(), "file:///") then
		similar_media = find_files(item) -- delegate to the find_files
		vlc.msg.dbg("[Add Similar] Files found: "..table.concat(similar_media," , "))
	else
		similar_media = {}
		vlc.msg.dbg("[Add Similar] Unsupported media type.")
		alert("Unsupported media type", "We're sorry, but Add Similar only works on local files right now.")
	end
	
	-- Did it return anything?
	if #similar_media == 0 then -- If nothing was returned, inform the user
		vlc.msg.info("[Add Similar] didn't find similar files")
		alert("No similar files could be found.", "")
	else -- Add the files
		vlc.msg.info("[Add Similar] found similar files")
		for _,file in pairs(similar_media) do 
			local new_item = {}
			new_item.path = "file:///"..path..file
			new_item.name = file
			
			vlc.msg.dbg("[Add Similar] adding: "..path..file)
			vlc.playlist.enqueue({new_item})
		end
		vlc.deactivate()
	end
end

-- This function will find files and add them to a table, which it returns.
function find_files(item)
	-- Scour the directory for files (Starts at position 9 to get rid of "file:///") (TODO: Clean this up!)
	path = vlc.strings.decode_uri(string.sub(item:uri(), 9 , -(string.find(string.reverse(item:uri()), "/", 0, true))))
	target = vlc.strings.decode_uri(string.sub(item:uri(), string.len(item:uri())+2-(string.find(string.reverse(item:uri()), "/", 0, true))), -0)

	vlc.msg.dbg("[Add Similar] Target file: "..target)
	
	vlc.msg.dbg("[Add Similar] Loading directory: "..path)
	
	-- Load directory contents into a table
	local contents = vlc.net.opendir(path)
        local contentPairs = pairs(contents)
	
	-- TEST 2: Analyze the filename to find its structure
	local structure = split(target,"[^%p]+")
	
	vlc.msg.dbg("[Add Similar] Structure: "..table.concat(structure))
	
--	vfor _, file in pairs(contents) do 
		
			
	return similar_media
end



--[[ UTILITY FUNCTIONS ]]--

-- Create an alertbox, also quitting the extension

function alert(title,message)
	local dialog = vlc.dialog("Add Similar")
	dialog:add_label("<h2>"..title.."</h2>", 1, 1, 5, 10)
    dialog:add_label(message, 1, 14, 5, 5, 200)
    dialog:add_button("OK", function () dialog:delete() vlc.deactivate(); return nil end, 3, 20, 1, 5)
end

function close() -- when the messagebox is closed
    vlc.deactivate()
end
