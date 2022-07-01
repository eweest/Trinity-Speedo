-- -- ABOUT SCRIPT
script_name("Trinity Speedo")
script_version("1.0")
script_author("eweest")
script_description("01.07.2022")
script_url("https://vk.com/gtatrinitymods")

---- ASSETS [START]

-- LIB
local sampev = require("lib.samp.events")

-- -- RESOLUTION
-- local sX, sY = getScreenResolution()
-- local pX, pY = sX/1920, sY/1080

-- CHAT
local TAG = "Trinity Mods"
local CMD_SCRIPT = "/speedo"
local COLOR_CHAT = {
	["DONE"] = "0xFFCC00", -- Tangerine Yellow (YELLOW)
	["WARNING"] = "0xFF9832", -- Neon Carrot (ORANGE)
	["ERROR"] = "0xFF3232", -- Red Orange (RED)
}

local TRINITYGTA_IP = {
	["RPG"] = "185.169.134.83",
	["RP1"] = "185.169.134.84",
	["RP2"] = "185.169.134.85"
}

local loadTexture = {}

-- PATHS
local DIRECT = getWorkingDirectory()
local CONFIG_PATH = "/config/"
local FOLDER_MAIN_PATH = "Trinity GTA Mods/"
local FOLDER_PATH = thisScript().name .. "/"
local TEXTURES_PATH = "textures/"
local DB_PATH = "settings.json"
-- GIT-HUB PATH
local GIT_REP_AND_NAME = "Trinity-Speedo"
local UPDATE_JSON_PATH = "https://raw.githubusercontent.com/eweest/" .. GIT_REP_AND_NAME .. "/main/assets/update.json"
local UPDATE_FILE_PATH = "https://raw.githubusercontent.com/eweest/" .. GIT_REP_AND_NAME .. "/main/" .. GIT_REP_AND_NAME .. ".lua"

-- TEXTURES
local TEXTURES = {  -- NAME, URL
	["BACKGROUND"] = {"background.png", "https://github.com/eweest/Trinity-Speedo/raw/main/assets/textures/background.png"},
	["BAR_SPEED"] = {"bar-speed.png", "https://github.com/eweest/Trinity-Speedo/raw/main/assets/textures/bar-speed.png"},
	["BAR_FUEL"] = {"bar-fuel.png", "https://github.com/eweest/Trinity-Speedo/raw/main/assets/textures/bar-fuel.png"},
	["ICON_TURBO"] = {"icon-turbo.png", "https://github.com/eweest/Trinity-Speedo/raw/main/assets/textures/icon-turbo.png"},
	["ICON_FUEL"] = {"icon-fuel.png", "https://github.com/eweest/Trinity-Speedo/raw/main/assets/textures/icon-fuel.png"},
	["ICON_DOOR"] = {"icon-door.png", "https://github.com/eweest/Trinity-Speedo/raw/main/assets/textures/icon-door.png"},
	["ICON_ENGINE"] = {"icon-engine.png", "https://github.com/eweest/Trinity-Speedo/raw/main/assets/textures/icon-engine.png"},
	["ICON_VEHHP"] = {"icon-vehhp.png", "https://github.com/eweest/Trinity-Speedo/raw/main/assets/textures/icon-vehhp.png"},
}
-- FONTS
local FONTS = {
	["STD"] = renderCreateFont("Arial", 8, 5),
	["SPEED"] = renderCreateFont("Roboto", 28, 3),
	["SPEED_ALT"] = renderCreateFont("Roboto", 12, 2),
	["SPEED_NUM"] = renderCreateFont("Roboto", 10, 1),
	["FUEL"] = renderCreateFont("Roboto", 12, 1),

	["CHECK"] = renderCreateFont("Roboto", 12, 1),
	["ENGINE"] = renderCreateFont("Roboto", 10, 1),

	["MILES"] = renderCreateFont("Roboto", 10, 1),
	["TURBO"] = renderCreateFont("Roboto", 14, 1),
	["NUMBER-1"] = renderCreateFont("Arial", 12, 5),
}
-- SOUNDS
local SOUNDS = {
	["ERROR"] = 1055,
	["DONE"] = 1083,
	["CANCEL"] = 1085
}
-- ACCEPT VEH's ID
local VEH_IDs = {  
	400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 
	432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 
	464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 
	497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 
	531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 
	563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 
	595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611
}

-- CONFIG "settings.json"
local CONFIG = { 
	["RPG"] = {
		["posX"] = 0,
		["posY"] = 0,
		["FUEL_PROCENT"] = false,
		["VIEW"] = true,
		["COLOR"] = "99C31F"
	},
	["RP1"] = {
		["posX"] = 0,
		["posY"] = 0,
		["FUEL_PROCENT"] = false,
		["VIEW"] = true,
		["COLOR"] = "99C31F"
	},
	["RP2"] = {
		["posX"] = 0,
		["posY"] = 0,
		["FUEL_PROCENT"] = false,
		["VIEW"] = true,
		["COLOR"] = "99C31F"
	},
	["AUTOUPDATE"] = false
}

