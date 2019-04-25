local vehshop = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.08,
		width = 0.2,
	height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Bicycles", description = ""},
			}
		},
		["vehicles"] = {
			title = "VEHICLES",
			name = "vehicles",
			buttons = {
				{name = "Compacts", description = ''},
				{name = "Coupes", description = ''},
				{name = "Sedans", description = ''},
				{name = "Sports", description = ''},
				{name = "Sports Classics", description = ''},
				{name = "Super", description = ''},
				{name = "Muscle", description = ''},
				{name = "Off-Road", description = ''},
				{name = "SUVs", description = ''},
				{name = "Vans", description = ''},				
			}
		},
		["compacts"] = {
			title = "compacts",
			name = "compacts",
			buttons = {
				{name = "Blista", costs = 15000, description = {}, model = "blista"},
				{name = "Brioso R/A", costs = 10000, description = {}, model = "brioso"},
				{name = "Dilettante", costs = 9000, description = {}, model = "Dilettante"},
				{name = "Issi 2 Convertible", costs = 20000, description = {}, model = "issi2"},
				{name = "Panto", costs = 9000, description = {}, model = "panto"},
				{name = "Prairie", costs = 25000, description = {}, model = "prairie"},
				{name = "Rhapsody", costs = 5000, description = {}, model = "rhapsody"},
			}
		},
		["coupes"] = {
			title = "coupes",
			name = "coupes",
			buttons = {
				{name = "Cognoscenti Cabrio", costs = 150000, description = {}, model = "cogcabrio"},
				{name = "Exemplar", costs = 220000, description = {}, model = "exemplar"},
				{name = "Felon", costs = 170000, description = {}, model = "felon"},
				{name = "Felon 2", costs = 195000, description = {}, model = "felon2"},
				{name = "Jackal", costs = 175000, description = {}, model = "jackal"},
				{name = "Oracle", costs = 155000, description = {}, model = "oracle"},
				{name = "Oracle 2", costs = 150000, description = {}, model = "oracle2"},
				{name = "Sentinel", costs = 130000, description = {}, model = "sentinel"},
				{name = "Sentinel XS", costs = 150000, description = {}, model = "sentinel2"},
				{name = "Windsor", costs = 200000, description = {}, model = "windsor"},
				{name = "Windsor Convertible", costs = 250000, description = {}, model = "windsor2"},
				{name = "Zion", costs = 125000, description = {}, model = "zion"},
				{name = "Zion 2 ST", costs = 120000, description = {}, model = "zion2"},
				{name = "Futo", costs = 40000, description = {}, model = "futo"},
			}
		},
		["sports"] = {
			title = "sports",
			name = "sports",
			buttons = {
				{name = "Alpha", costs = 175000, description = {}, model = "alpha"},
				{name = "Bestia GTS", costs = 200000, description = {}, model = "bestiagts"},
				{name = "Buffalo", costs = 145000, description = {}, model = "buffalo"},
				{name = "Buffalo S", costs = 155000, description = {}, model = "buffalo2"},
				{name = "Carbonizzare", costs = 350000, description = {}, model = "carbonizzare"},
				{name = "Comet", costs = 175000, description = {}, model = "comet2"},
				{name = "Comet SR", costs = 225000, description = {}, model = "comet5"},
				{name = "Comet Retro", costs = 200000, description = {}, model = "comet3"},
				{name = "Coquette", costs = 200000, description = {}, model = "coquette"},
				{name = "Drift Tampa", costs = 995000, description = {}, model = "tampa2"},
				{name = "Elegy", costs = 150000, description = {}, model = "elegy2"},
				{name = "Elegy Sport", costs = 175000, description = {}, model = "elegy"},
				{name = "Feltzer 2", costs = 195000, description = {}, model = "feltzer2"},
				{name = "Flash GT", costs = 235000, description = {}, model = "flashgt"},
				{name = "Furore GT", costs = 250000, description = {}, model = "furoregt"},
				{name = "Fusilade", costs = 136000, description = {}, model = "fusilade"},
				{name = "Jester", costs = 540000, description = {}, model = "jester"},
				{name = "Jester(Racecar)", costs = 575000, description = {}, model = "jester2"},
				{name = "Kuruma", costs = 135000, description = {}, model = "kuruma"},
				{name = "Lynx", costs = 180000, description = {}, model = "lynx"},
				{name = "Massacro", costs = 299999, description = {}, model = "massacro"},
				{name = "Massacro 2 Sports", costs = 600000, description = {}, model = "massacro2"},
				{name = "NineF", costs = 175000, description = {}, model = "ninef"},
				{name = "NineF 2 Convertible", costs = 180000, description = {}, model = "ninef2"},
				{name = "Omnis", costs = 150000, description = {}, model = "omnis"},
				{name = "Penumbra", costs = 120000, description = {}, model = "penumbra"},
				{name = "Rapid GT", costs = 199000, description = {}, model = "rapidgt"},
				{name = "Rapid GT Convertible", costs = 220000, description = {}, model = "rapidgt2"},
				{name = "Retinue", costs = 25000, description = {}, model = "retinue"},
				{name = "Ruston", costs = 175000, description = {}, model = "ruston"},
				{name = "Sentinel Sport", costs = 170000, description = {}, model = "sentinel3"},
				{name = "Schlagen", costs = 230000, description = {}, model = "schlagen"},
				{name = "Specter", costs = 180000, description = {}, model = "specter"},
				{name = "Surano", costs = 175000, description = {}, model = "surano"},
				{name = "Tropos", costs = 175000, description = {}, model = "tropos"},
				{name = "Verlierer", costs = 550000, description = {}, model = "verlierer2"},
			}
		},
		["sportsclassics"] = {
			title = "sports classics",
			name = "sportsclassics",
			buttons = {
			    {name = "B Type", costs = 50000, description = {}, model = "btype"},
			    {name = "Roseavelt", costs = 150000, description = {}, model = "btype2"},
			    {name = "B Type 3", costs = 175000, description = {}, model = "btype3"},
				{name = "Casco", costs = 150000, description = {}, model = "casco"},
				{name = "Coquette Classic", costs = 175000, description = {}, model = "coquette2"},
				{name = "Coquette", costs = 125000, description = {}, model = "coquette3"},
				{name = "Hermes", costs = 99000, description = {}, model = "hermes"},
				{name = "JB 700", costs = 210000, description = {}, model = "jb700"},
				{name = "Mamba Sports", costs = 145000, description = {}, model = "mamba"},
				{name = "Pigalle", costs = 55000, description = {}, model = "pigalle"},
				{name = "RapidGT Retro", costs = 275000, description = {}, model = "rapidgt3"},
				{name = "Stinger", costs = 175000, description = {}, model = "stinger"},
				{name = "Stinger GT", costs = 155000, description = {}, model = "stingergt"},
				{name = "Feltzer 3", costs = 200000, description = {}, model = "feltzer3"},
				{name = "Tornado 6", costs = 175000, description = {}, model = "tornado6"},
				{name = "Z-Type", costs = 155000, description = {}, model = "ztype"},
			}
		},
		["super"] = {
			title = "super",
			name = "super",
			buttons = {
				{name = "Adder", costs = 6000000, description = {}, model = "adder"},
				{name = "Banshee 900R", costs = 5500000, description = {}, model = "banshee2"},
				{name = "Bullet", costs = 11000000, description = {}, model = "bullet"},
				{name = "Cheetah", costs = 5000000, description = {}, model = "cheetah"},
				{name = "Entity XF", costs = 5950000, description = {}, model = "entityxf"},
				{name = "Sheava", costs = 1495000, description = {}, model = "sheava"},
				{name = "Banshee", costs = 150000, description = {}, model = "banshee"},
				{name = "FMJ", costs = 6350000, description = {}, model = "fmj"},
				{name = "Infernus", costs = 4400000, description = {}, model = "infernus"},
				{name = "Osiris", costs = 7000000, description = {}, model = "osiris"},
				{name = "Reaper", costs = 4500000, description = {}, model = "reaper"},
				{name = "Sultan RS", costs = 1000000, description = {}, model = "sultanrs"},
				{name = "T20", costs = 6700000, description = {}, model = "t20"},
				{name = "Turismo R", costs = 7500000, description = {}, model = "turismor"},
				{name = "Tempesta", costs = 5500000, description = {}, model = "tempesta"},
				{name = "Tyrus", costs = 1550000, description = {}, model = "tyrus"},
				{name = "Vacca", costs = 1400000, description = {}, model = "vacca"},
				{name = "Voltic", costs = 1005000, description = {}, model = "voltic"},
				{name = "X80 Proto", costs = 15000000, description = {}, model = "prototipo"},
				{name = "Zentorno", costs = 7725000, description = {}, model = "zentorno"},
			}
		},
		["muscle"] = {
			title = "muscle",
			name = "muscle",
			buttons = {
				{name = "Blade", costs = 160000, description = {}, model = "blade"},
				{name = "Buccaneer", costs = 130000, description = {}, model = "buccaneer"},
				{name = "Chino", costs = 225000, description = {}, model = "chino"},
				{name = "Deviant", costs = 110000, description = {}, model = "deviant"},
				{name = "Dominator", costs = 100000, description = {}, model = "dominator"},
				{name = "Dominator GTX", costs = 150000, description = {}, model = "dominator3"},
				{name = "Dukes", costs = 162000, description = {}, model = "dukes"},
				{name = "Gauntlet", costs = 150000, description = {}, model = "gauntlet"},
				{name = "Gauntlet 2", costs = 175000, description = {}, model = "gauntlet2"},
				-- {name = "Hotknife", costs = 90000, description = {}, model = "hotknife"}, -- Dragster!!
				{name = "Faction", costs = 136000, description = {}, model = "faction"},
				{name = "Nightshade", costs = 150000, description = {}, model = "nightshade"},
				{name = "Picador", costs = 19000, description = {}, model = "picador"}, 
                {name = "Rat Loader 2", costs = 350000, description = {}, model = "RatLoader2"},
				{name = "Sabre GT", costs = 15000, description = {}, model = "sabregt"},
				{name = "Tampa", costs = 375000, description = {}, model = "tampa"},
				{name = "Virgo", costs = 195000, description = {}, model = "virgo"},
				{name = "Vigero", costs = 121000, description = {}, model = "vigero"},
				{name = "Zion 2", costs = 165000, description = {}, model = "zion2"},
			}
		},
		["offroad"] = {
			title = "off-road",
			name = "off-road",
			buttons = {
				{name = "Bifta", costs = 75000, description = {}, model = "bifta"},
				{name = "Blazer", costs = 18000, description = {}, model = "blazer"},
				{name = "Blazer 3 (R)", costs = 10000, description = {}, model = "blazer3"},
				{name = "Brawler", costs = 275000, description = {}, model = "brawler"},
				{name = "Bubsta 6x6", costs = 300000, description = {}, model = "dubsta3"},
				{name = "Dune Buggy (R)", costs = 25000, description = {}, model = "dune"},
				{name = "Beach Bum Caddy", costs = 50000, description = {}, model = "Kalahari"},
				{name = "Rebel", costs = 22000, description = {}, model = "rebel2"},
				{name = "Sandking", costs = 95000, description = {}, model = "sandking"},
				--{name = "Jeep Trailcat 707hp", costs = 100000, description = {}, model = "trailcat"}, -- Logan please check
				--{name = "The Liberator (R)", costs = 2500000, description = {}, model = "monster"},
				{name = "Trophy Truck (R)", costs =	 550000, description = {}, model = "trophytruck"},
				{name = "Mesa-Sparklez Edt.", costs = 95000, description = {}, model = "mesa3"},
			}
		},
		["suvs"] = {
			title = "suvs",
			name = "suvs",
			buttons = {
				{name = "Baller", costs = 85000, description = {}, model = "baller"},
				{name = "Baller3", costs = 100000, description = {}, model = "baller3"},
				{name = "Baller4", costs = 125000, description = {}, model = "baller4"},
				{name = "Cavalcade", costs = 60000, description = {}, model = "cavalcade"},
				{name = "Cavalcade 2", costs = 70000, description = {}, model = "cavalcade2"},
				{name = "FQ2", costs = 9000, description = {}, model = "fq2"},
				{name = "Granger", costs = 35000, description = {}, model = "granger"},
				{name = "Huntley S", costs = 195000, description = {}, model = "huntley"},
				{name = "Landstalker", costs = 58000, description = {}, model = "landstalker"},
				{name = "Radius", costs = 32000, description = {}, model = "radi"},
				{name = "Rocoto", costs = 150000, description = {}, model = "rocoto"},
				{name = "Seminole", costs = 40000, description = {}, model = "seminole"},
				{name = "XLS", costs = 215000, description = {}, model = "xls"},
			}
		},
		["vans"] = {
			title = "vans",
			name = "vans",
			buttons = {
				{name = "Bison", costs = 30000, description = {}, model = "bison"},
				{name = "Bobcat XL", costs = 23000, description = {}, model = "bobcatxl"},
				{name = "Brute Camper", costs = 30000, description = {}, model = "camper"},
				{name = "Gang Burrito", costs = 45000, description = {}, model = "gburrito"},
				{name = "Gang Burrito 2", costs = 50000, description = {}, model = "gburrito2"},
				{name = "Journey", costs = 25000, description = {}, model = "journey"},
				{name = "Minivan", costs = 10000, description = {}, model = "minivan"},
				{name = "Minivan 2", costs = 15000, description = {}, model = "minivan2"},
				{name = "Paradise", costs = 15000, description = {}, model = "paradise"},
				{name = "Rumpo", costs = 12000, description = {}, model = "rumpo"},
				{name = "Rumpo 3", costs = 135000, description = {}, model = "rumpo3"},
				{name = "Surfer", costs = 5000, description = {}, model = "surfer"},
				{name = "Youga", costs = 11000, description = {}, model = "youga"},
			}
		},
		["sedans"] = {
			title = "sedans",
			name = "sedans",
			buttons = {
				{name = "Asea", costs = 25000, description = {}, model = "asea"},
				{name = "Asterope", costs = 30000, description = {}, model = "asterope"},
				{name = "Cognoscenti", costs = 1000000, description = {}, model = "cognoscenti"},
				{name = "Cognoscenti 55", costs = 1000000, description = {}, model = "cog55"},
				{name = "Fugitive", costs = 24000, description = {}, model = "fugitive"},
				{name = "Glendale", costs = 20000, description = {}, model = "glendale"},
				{name = "Ingot", costs = 9000, description = {}, model = "ingot"},
				{name = "Intruder", costs = 35000, description = {}, model = "intruder"},
				{name = "Premier", costs = 10000, description = {}, model = "premier"},
				{name = "Primo", costs = 9000, description = {}, model = "primo"},
				{name = "Primo Custom", costs = 9500, description = {}, model = "primo2"},
				{name = "Regina", costs = 8000, description = {}, model = "regina"},
				{name = "Schafter 2", costs = 150000, description = {}, model = "schafter2"},
				{name = "Schafter 3", costs = 250000, description = {}, model = "schafter3"},
				{name = "Stanier", costs = 10000, description = {}, model = "stanier"},
				{name = "Stratum", costs = 50000, description = {}, model = "stratum"},
				{name = "Stretch", costs = 65000, description = {}, model = "stretch"},
				{name = "Sultan", costs = 50000, description = {}, model = "sultan"},
				{name = "Super D", costs = 120000, description = {}, model = "superd"},
				{name = "Surge", costs = 38000, description = {}, model = "surge"},
				{name = "Tornado", costs = 10000, description = {}, model = "tornado"},
				{name = "Tailgater", costs = 275000, description = {}, model = "tailgater"},
				{name = "Warrener", costs = 120000, description = {}, model = "warrener"},
				{name = "Washington", costs = 15000, description = {}, model = "washington"},
			}
		},
		["motorcycles"] = {
			title = "MOTORCYCLES",
			name = "motorcycles",
			buttons = {
				{name = "Akuma", costs = 19000, description = {}, model = "AKUMA"},
				{name = "Bagger", costs = 25000, description = {}, model = "bagger"},
				{name = "Bati 801", costs = 50000, description = {}, model = "bati"},
				{name = "Bati 801RR", costs = 75000, description = {}, model = "bati2"},
				{name = "BF400", costs = 95000, description = {}, model = "bf400"},
				{name = "Carbon RS", costs = 40000, description = {}, model = "carbonrs"},
				{name = "Cliffhanger", costs = 125000, description = {}, model = "cliffhanger"},
				{name = "Daemon", costs = 25000, description = {}, model = "daemon"},
				{name = "Double T", costs = 20000, description = {}, model = "double"},
				{name = "Enduro", costs = 48000, description = {}, model = "enduro"},
				{name = "Faggio 2", costs = 2500, description = {}, model = "faggio2"},
				{name = "Gargoyle", costs = 120000, description = {}, model = "gargoyle"},
				{name = "Hakuchou", costs = 82000, description = {}, model = "hakuchou"},
				{name = "Hexer", costs = 15000, description = {}, model = "hexer"},
				--{name = "Honda Goldwing GL1800", costs = 45000, description = {}, model = "hgwing"}, -- Logan please check
				--{name = "Honda Vario", costs = 9000, description = {}, model = "hvario"}, -- Logan please check
				{name = "Innovation", costs = 90000, description = {}, model = "innovation"},
				{name = "Lectro", costs = 700000, description = {}, model = "lectro"},
				{name = "Nemesis", costs = 24999, description = {}, model = "nemesis"},
				{name = "PCJ-600", costs = 19000, description = {}, model = "pcj"},
				{name = "Ruffian", costs = 19000, description = {}, model = "ruffian"},
				{name = "Sanchez", costs = 25000, description = {}, model = "sanchez"},
				{name = "Sovereign", costs = 90000, description = {}, model = "sovereign"},
				{name = "Thrust", costs = 75000, description = {}, model = "thrust"},
				{name = "Vader", costs = 19000, description = {}, model = "vader"},
				{name = "Vindicator", costs = 500000, description = {}, model = "vindicator"},
			}
		},
		["bicycles"] = {
			title = "Bicycles",
			name = "bicycles",
			buttons = {
				{name = "BMX", costs = 400, description = {}, model = "bmx"},
				{name = "Cruiser", costs = 300, description = {}, model = "cruiser"},
				{name = "Fixter", costs = 450, description = {}, model = "fixter"},
				{name = "Scorcher MTB", costs = 1300, description = {}, model = "scorcher"},
				{name = "Whippet", costs = 1500, description = {}, model = "tribike"},
				{name = "Endurex Ex1", costs = 1750, description = {}, model = "tribike2"},
				{name = "TriCycles Torpedo", costs = 2000, description = {}, model = "tribike3"},
			}
		},
	}
}
local fakecar = {model = '', car = nil}
local vehshop_locations = {
{entering = {-33.803,-1102.322,25.422}, inside = {-46.56327,-1097.382,25.99875, 120.1953}, outside = {-31.849,-1090.648,25.998,322.345}},
}

