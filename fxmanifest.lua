fx_version "adamant"
game "gta5"
lua54 "yes"

author "meuntouchable#5555"
name "scar_vehiclespawner"
description "[SCAR] Vehicle Spawner by dortey_"
version "1.0.0"

client_scripts {
	"RageUI/RMenu.lua",
	"RageUI/menu/RageUI.lua",
	"RageUI/menu/Menu.lua",
	"RageUI/menu/MenuController.lua",
	"RageUI/components/*.lua",
	"RageUI/menu/elements/*.lua",
	"RageUI/menu/items/*.lua",
	
	"config.lua",
	"function.lua",
	"client.lua",
}

server_scripts {
	"config.lua",
	"server.lua",
}

escrow_ignore {
	"RageUI/RMenu.lua",
	"RageUI/menu/RageUI.lua",
	"RageUI/menu/Menu.lua",
	"RageUI/menu/MenuController.lua",
	"RageUI/components/*.lua",
	"RageUI/menu/elements/*.lua",
	"RageUI/menu/items/*.lua",
	
	"config.lua",
	"function.lua",
	"client.lua",
	"server.lua",
}