-- SCRIPT FOLDER
if not doesDirectoryExist(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH) then
	createDirectory(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH)
end
-- TEXTURE FOLDER
if not doesDirectoryExist(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. TEXTURES_PATH) then
	createDirectory(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. TEXTURES_PATH)
end

-- TEXTURES DOWNLOAD
for TEXTURE, NAME_URL in pairs(TEXTURES) do
	if not doesFileExist(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. TEXTURES_PATH .. NAME_URL[1]) then
		downloadUrlToFile(NAME_URL[2], DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. TEXTURES_PATH .. NAME_URL[1])
	end
end

-- JSON PATH
if not doesFileExist(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH ..  FOLDER_PATH .. DB_PATH) then 
	local file = io.open(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH ..  FOLDER_PATH .. DB_PATH, "w") 
	file:write(encodeJson(CONFIG))  
	io.close(file)
end

if doesFileExist(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH ..  FOLDER_PATH .. DB_PATH) then
    local file = io.open(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH ..  FOLDER_PATH .. DB_PATH, 'r') 
    if file then 
        DB = decodeJson(file:read("*a")) 
        io.close(file)
    end 
end
---- ASSETS [END]

-- VEH VARIABLE
local getVehFuel = "0"

-- MAIN [START]
function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	-- CHECK UPDATE
	if DB["AUTOUPDATE"] then
		DB["AUTOUPDATE"] = true
		autoupdate(UPDATE_JSON_PATH, TAG, UPDATE_FILE_PATH)
	else
		print("Автообновление Отключено.")
	end

	-- TRINITY SERVERS
	local IP = sampGetCurrentServerAddress()

	-- CHECK ALL TRINITY SERVERS
	if IP:find(TRINITYGTA_IP["RPG"]) or IP:find(TRINITYGTA_IP["RP1"]) or IP:find(TRINITYGTA_IP["RP2"]) then
		-- LOAD TEXTURES
		for TEXTURE, PATH in pairs(TEXTURES) do
			local TEXTURE_PATH = ( DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. TEXTURES_PATH )

			loadTexture[TEXTURE] = renderLoadTextureFromFile(TEXTURE_PATH .. PATH[1])
		end
		-- CHECK TRINITY SERVERS
		if IP:find(TRINITYGTA_IP["RPG"]) then
			GET_SERVER = "RPG"
		elseif IP:find(TRINITYGTA_IP["RP1"]) then
			GET_SERVER = "RP1"
		elseif IP:find(TRINITYGTA_IP["RP2"]) then
			GET_SERVER = "RP2" 
		end
		--
		TRINITYGTA = true
		sendToChatMsg(string.format("Ресурс {FFCC00}%s (v%s){FFFFFF} запущен. Автор: {FFCC00}eweest{FFFFFF}. Помощь {FFCC00}%s", thisScript().name, thisScript().version, CMD_SCRIPT), "done")

	else
		TRINITYGTA = false
		sendToChatMsg(string.format("Ресурс {FFCC00}%s (v.%s){FFFFFF} не запущен. так как вы играете не на Trinity GTA.", thisScript().name, thisScript().version), "warning")
		unloadScript()
	end

	-- COMMANDS
	sampRegisterChatCommand("speedo", function(cmd) -- HELP
		if (cmd == "view" or cmd == "vw") then -- VIEW MODE
			DB[GET_SERVER]["VIEW"] = not DB[GET_SERVER]["VIEW"]
			if DB[GET_SERVER]["VIEW"] then
				DB[GET_SERVER]["VIEW"] = true
				sendToChatMsg(string.format("Показ ресурса {FFCC00}%s {32FF32}включен.", thisScript().name), "done")
				addOneOffSound(0.0, 0.0, 0.0, SOUNDS["DONE"])
			else
				DB[GET_SERVER]["VIEW"] = false
				sendToChatMsg(string.format("Показ ресурса {FFCC00}%s {FF3232}отключен.", thisScript().name), "done")
				addOneOffSound(0.0, 0.0, 0.0, SOUNDS["CANCEL"])
			end
		saveDB()
		elseif (cmd == "update" or cmd == "up") then -- UPDATE
			DB["AUTOUPDATE"] = not DB["AUTOUPDATE"]
			if DB["AUTOUPDATE"] then
				DB["AUTOUPDATE"] = true
				sendToChatMsg(string.format("Автообновление для ресурса {FFCC00}%s {32FF32}включено.", thisScript().name), "done")
				addOneOffSound(0.0, 0.0, 0.0, SOUNDS["DONE"])
			else
				DB["AUTOUPDATE"] = false
				sendToChatMsg(string.format("Автообновление для ресурса {FFCC00}%s {FF3232}отключено.", thisScript().name), "done")
				addOneOffSound(0.0, 0.0, 0.0, SOUNDS["CANCEL"])
			end
		saveDB()		
		reloadScript()
		elseif (cmd == "procent" or cmd == "pt") then -- CHANGE FUEL PROCENT
			DB[GET_SERVER]["FUEL_PROCENT"] = not DB[GET_SERVER]["FUEL_PROCENT"]
			if DB[GET_SERVER]["FUEL_PROCENT"] then
				DB[GET_SERVER]["FUEL_PROCENT"] = true
				sendToChatMsg(string.format("Показ топлива в процентах для ресурса {FFCC00}%s {32FF32}включен.", thisScript().name), "done")
				addOneOffSound(0.0, 0.0, 0.0, SOUNDS["DONE"])
			else
				DB[GET_SERVER]["FUEL_PROCENT"] = false
				sendToChatMsg(string.format("Показ топлива в процентах для ресурса {FFCC00}%s {FF3232}отключено.", thisScript().name), "done")
				addOneOffSound(0.0, 0.0, 0.0, SOUNDS["CANCEL"])
			end
		saveDB()
		elseif (cmd == "reset") then -- REMOVE SETTINGS
			os.remove(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. DB_PATH)
			sendToChatMsg(string.format("Файл с настройками ресурса {FFCC00}%s {FF3232}сброшен.", thisScript().name), "done")
			addOneOffSound(0.0, 0.0, 0.0, SOUNDS["DONE"])
			reloadScript()
		elseif (cmd == "resetall") then -- REMOVE CACHE
			sendToChatMsg(string.format("Вы произвели {FF3232}сброс всех{FFFFFF} файлов ресурса {FFCC00}%s.", thisScript().name), "done")
			addOneOffSound(0.0, 0.0, 0.0, SOUNDS["DONE"])
			removeFilesCache()
			reloadScript()

		elseif #cmd == 0 then -- OPEN HELP MENU
			createWindowHelp()
			addOneOffSound(0.0, 0.0, 0.0, 1139)
		else
			sendToChatMsg(string.format("Неизвестная команда. Введите {FFCC00}%s.", CMD_SCRIPT), "error")
			addOneOffSound(0.0, 0.0, 0.0, SOUNDS["ERROR"])
		end

		if cmd ~= "" or cmd ~= nil then
			local cX, cY = cmd:match("(%d+)[-]+(%d+)")
			if cmd:find("^pos") then -- CHANGE POSITION
				if cX ~= nil and cX ~= "" and cY ~= nil and cY ~= "" then
					DB[GET_SERVER]["posX"] = tonumber(cX)
					DB[GET_SERVER]["posY"] = tonumber(cY)
					sendToChatMsg(string.format("Положение ресурса {FFCC00}%s {32FF32}сохранено. {FFFFFF}Координаты X-Y:{FFCC00} %s-%spx", thisScript().name, cX, cY), "done")
					addOneOffSound(0.0, 0.0, 0.0, SOUNDS["DONE"])
				else
					setPosition = true
					sendToChatMsg("Для сохранения, нажмите {FFCC00}Левую Кнопку Мыши {FFFFFF}или{FFCC00} ENTER.", "warning")
					sendToChatMsg(string.format("Для перемещения по координатам. Введите {FFCC00}%s (pos)ition X-Y", CMD_SCRIPT), "warning")
				end
			saveDB()
			end
			local COLOR = cmd:match("color (%w+)")
			if cmd:find("^color") then -- CHANGE COLOR
				if COLOR ~= nil and COLOR ~= "" and COLOR:len() == 6 then
					DB[GET_SERVER]["COLOR"] = COLOR
					sendToChatMsg(string.format("Цвет ресурса {FFCC00}%s{FFFFFF} изменен. Актуальный цвет: [ {%s}#%s{FFFFFF} ]", thisScript().name, COLOR, COLOR), "done")
					addOneOffSound(0.0, 0.0, 0.0, SOUNDS["DONE"])
				else
					sendToChatMsg(string.format("Вы ввели некорректно команду, либо код цвета. Введите: {FFCC00}%s color FFFFFF", CMD_SCRIPT), "error")
					addOneOffSound(0.0, 0.0, 0.0, SOUNDS["ERROR"])
				end
			saveDB()
			end
		end
	end)
