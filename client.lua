-----------------------------------
-- STARTED PROJECT FROM 12.08.2018
-- Author: XaskeL
-- it so easy!
-----------------------------------
local iDelayUpdate 			= 0
local iDelayMS 				= 8

local getElementsByType		= getElementsByType
local getTickCount			= getTickCount
local getPlayerWeapon		= getPlayerWeapon
local getPedTask			= getPedTask
local getElementPosition	= getElementPosition

local centerx, centery		= guiGetScreenSize() -- center of screen
	  centerx, centery		= centerx / 2, centery / 2

local math.sqrt				= math.sqrt

local function getPlayers(bInStream)
	return getElementsByType('player', root, bInStream)
end

local function isPlayerAiming(player)
	if getPedTask(player, 'secondary', 0) == 'TASK_SIMPLE_USE_GUN' then
		return true
	end
end

addEventHandler( 'onClientResourceStart', resourceRoot, 
	function()
		if getPlayerWeapon(localPlayer) < 1 then
			return
		end
	
		if bCheckOnCamera then
			if isPlayerAiming(localPlayer) then
				for i, player in ipairs( getPlayers(true) ) do
					local x,y,z 	= getElementPosition(player)
					local coords 	= { getScreenFromWorldPosition ( x, y, z ) }
					if math.sqrt( (coords[1] - centerx) ^ 2 + (coords[2] - centery) ^ 2) < iFovCheckOnCamera then

					end
				end
			end
		end
		
	end
);

local function underTheSelf()
	
end

addEventHandler( 'onClientRender', resourceRoot,
	function()
		if getTickCount() > iDelayUpdate then
			iDelayUpdate = getTickCount() + iDelayMS -- MAX_FPS = 100; 1000/MAX_FPS=10 MS; 1000 / (10 + 8) = 55 UPDATES IN SECOND
			underTheSelf()
		end
	end
);