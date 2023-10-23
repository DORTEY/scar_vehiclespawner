--//  scar-studios.tebex.io

local license={};

RegisterNetEvent("ScarVehSpawner->Send->PlayerID")
AddEventHandler("ScarVehSpawner->Send->PlayerID",function()
	for _,v in ipairs(GetPlayerIdentifiers(source))do
		if(string.sub(v,1,string.len("license:"))=="license:")then
			license[source]=v;
		end
	end
	
    TriggerClientEvent("ScarVehSpawner->Get->PlayerID",source,license[source]);
end)