-- BODY [START]
	while true do wait(0)
		-- SET POSITION
		if setPosition then
		local curX, curY = getCursorPos()
			showCursor(true, true)
			DB[GET_SERVER]["posX"], DB[GET_SERVER]["posY"] = curX - 128, curY - 128

			if isKeyDown(0x01) or isKeyDown(0x0D) then -- LMB or ENTER
				showCursor(false, false)
				sendToChatMsg(string.format("Положение ресурса {FFCC00}%s {32FF32}сохранено. {FFFFFF}Координаты X-Y:{FFCC00} %s-%spx", thisScript().name, DB[GET_SERVER]["posX"], DB[GET_SERVER]["posY"]), "done")
				addOneOffSound(0.0, 0.0, 0.0, 1057)
				setPosition = false
				saveDB()
			end
		end
		----
		if TRINITYGTA == true then
			-- CREATE SPEEDO
			if DB[GET_SERVER]["VIEW"] then	
				if isCharInAnyCar(PLAYER_PED) then
				local veh = storeCarCharIsInNoSave(PLAYER_PED)
				local getVehID = getCarModel(veh) -- VEH ID	
					for _, vehID in ipairs(VEH_IDs) do
						if getDriverOfCar(veh) == PLAYER_PED and getVehID == vehID then
							if not sampIsScoreboardOpen() and not sampTextdrawIsExists(invID) and not sampTextdrawIsExists(chipID) then
								createSpeedo() -- CREATE CUSTOM SPEEDO
							end
							deleteStockSpeedometer() -- DELETE STANDART SPEEDO
						end
					end
				else
					getVehTurbo = nil
					getVehMile = nil
					while not isCharInAnyCar(PLAYER_PED) do wait(0) end
				end
			end
		end
	end
