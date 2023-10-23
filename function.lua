--//  scar-studios.tebex.io

function SortedKeys(query,sortFunction)
    local keys,len={},0;
    for k,_ in pairs(query)do
        len=len+1;
        keys[len]=k;
    end
    table.sort(keys,sortFunction);
    return keys
end

function Notify(text)
    BeginTextCommandThefeedPost("STRING");
    AddTextComponentSubstringPlayerName(text);
    EndTextCommandThefeedPostTicker(false,false);
end


function CarsSpawner(vehicleName)
	local model=(type(vehicleName)=="number" and vehicleName or GetHashKey(vehicleName));

	if(IsModelInCdimage(model))then
		local playerPed=PlayerPedId();
		local playerCoords,playerHeading=GetEntityCoords(playerPed),GetEntityHeading(playerPed);

		if(IsPedInAnyVehicle(playerPed,true))then
			local playerVeh=GetVehiclePedIsIn(playerPed,false);
			if(DoesEntityExist(playerVeh))then
				SetEntityAsMissionEntity(playerVeh,false,true);
				DeleteVehicle(playerVeh);
			end
        end
        
        LoadModel(model);
		local vehicle=CreateVehicle(model,playerCoords.x,playerCoords.y,playerCoords.z,playerHeading,true,false);
        SetVehRadioStation(vehicle,"OFF");
        TaskWarpPedIntoVehicle(playerPed,vehicle,-1);
		
		AddEventHandler("playerDropped",function()
			if(vehicle)then
				deleteCar(vehicle);
				vehicle=nil;
			end
			if(model)then
				model=nil;
			end
		end)
		Notify("Vehicle successfully spawned!");
    else
		Notify("Invalid model! Please contact the Staff Team.");
	end
end


function LoadModel(modelHash)
	local sleep=100;
	local modelHash=(type(modelHash)=="number" and modelHash or GetHashKey(modelHash));
	
	if(not HasModelLoaded(modelHash))then
		RequestModel(modelHash);
		sleep=100;
		
		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName("Your vehicle is downloading... please wait");
		Notify("Your vehicle is downloading... please wait");
        EndTextCommandBusyspinnerOn(4);
		
		AddEventHandler("playerDropped",function()
			if(modelHash)then
				modelHash=nil;
			end
		end)
        
        local i=0;
        while not HasModelLoaded(modelHash)and i<600 do
			sleep=1000;
            i=i+1;
		end
        BusyspinnerOff();
		if(HasModelLoaded(modelHash))then
			SetModelAsNoLongerNeeded(modelHash);
		end
	end
	Wait(sleep)
end


CreateThread(function()
	while true do
		local sleep=300;
		
		TriggerServerEvent("ScarVehSpawner->Send->PlayerID");
		
		Wait(sleep);
	end
end)