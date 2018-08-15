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

local sqrt					= math.sqrt

local g_hIsPlayerInCross 	= false

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
		
	end
);

local function underTheSelf()
	if getPlayerWeapon(localPlayer) < 1 then
		return
	end

	g_hIsPlayerInCross = false -- reset state
	
	if isPlayerAiming(localPlayer) then
		local players = getPlayers(true)
		for i, player in ipairs(players) do
			local x,y,z = getElementPosition(player)
			for i = 0, 2 do -- 3
				local coords = { getScreenFromWorldPosition ( x, y, z + (0.25 * i) ) }
				if sqrt( (coords[1] - centerx) ^ 2 + (coords[2] - centery) ^ 2) < iFovCheckOnCamera then
					g_hIsPlayerInCross = true
				end
			end
			if g_hIsPlayerInCross then break end
		end
	end
end

addEventHandler( 'onClientRender', resourceRoot,
	function()
		if getTickCount() > iDelayUpdate then
			iDelayUpdate = getTickCount() + iDelayMS -- MAX_FPS = 100; 1000/MAX_FPS=10 MS; 1000 / (10 + 8) = 55 UPDATES IN SECOND
			underTheSelf()
		end
	end
);