-- BODY [END]
	wait(-1)
end
-- MAIN [END]

-- FUNC CREATE SPEEDO [START]
function createSpeedo()
	local getVehHandle = storeCarCharIsInNoSave(PLAYER_PED) -- VEH HANDLE
	local getVehID = getCarModel(getVehHandle) -- VEH ID

    local isVehFuelTank = isVehFuelTank or getVehFuel -- FUEL MAX

    local setVehFuel = getVehFuel -- FUEL ACTUAL

    local setVehSpeed = getCarSpeed(getVehHandle)*2.8 -- VEH SPEED
    local gear = getCarCurrentGear(getVehHandle) -- VEH GEAR
    
    local isVehHealth = getCarHealth(getVehHandle) -- VEH HP (1000)
    local setVehHealth = math.ceil((isVehHealth - 250) / 7.5) -- VEH HP (100%)

    local setVehMile = tonumber(getVehMile) -- VEH MILES

    local setVehTurbo = getVehTurbo -- Турбо-тюнинг

    local posX, posY = DB[GET_SERVER]["posX"], DB[GET_SERVER]["posY"]

-- TABLE's
	-- VEH FUEL TANK TABLE
	local FUELTANK = {
		["15"] = { 448, 574 },
		["20"] = { 457, 462, 530, 571, 572, 583 },
		["25"] = { 471 },
		["30"] = { 461, 463, 468, 485, 521, 522, 523, 581 },
		["35"] = { 586 },
		["40"] = { 401, 402, 404, 410, 412, 415, 419, 421, 424, 426, 434, 436, 439, 467, 478, 492, 507, 516, 542, 543, 547, 580 },
		["42"] = { 517},
		["45"] = { 405, 411, 420, 429, 438, 455, 458, 466, 474, 475, 541, 479, 491, 496, 506, 518, 525, 526, 527, 529, 533, 534, 536, 540, 541, 
				   545, 546, 549, 550, 551, 555, 558, 559, 560, 561, 562, 565, 566, 567, 568, 573, 575, 576, 585, 587, 589, 602, 603, 604, 605 
		},
		["50"] = { 400, 409, 418, 422, 423, 440, 442, 451, 473, 482, 477, 480, 482, 579, 531, 535, 552, 579, 582, 588, 596, 597, 598, 600 },
		["55"] = { 413, 414, 431, 437, 459, 472, 489, 494, 502, 503, 504, 505, 595, 599 },
		["60"] = { 416, 428, 444, 470, 483, 532, 539, 554, 556, 557, 601, 609 },
		["65"] = { 490, 495, 498, 500, 508, 544 },
		["66"] = { 453 },
		["70"] = { 407, 408, 443, 427, 486, 499, 524, 528 },
		["75"] = { 456 },
		["80"] = { 433, 455, 578 },
		["110"] = {	406 },
		["120"] = {	432, 452 },
		["150"] = {	430, 446, 493 },
		["200"] = {	403, 447, 460, 469, 476, 487, 488, 497, 512, 513, 593 },
		["250"] = {	514 },
		["300"] = {	417, 425, 454, 484, 511, 515, 520, 563 },
		["400"] = {	548 },
		["600"] = {	519, 553 },
		["1000"] = { 577, 592 }
	}
	-- COLOR's 
	local ALPHA = {
		["100"] = "0xFF",
		["75"] = "0xC8",
		["50"] = "0x80",
		["25"] = "0x64",
		["15"] = "0x32",
	}

	local COLORS = {
		["SETCOLOR"] = DB[GET_SERVER]["COLOR"],
		["WHITE"] = "FFFFFF",
		["RED"] = "FF0000",
		["LimeGreen"] = "34CE34", -- RPG
		["FIREBRICK"] = "B42224", -- RP1
		["ORANGE"] = "FCA604", -- RP2
		["FUEL"] = {
			["WHITE"] = "FFFFFF",
			["RED"] = "FF0000",
		},
		["ICON"] = {
			["SETCOLOR"] = DB[GET_SERVER]["COLOR"],
			["WHITE"] = "FFFFFF",
		},
	}
	----
	local sizeX, sizeY = 256, 256
	renderDrawTexture(loadTexture["BACKGROUND"], posX, posY, sizeX, sizeY, 0, 0xFFFFFFFF) -- SPEEDO BACKGROUND

	-- SPEED SCALE
	if setVehSpeed == 0 then sLine = -1
	elseif setVehSpeed >= 20 and setVehSpeed <= 39 then sLine = 0
	elseif setVehSpeed >= 40 and setVehSpeed <= 59 then sLine = 1
	elseif setVehSpeed >= 60 and setVehSpeed <= 79 then sLine = 2
	elseif setVehSpeed >= 80 and setVehSpeed <= 109 then sLine = 3
	elseif setVehSpeed >= 100 and setVehSpeed <= 119 then sLine = 4
	elseif setVehSpeed >= 120 and setVehSpeed <= 139 then sLine = 5
	elseif setVehSpeed >= 140 and setVehSpeed <= 159 then sLine = 6
	elseif setVehSpeed >= 160 and setVehSpeed <= 179 then sLine = 7
	elseif setVehSpeed >= 180 then sLine = 8
	end

	for setVehSpeed = 0, sLine do
		renderDrawTexture(loadTexture["BAR_SPEED"], posX, posY, sizeX, sizeY, (30 * setVehSpeed), ALPHA["100"] .. COLORS["SETCOLOR"]) -- SPEED BAR
	end
	-- SPEEDO RENDER [START]
	rdDrawText(string.format("%d", setVehSpeed), posX + 126, posY + 86, FONTS["SPEED"], "center", ALPHA["100"] .. COLORS["WHITE"]) -- SPEED
	rdDrawText("км/ч", posX + 126, posY + 122, FONTS["SPEED_ALT"], "center", 0x50FFFFFF) -- SPEED TITLE
	--
	if setVehMile == nil then
		rdDrawText(string.format("%s км", "0"), posX + 126, posY + 142, FONTS["MILES"], "center", ALPHA["100"] .. COLORS["WHITE"]) -- MILES TITLE
	else
		rdDrawText(string.format("%s км", setVehMile), posX + 126, posY + 142, FONTS["MILES"], "center", ALPHA["100"] .. COLORS["WHITE"]) -- MILES TITLE
	end
	-- POS NUMBER FOR SPEEDO
	local SPEED_NUMERS_POS = { {"0", 60, 172}, {"20", 40, 132}, {"40", 40, 90}, {"60", 64, 54}, {"80", 96, 32}, {"100", 138, 32}, {"120", 174, 54}, {"140", 196, 90}, {"160", 196, 132}, {"MAX", 166, 172} }

	for _, v in pairs(SPEED_NUMERS_POS) do
		rdDrawText(v[1], posX + v[2]+8, posY + v[3]+8, FONTS["SPEED_NUM"], "center", ALPHA["25"] .. COLORS["WHITE"]) -- TEXT
	end
	-- FUEL ASSETS
	for vehFuel, _ in pairs(FUELTANK) do
		for _, vehID in pairs(FUELTANK[vehFuel]) do
			if vehID == getVehID then
				isVehFuelTank = vehFuel
			end
		end
	end

    local FUEL_MATH = math.max(isVehFuelTank / setVehFuel)
	local FUEL_PROCENT = 100 / FUEL_MATH

	if FUEL_PROCENT <= 25 then
		COLORS["FUEL"]["WHITE"] = COLORS["FUEL"]["RED"]
	else
		COLORS["FUEL"]["WHITE"] = COLORS["FUEL"]["WHITE"]
	end
	--
	for FUEL_BAR = 1, FUEL_PROCENT / 1.92 do
		renderDrawTexture(loadTexture["BAR_FUEL"], posX, posY, sizeX, sizeY, (26.5 - FUEL_BAR), ALPHA["100"] .. COLORS["FUEL"]["WHITE"]) -- FUEL BAR
	end

	renderDrawTexture(loadTexture["ICON_FUEL"], posX + 110, posY + 190, 32, 32, 0, ALPHA["100"] .. COLORS["FUEL"]["WHITE"]) -- FUEL ICON
	if DB[GET_SERVER]["FUEL_PROCENT"] then
		rdDrawText(string.format("Бак / %s%%", math.floor(FUEL_PROCENT)), posX+128, posY+250, FONTS["FUEL"], "center", ALPHA["50"] .. COLORS["WHITE"]) -- FUEL TITLE PROCENT
	else
		rdDrawText(string.format("%s из %s л", setVehFuel, isVehFuelTank), posX + 128, posY + 250, FONTS["FUEL"], "center", ALPHA["50"] .. COLORS["WHITE"]) -- FUEL TITLE
	end
	-- ICON TURBO
	if getVehTurbo then
		if getVehTurboON then
			renderDrawTexture(loadTexture["ICON_TURBO"], posX + 96, posY + 156, 64, 32, 0, ALPHA["100"] .. COLORS["SETCOLOR"]) -- ICON TURBO ON
		else
			renderDrawTexture(loadTexture["ICON_TURBO"], posX + 96, posY + 156, 64, 32, 0, ALPHA["15"] .. COLORS["WHITE"]) -- ICON TURBO OFF
		end
	end
	-- ICON ENGINE
	if not isCarEngineOn(storeCarCharIsInNoSave(PLAYER_PED)) then
		renderDrawTexture(loadTexture["ICON_ENGINE"], posX - 20, posY + 148, 32, 32, 0, ALPHA["15"] .. COLORS["ICON"]["WHITE"]) -- ENGINE ICON
	else
		renderDrawTexture(loadTexture["ICON_ENGINE"], posX - 20, posY + 148, 32, 32, 0, ALPHA["100"] .. COLORS["ICON"]["SETCOLOR"]) -- ENGINE ICON
	end
	-- CHECK's
	if getVehEngineCheck or getVehOilCheck then
		rdDrawText("CHECK", posX - 24, posY + 148, FONTS["CHECK"], "right", ALPHA["100"] .. COLORS["RED"]) -- CHECK TITLE
		if getVehEngineCheck then
			rdDrawText("ENG", posX - 48, posY + 168, FONTS["ENGINE"], "right", ALPHA["100"] .. COLORS["RED"]) -- CHECK ENGINE TITLE
		else
			rdDrawText("ENG", posX - 48, posY + 168, FONTS["ENGINE"], "right", ALPHA["15"] .. COLORS["WHITE"]) -- CHECK ENGINE TITLE
		end
		if getVehOilCheck then
			rdDrawText("OIL", posX - 24, posY + 168, FONTS["ENGINE"], "right", ALPHA["100"] .. COLORS["RED"]) -- CHECK OIL TITLE
		else
			rdDrawText("OIL", posX - 24, posY + 168, FONTS["ENGINE"], "right", ALPHA["15"] .. COLORS["WHITE"]) -- CHECK OIL TITLE
		end
	end
	-- ICON DOOR's
	if getCarDoorLockStatus(storeCarCharIsInNoSave(PLAYER_PED)) == 0 then
		renderDrawTexture(loadTexture["ICON_DOOR"], posX - 20, posY + 180, 32, 32, 0, ALPHA["15"] .. COLORS["ICON"]["WHITE"]) -- DOOR ICON
	else
		renderDrawTexture(loadTexture["ICON_DOOR"], posX - 20, posY + 180, 32, 32, 0, ALPHA["100"] .. COLORS["ICON"]["SETCOLOR"]) -- DOOR ICON
	end	
	-- ICON VEH HP
	if setVehHealth <= 25 then
		renderDrawTexture(loadTexture["ICON_VEHHP"], posX - 20, posY + 212, 32, 32, 0, ALPHA["100"] .. COLORS["ICON"]["SETCOLOR"]) -- VEH HP ICON
		if setVehHealth <= -1 then
			rdDrawText(string.format("%s%%", "0"), posX - 24, posY + 218, FONTS["FUEL"], "right", ALPHA["100"] .. COLORS["RED"]) -- VEH HP TITLE
		else
			rdDrawText(string.format("%s%%", setVehHealth), posX - 24, posY + 218, FONTS["FUEL"], "right", ALPHA["100"] .. COLORS["RED"]) -- VEH HP TITLE
		end
	else
		renderDrawTexture(loadTexture["ICON_VEHHP"], posX - 20, posY + 212, 32, 32, 0, ALPHA["100"] .. COLORS["ICON"]["SETCOLOR"]) -- VEH HP ICON
		rdDrawText(string.format("%s%%", setVehHealth), posX - 24, posY + 218, FONTS["FUEL"], "right", ALPHA["50"] .. COLORS["WHITE"]) -- VEH HP TITLE
	end
	----
