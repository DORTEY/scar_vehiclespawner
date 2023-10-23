--//  scar-studios.tebex.io

local licenseID="";

RegisterNetEvent("ScarVehSpawner->Get->PlayerID")
AddEventHandler("ScarVehSpawner->Get->PlayerID",function(license)
	if(license~="" or license~=nil)then
		licenseID=license;
	else
		licenseID="";
	end
end)


function checkVehiclePerms(veh)
	local veh=GetEntityModel(veh);
	
	for i=1,#Config.WhitelistVehicles do
		local model=GetHashKey(Config.WhitelistVehicles[i]);
		
		if(veh==model)then
			if(licenseID~=nil and licenseID~="" and Config.Whitelist[""..licenseID..""]~=nil)then
				for ii=1,#Config.Whitelist[licenseID]do
					if(GetHashKey(Config.Whitelist[licenseID][ii])==veh)then
						return false;
					end
				end
				return true;
			else
				return true;
			end
		end
	end
	return false;
end


CreateThread(function()
	while true do
		local sleep=300;
		local Ped=GetPlayerPed(-1);
		local veh=nil;
		
		if(IsPedInAnyVehicle(Ped,false))then
			veh=GetVehiclePedIsUsing(Ped);
			VehHash=GetEntityModel(veh);
			VehName=GetDisplayNameFromVehicleModel(VehHash);
			VehNameText=GetLabelText(VehName);
		else
			veh=GetVehiclePedIsTryingToEnter(Ped);
			VehHash=GetEntityModel(veh);
			VehName=GetDisplayNameFromVehicleModel(VehHash);
			VehNameText=GetLabelText(VehName);
		end
		
		if(DoesEntityExist(veh))then
			if(checkVehiclePerms(veh))then
				if(GetPedInVehicleSeat(veh,-1)==Ped)then
					Notify(Config.Settings.WhitelistedMessage);
					SetEntityAsMissionEntity(veh,true,true);
					DeleteVehicle(veh);
					ClearPedTasksImmediately(Ped);
				end
			end
		end
		Wait(sleep);
	end
end)







local ScarVehSpawnerPositionRight={x=1320,y=10};
local ScarVehSpawnerPositionLeft={x=0,y=10};
local ScarVehSpawnerPositionMenu={x=0,y=200};


if(Config.Settings.Menu.Position)then
	if(Config.Settings.Menu.Position=="left")then
		ScarVehSpawnerPositionMenu=ScarVehSpawnerPositionLeft;
	elseif(Config.Settings.Menu.Position=="right")then
		ScarVehSpawnerPositionMenu=ScarVehSpawnerPositionRight;
	end
end



local ScarVehSpawnerMain=RageUI.CreateMenu(Config.Settings.Menu.Text.Title,Config.Settings.Menu.Text.SubTitle,ScarVehSpawnerPositionMenu["x"],ScarVehSpawnerPositionMenu["y"]);
local ScarVehSpawnerSub=RageUI.CreateSubMenu(ScarVehSpawnerMain,nil,nil);

local ScarEngineswapUIActive=false;

local ScarEngineswapCooldownStatus=false;
local ScarEngineswapList=nil;

ScarVehSpawnerMain.Closed=function()
	ScarEngineswapUIActive=false;
end

CreateThread(function()
	while true do
		local sleep=5;
		
		if(ScarEngineswapUIActive)then
			sleep=5;
			RageUI.IsVisible(ScarVehSpawnerMain,true,false,true,function()
				for _,k in ipairs(SortedKeys(Config.Vehicles))do
					RageUI.ButtonWithStyle(k,nil,{RightLabel="~y~→"},true,function(_,_,Selected)
						if(Selected)then
							ScarEngineswapList=Config.Vehicles[k];
						end
					end,ScarVehSpawnerSub)
				end
			end)
			
			RageUI.IsVisible(ScarVehSpawnerSub,true,false,true,function()
				if(Config.Settings.Menu.ShowVehName)then
					RightLabelText="~y~%s";
				else
					RightLabelText="";
				end
				for _,v in pairs(ScarEngineswapList)do
					RageUI.ButtonWithStyle(v.name,nil,{RightLabel=RightLabelText:format(v.fname)},not ScarEngineswapCooldownStatus,function(_,_,Selected)
						if(Selected)then
							ScarEngineswapCooldownStatus=true;
							
							SetTimeout(Config.Settings.Menu.Cooldown,function()
								ScarEngineswapCooldownStatus=false;
							end)
							CarsSpawner(v.fname);
						end
					end)
				end
			end)
		else
			sleep=500;
		end
		Wait(sleep);
	end
end)

CreateThread(function()
	while true do
		local sleep=0;
		
        if(ScarEngineswapUIActive)then
			DisableControlAction(2,85,true) -- RADIO_WHEEL DPAD LEFT
			DisableControlAction(2,74,true) -- HEADLIGHT DPAD RIGHT
			DisableControlAction(2,20,true) -- MULTIPLAYER_INFO DPAD DOWN
			DisableControlAction(2,303,true) -- LOCKCAR DPAD UP
            DisableControlAction(2,80,true) -- INPUT_VEH_CIN_CAM B or O (controller)
            DisableControlAction(2,140,true) -- MELEE_ATTACK_LIGHT B or O (controller)
		else
			sleep=800;
		end
		Wait(sleep);
	end
end)


RegisterCommand(Config.Settings.Menu.Command,function(source,args)
	if(not(ScarEngineswapUIActive))then
		ScarEngineswapUIActive=true;
		
		RageUI.Visible(ScarVehSpawnerMain,ScarEngineswapUIActive);
	end
end,false)
RegisterKeyMapping("cars","Toggle Vehicle Spawner","keyboard",Config.Settings.Menu.Key);