local vehshop_blips ={}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false
local ibought = ''

local function LocalPed()
return GetPlayerPed(-1)
end

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function IsPlayerInRangeOfVehshop()
return inrangeofvehshop
end

function ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Vehicle shop')
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(vehshop_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(vehshop_blips) do
					if IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and vehshop.opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < 5 then
						DrawMarker(1,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
						drawTxt('Press ~g~ENTER~s~ to buy ~b~vehicle',0,1,0.5,0.8,0.6,255,255,255,255)
						currentlocation = b
						inrange = true
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

function f(n)
return n + 0.0001
end

function LocalPed()
return GetPlayerPed(-1)
end

function try(f, catch_f)
local status, exception = pcall(f)
if not status then
catch_f(exception)
end
end
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
--local veh = nil
function OpenCreator()
	boughtcar = false
	local ped = LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
	--[[Citizen.CreateThread(function()
		RequestModel(GetHashKey('t20'))
		while not HasModelLoaded(GetHashKey('t20')) do
			Citizen.Wait(0)
		end
		veh = CreateVehicle(GetHashKey('t20'),GetOffsetFromEntityInWorldCoords(ped,2.001,0,0),false,true)
		SetModelAsNoLongerNeeded(GetHashKey('t20'))
		SetEntityHeading(veh,pos[4])
		FreezeEntityPosition(veh,true)
		SetEntityCollision(veh,false,false)
		SetEntityInvincible(veh,true)
	end)]]
end
local vehicle_price = 0
function CloseCreator()
	Citizen.CreateThread(function()
		local ped = LocalPed()
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
		else
			local veh = GetVehiclePedIsUsing(ped)
			local model = GetEntityModel(veh)
			local colors = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			local mods = {}
			for i = 0,24 do
				mods[i] = GetVehicleMod(veh,i)
			end
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(veh))
			local pos = currentlocation.pos.outside

			FreezeEntityPosition(ped,false)
			RequestModel(model)
			while not HasModelLoaded(model) do
				Citizen.Wait(0)
			end
			personalvehicle = CreateVehicle(model,pos[1],pos[2],pos[3],pos[4],true,false)
			SetModelAsNoLongerNeeded(model)
			for i,mod in pairs(mods) do
				SetVehicleModKit(personalvehicle,0)
				SetVehicleMod(personalvehicle,i,mod)
			end
			SetVehicleOnGroundProperly(personalvehicle)
			SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
			local id = NetworkGetNetworkIdFromEntity(personalvehicle)
			SetNetworkIdCanMigrate(id, true)
			--Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
			SetEntityAsMissionEntity(personalvehicle, true, true)
			SetVehicleColours(personalvehicle,colors[1],colors[2])
			SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
			TaskWarpPedIntoVehicle(GetPlayerPed(-1),personalvehicle,-1)
			SetEntityVisible(ped,true)

			-------------------------------------- VEHICLE BUYING STUFFS
			local classname = GetDisplayNameFromVehicleModel(GetEntityModel(personalvehicle))
			local plate = GetVehicleNumberPlateText(personalvehicle)
			local colors = table.pack(GetVehicleColours(personalvehicle));
			local extracolors = table.pack(GetVehicleExtraColours(personalvehicle));
			local platestyle = tonumber(GetVehicleNumberPlateTextIndex(personalvehicle));
			local modsTable = {
				[0] = { mod = nil },
				[1] = { mod = nil },
				[2] = { mod = nil },
				[3] = { mod = nil },
				[4] = { mod = nil },
				[5] = { mod = nil },
				[6] = { mod = nil },
				[7] = { mod = nil },
				[8] = { mod = nil },
				[9] = { mod = nil },
				[10] = { mod = nil },
				[11] = { mod = nil },
				[12] = { mod = nil },
				[13] = { mod = nil },
				[14] = { mod = nil },
				[15] = { mod = nil },
				[16] = { mod = nil },
				[20] = { mod = nil },
				[23] = { mod = nil },
				[24] = { mod = nil },
				[25] = { mod = nil },
			}
			for i, t in pairs(modsTable) do
				t.mod = GetVehicleMod(personalvehicle, i);
			end
			local windowtint = tonumber(GetVehicleWindowTint(personalvehicle));
			local wheeltype = tonumber(GetVehicleWheelType(personalvehicle));
			TriggerServerEvent('fsn_cargarage:buyVehicle', ibought, ibought, plate, vehicle_price)
			TriggerEvent('fsn_cargarage:makeMine', personalvehicle, classname, plate)
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

function drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end

function drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

function drawMenuTitle(txt,x,y)
local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function Notify(text)
SetNotificationTextEntry('STRING')
AddTextComponentString(text)
DrawNotification(false, false)
end

function DoesPlayerHaveVehicle(model,button,y,selected)
		local t = false
		--TODO:check if player own car
		if t then
			drawMenuRight("OWNED",vehshop.menu.x,y,selected)
		else
			drawMenuRight(button.costs.."$",vehshop.menu.x,y,selected)
		end
end

local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,201) and IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if vehshop.opened then
			local ped = LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			drawTxt(vehshop.title,1,1,vehshop.menu.x,vehshop.menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, vehshop.menu.x,vehshop.menu.y + 0.08)
			drawTxt(vehshop.selectedbutton.."/"..tablelength(menu.buttons),0,0,vehshop.menu.x + vehshop.menu.width/2 - 0.0385,vehshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vehshop.menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then
						if vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "bicycles" then
							DoesPlayerHaveVehicle(button.model,button,y,selected)
						else
						drawMenuRight(button.costs.."$",vehshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
					if vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "motorcycles" or vehshop.currentmenu == "bicycles" then
						if selected then
							if fakecar.model ~= button.model then
								if DoesEntityExist(fakecar.car) then
									Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
								end
								local pos = currentlocation.pos.inside
								local hash = GetHashKey(button.model)
								RequestModel(hash)
								while not HasModelLoaded(hash) do
									Citizen.Wait(0)
									drawTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)

								end
								local veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
								while not DoesEntityExist(veh) do
									Citizen.Wait(0)
									drawTxt("~b~Loading...",0,1,0.5,0.5,1.5,255,255,255,255)
								end
								FreezeEntityPosition(veh,true)
								SetEntityInvincible(veh,true)
								SetVehicleDoorsLocked(veh,4)
								--SetEntityCollision(veh,false,false)
								TaskWarpPedIntoVehicle(LocalPed(),veh,-1)
								for i = 0,24 do
									SetVehicleModKit(veh,0)
									RemoveVehicleMod(veh,i)
								end
								fakecar = { model = button.model, car = veh}
							end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						ButtonSelected(button)
					end
				end
			end
		end
		if vehshop.opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)


function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "Vehicles" then
			OpenMenu('vehicles')
		elseif btn == "Motorcycles" then
			OpenMenu('motorcycles')
		elseif btn == "Bicycles" then
			OpenMenu('bicycles')
		end
 elseif this == "vehicles" then
		if btn == "Sports" then
			OpenMenu('sports')
		elseif btn == "Sedans" then
			OpenMenu('sedans')
		elseif btn == "Compacts" then
			OpenMenu('compacts')
		elseif btn == "Coupes" then
			OpenMenu('coupes')
		elseif btn == "Sports Classics" then
			OpenMenu("sportsclassics")
		elseif btn == "Super" then
			OpenMenu('super')
		elseif btn == "Muscle" then
			OpenMenu('muscle')
		elseif btn == "Off-Road" then
			OpenMenu('offroad')
		elseif btn == "SUVs" then
			OpenMenu('suvs')
		elseif btn == "Vans" then
			OpenMenu('vans')
	    elseif btn == "Bicycles" then
			OpenMenu('bicycles')
			end
	elseif this == "compacts" or this == "coupes" or this == "sedans" or this == "sports" or this == "sportsclassics" or this == "super" or this == "muscle" or this == "offroad" or this == "suvs" or this == "vans" or this == "industrial" or this == "motorcycles" or this == "bicycles" then
		if tonumber(exports.fsn_main:fsn_GetWallet()) >= button.costs then
			vehicle_price = button.costs
			boughtcar = true
			ibought = button.model
			TriggerEvent('fsn_bank:change:walletMinus', button.costs)
			CloseCreator()
		else
 	  	TriggerEvent('fsn_notify:displayNotification', 'You cannot afford this!', 'centerLeft', 3000, 'error')
		end
	end
end

function OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "vehicles" then
		vehshop.lastmenu = "main"
	elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == "bicycles"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end


function Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		CloseCreator()
	elseif vehshop.currentmenu == "compacts" or vehshop.currentmenu == "coupes" or vehshop.currentmenu == "sedans" or vehshop.currentmenu == "sports" or vehshop.currentmenu == "sportsclassics" or vehshop.currentmenu == "super" or vehshop.currentmenu == "muscle" or vehshop.currentmenu == "offroad" or vehshop.currentmenu == "suvs" or vehshop.currentmenu == "vans" or vehshop.currentmenu == "industrial" or vehshop.currentmenu == "bicycles" or vehshop.currentmenu == "motorcycles" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
		end
		fakecar = {model = '', car = nil}
		OpenMenu(vehshop.lastmenu)
	else
		OpenMenu(vehshop.lastmenu)
	end

end

function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
	RemoveIpl('v_carshowroom')
	RemoveIpl('shutter_open')
	RemoveIpl('shutter_closed')
	RemoveIpl('shr_int')
	RemoveIpl('csr_inMission')
	RequestIpl('v_carshowroom')
	RequestIpl('shr_int')
	--RequestIpl('csr_inMission')
	RequestIpl('shutter_closed')
	--326 car blip 227 225
	ShowVehshopBlips(true)
	firstspawn = 1
end
end)