end
-- FUNC CREATE SPEEDO [END]

-- HELP WINDOW [START]
local TITLE = "Помощь по: {FFFFFF}"
local TITLE_COLOR = "{AFE7FF}"
local TEXT_CMD = [[
{ffcc00}Основные команды:{ffffff}

{AFE7FF}/speedo{ffffff} - Окно помощи
{AFE7FF}/speedo (pos)ition/ (pos)ition [X-Y]{ffffff} - Изменение позиции мышью/ по координатам X-Y
{AFE7FF}/speedo color [HEX]{ffffff} - Установить цвет в формате HEX (прим. FF00FF)
{AFE7FF}/speedo procent (pt){ffffff} - Показать/Скрыть показ топлива в процентах
{AFE7FF}/speedo view (vw){ffffff} - Показать/Скрыть
{AFE7FF}/speedo reset{ffffff} - Сброс всех настроек
{AFE7FF}/speedo resetall{ffffff} - Удаление всех файлов кеша
{AFE7FF}/speedo (up)date{ffffff} - Автообновление (Включить/Выключить)

{ffcc00}Полезные советы:{ffffff}

{AFE7FF}[1]{ffffff} При замене икокнок, используйте размер {ffcc00}32x32{ffffff} пикселя.
{AFE7FF}[2]{ffffff} При замене текстуры спидометра, используйте размер {ffcc00}256x256{ffffff} пикселя.

{ffcc00}О скрипте:{ffffff}

{AFE7FF}Автор скрипта{ffffff}				eweest
]]

