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
local getCamera				= getCamera

local centerx, centery		= guiGetScreenSize() -- center of screen
	  centerx, centery		= centerx / 1.89, centery / 2.5

local sqrt					= math.sqrt

local g_hIsPlayerInCross 	= false

local function getPlayers(bInStream)
	return getElementsByType('ped', root, bInStream)
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

local function getOffsetXY(x,y,rz,angle)
	local offset = math.rad(rz + angle) 
	return x + FOV * math.cos(offset), y + FOV * math.sin(offset) 
end

local function getBoxBorders(x,y,z) 
	local ID = 1
	local data = {}
	local _,_,rz = getElementRotation( getCamera() )
	for i = 0, 180, 180 do -- left and right border
		local px,py = getOffsetXY(x,y,rz,i)
		data[ID] = { getScreenFromWorldPosition( px, py, z ) }
		ID = ID + 1
	end
	return data
end

local function underTheSelf()
	if getPlayerWeapon(localPlayer) < 1 then
		return
	end

	g_hIsPlayerInCross = false -- reset state
	
	if isPlayerAiming(localPlayer) then
		local players = getPlayers(true)
		for i, player in ipairs(players) do
			local x,y,z = getElementPosition(player)
			for i = -2, 3 do -- 6
				-- VERY BAD CHECK, IS NOT SIMPLE!
				local upperSize = z + (0.25 * i)
				local data = getBoxBorders(x,y,upperSize) 
				
				dxDrawRectangle(data[1][1],data[1][2],2,2) -- DEBUG
				dxDrawRectangle(data[2][1],data[2][2],2,2) -- DEBUG
				
				local down = { getScreenFromWorldPosition( x, y, z - 1 ) }
				local up   = { getScreenFromWorldPosition( x, y, z + 1 ) }
				
				dxDrawRectangle(down[1], down[2], 2, 2, tocolor(255,0,0,255)) -- DEBUG
				dxDrawRectangle(up[1], up[2], 2, 2, tocolor(255,0,0,255)) -- DEBUG
				
				outputChatBox('centery: '..centery.. ' down: '..down[2]) -- DEBUG
				if centerx > data[2][1] and centerx < data[1][1] and centery < down[2] and centery > up[2] then -- [2] -- left, [1] -- right
					g_hIsPlayerInCross = player
					outputChatBox( tostring(g_hIsPlayerInCross)..math.random(1,33) ) -- DEBUG
				end
			end
			if g_hIsPlayerInCross then break end
		end
	end
end

addEventHandler( 'onClientRender', root,
	function()
		if getTickCount() > iDelayUpdate then
			iDelayUpdate = getTickCount() + iDelayMS -- MAX_FPS = 100; 1000/MAX_FPS=10 MS; 1000 / (10 + 8) = 55 UPDATES IN SECOND
			underTheSelf()
		end
	end
);