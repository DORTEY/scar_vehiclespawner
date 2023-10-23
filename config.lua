Config={};

Config.Settings={
	Menu={
		Command = "cars",--command to open the menu
		Key = "F5",--key to open the menu
		Cooldown = 2*1000,--the cooldown between engine swaps (in that case its 2 seconds)
		Position = "right",--choose between left and right
		ShowVehName = true,--disable it (false) if you dont need/want
		
		Text={
			Title = "Vehicle Spawner",
			SubTitle = "Vehicle Spawner",
		},
	},
	
	WhitelistedMessage = "This is a Donator Vehicle!",
}

Config.Vehicles={
	["Benefactor"]={--category name in UI (you can add unlimited categories and sounds)
		{name="Dubsta",fname="dubsta"},--first argument is the name of the car   second argument is the spawn name (addon vehicle support aswell)
		{name="Feltzer",fname="feltzer2"},
		{name="Krieger",fname="krieger"},
		{name="Schafter",fname="schafter2"},
		{name="Schafter V12",fname="schafter3"},
		{name="SM722",fname="sm722"},
	},
	["~g~Gr~w~ot~r~ti"]={--category name in UI (you can add unlimited categories and sounds)
		{name="X80 proto",fname="prototipo"},--first argument is the name of the car   second argument is the spawn name (addon vehicle support aswell)
		{name="Cheetah",fname="cheetah"},
		{name="Cheetah Classic",fname="cheetah2"},
	},
	["Obey"]={--category name in UI (you can add unlimited categories and sounds)
		{name="8F Drafter",fname="drafter"},--first argument is the name of the car   second argument is the spawn name (addon vehicle support aswell)
	},
	["~b~Ocelot"]={--category name in UI (you can add unlimited categories and sounds)
		{name="Jackal",fname="jackal"},--first argument is the name of the car   second argument is the spawn name (addon vehicle support aswell)
		{name="Jugular",fname="jugular"},
	},
}

local WhitelistVehicles={
	--"drafter",
	--"Jugular",
}

Config.WhitelistVehicles=WhitelistVehicles;


Config.Whitelist={
	["license:"]=WhitelistVehicles,--give a user every car in the list
	["license:"]={"drafter"},--give a user a specify vehicle
}