if DB["AUTOUPDATE"] == true then
	text = "{32FF32}Включено"
else
	text = "{FF3232}Отключено"
end

local TEXT_NAME = "{AFE7FF}Название скрипта (Версия){ffffff}			" .. thisScript().name .. "{AFE7FF} [" .. thisScript().version .. "]"
local TEXT_URL = "{AFE7FF}Наше сообщество{ffffff}				" .. thisScript().url
local TEXT_DATE = "{AFE7FF}Дата последнего обновления{ffffff}		" .. thisScript().description
local TEXT_UPDATE = "{AFE7FF}Автообновление{ffffff}				" .. text
--
function createWindowHelp()
	sampShowDialog(10001, TITLE_COLOR .. TITLE .. thisScript().name, string.format("%s%s\n%s\n%s\n%s", TEXT_CMD, TEXT_URL, TEXT_NAME, TEXT_DATE, TEXT_UPDATE), "X")
end
-- HELP WINDOW [END]

-- ASSTES / FUNCTIONS
function renderFontDrawTextAlign(font, text, x, y, color, align)
    if not align or align == "left" then renderFontDrawText(font, text, x, y, color) end
    if align == "center" then renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text) / 2, y, color) end
    if align == "right" then renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text), y, color) end
end

function rdDrawText(text, x, y, font, align, color)
    if not align or align == "left" then renderFontDrawText(font, text, x, y, color) end
    if align == "right" then renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text), y, color) end
    if align == "center" then renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text) / 2, y, color) end
end
-- FUNC Send Message to Chat
function sendToChatMsg(text, typeMsg)
	if not typeMsg or typeMsg == "done" then color = COLOR_CHAT["DONE"] end	
	if typeMsg == "warning" then color = COLOR_CHAT["WARNING"] end	
	if typeMsg == "error" then color = COLOR_CHAT["ERROR"] end
	
	sampAddChatMessage(string.format("[%s]: {FFFFFF}%s", TAG, text), color)
end

-- DELETE TEXTDRAWS
function deleteStockSpeedometer()
	sampTextdrawDelete(radioText)
	sampTextdrawDelete(radioOFF)
	sampTextdrawDelete(vehicleInfoTextdraw)
	sampTextdrawDelete(vehicleInfoTextdraw2)
	sampTextdrawDelete(radioStationID)
	sampTextdrawDelete(checkToStart)
end

-- HOOK'S

-- Radio Station List
local radioStationTable = {
	{"TRP2FM", "TRP2 FM"},
	{"radio", "Радио RECORD"},
	{"europa", "Europa Plus"},
	{"NRJ", "NRJ"},
	{"Rock", "ROCK FM"},
	{"RECORD", "RECORD Black"},
	{"Русское", "Русское Радио"},
	{"D", "DFM"},
	{"Retro FM", "Ретро FM"},
	{"Dorozhnoe", "Дорожное радио"},
	{"Радио Шансон", "Радио Шансон"},
	{"100", "100 Hitz"},
	{"Jazz  Radio", "Jazz Radio"},
	{"Soul", "Soul Radio"},
	{"Easy", "Easy Hits Florida"},
	{"181", "181 FM Hip Hop"},
	{"Nashe", "Наше Радио"},
}

-- FUNC onShowTextDraw
function sampev.onShowTextDraw(id, data)

	if data.text:find("‹AЋ …H‹EHЏAP’") then
		invID = id
	end
	if data.text:find("Ѓ…ЋK…") then
		chipID = id
	end

	for _, radio in pairs(radioStationTable) do
		if data.text:find("Radio:") then
			radioText = id
			-- sampTextdrawDelete(id)
		elseif data.text:find("OFF") then
			radioOFF = id
		elseif data.text:find(radio[1]) then
			radioStationID = id
		end
		if data.text:find("~w~press") then
			checkToStart = id		
		end
		if data.text:find("^~n~~n~$") then
			data.text = ""
		end
		return {id, data}
	end
end
-- FUNC onTextDrawSetString
function sampev.onTextDrawSetString(id, text)
    if text:find("Fuel") then
        getVehFuel, getVehSpeed, getVehHealth = text:match("(%d+)[^%d]+(%d+)[^%d]+(%d+)")
		vehicleInfoTextdraw = id
	elseif text:find("~n~~r~Speed") then
		getVehFuel = 0
		getVehSpeed, getVehHealth = text:match("(%d+)[^%d]+(%d+)")
		vehicleInfoTextdraw = id
	end
    if text:find("locked") or text:find("unlocked") then
        getVehMile = text:match("(%d+.%d)")
        getVehEngineCheck = text:match("check engine")
        getVehOilCheck = text:match("check oil")
        
        getVehTurbo = text:match("turbo")
        getVehTurboON = text:match("on")
        getVehTurboOFF = text:match("off")

		vehicleInfoTextdraw2 = id
	end
	if id == radioStationID then
		radioStation = text:gsub("%~%w%~", " ")
    end
end

-- SAVE DATABASE
function saveDB()
	local file = io.open(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. DB_PATH, "w")
	file:write(encodeJson(DB))
	file:flush()
	print("Файл настроек {FFCC00}'" .. DB_PATH .. "'{CCCCCC} успешно сохранен!")
	file:close()
end

-- FUNC RELOAD SCRIPT
function reloadScript()
	lua_thread.create(function()
		wait(500) thisScript():reload()
	end)
end

-- FUNC UNLOAD SCRIPT
function unloadScript()
	lua_thread.create(function()
		thisScript():unload()
	end)
end

-- FUNC DELETE FILES CACHE
function removeFilesCache()
	for TEXTURE, NAME_URL in pairs(TEXTURES) do
		os.remove(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. TEXTURES_PATH .. NAME_URL[1])
	end
	os.remove(DIRECT .. CONFIG_PATH .. FOLDER_MAIN_PATH .. FOLDER_PATH .. DB_PATH)
end

-- AUTO-UPDATE (cred: qrlk / red: eweest)
function autoupdate(json_url, prefix, url)
	local dlstatus = require('moonloader').download_status
	local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
	if doesFileExist(json) then os.remove(json) end
	downloadUrlToFile(json_url, json,
	function(id, status, p1, p2)
		if status == dlstatus.STATUSEX_ENDDOWNLOAD then
			if doesFileExist(json) then
				local f = io.open(json, 'r')
				if f then
					local info = decodeJson(f:read('*a'))
					updatelink = info.updateurl
					updateversion = info.latest
					f:close()
					os.remove(json)
					if updateversion > thisScript().version then
						lua_thread.create(function(prefix)
						local dlstatus = require('moonloader').download_status
						sendToChatMsg(string.format("Найдено обновление для скрипта {FFCC00}%s", thisScript().name), "warning")
						sendToChatMsg(string.format("Идет обновление c версии {FFCC00}%s{FFFFFF} на версию {FFCC00}%s", thisScript().name, updateversion), "warning")
						wait(250)
							downloadUrlToFile(updatelink, thisScript().path, 
							function(id3, status1, p13, p23)
								if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
									print(string.format("Загружено %d из %d.", p13, p23))
								elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
									-- REMOVE FILES
									removeFilesCache()
									--
									print("{32FF32}Загрузка обновления завершена.")
									sendToChatMsg(string.format("Обновление {FFCC00}%s{FFFFFF} завершено!", thisScript().name), "done")
									goupdatestatus = true 
									lua_thread.create(reloadScript()) -- RELOAD SCRIPT
								end
								if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
									if goupdatestatus == nil then
										sendToChatMsg(string.format("Ошибка обновления. Запуск старой версии...", thisScript().name), "error")
										update = false
									end
								end
							end)
						end, prefix)
					else
						update = false
						print("{32FF32}v" .. thisScript().version .. ": Актуальная версия. {CCCCCC}Обновление не требуется.")
					end
				end
			else
				print("{FF3232}v" .. thisScript().version .. ": Не могу проверить обновление. {CCCCCC}Сообщите об этом в нашу группу.")
				update = false
			end
		end
	end)
	while update ~= false do wait(100) end
end
----