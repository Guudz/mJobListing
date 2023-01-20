local ESX = nil
local allJobsPE = {}

CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	while ESX == nil do Wait(10) end
end)

local function getAllJobs()
	ESX.TriggerServerCallback('mJobListing:getJobList', function(mJobListingData)
		allJobsPE = mJobListingData
	end)
end


function menuPoleEmploi()
	
	local mainMenu = RageUI.CreateMenu(Config.Info.Menu.Titre, Config.Info.Menu.SousTitre, Config.Info.Menu.PosduMenuX, Config.Info.Menu.PosduMenuY)
	mainMenu:SetRectangleBanner(Config.Info.Menu.CouleurduMenu.R, Config.Info.Menu.CouleurduMenu.G, Config.Info.Menu.CouleurduMenu.B, Config.Info.Menu.CouleurduMenu.A)
	
	mainMenu.Closed = function()
		open = false
	end

	if open then
        open = false
        RageUI.Visible(mainMenu, false)
        return
    else
        open = true
        RageUI.Visible(mainMenu, true)
		CreateThread(function()
            while open do
                RageUI.IsVisible(mainMenu, function()

					RageUI.Separator(Config.Info.Menu.MetierLibre)

					for k,v in pairs(allJobsPE) do
						if not v.whitelisted then
							RageUI.Button("~o~→ ~s~"..v.label, nil, { RightLabel = "→→"  }, true, {
								onSelected = function()
									TriggerServerEvent('mJobListing:setJob', v.job)
									ESX.ShowNotification(Config.MessageChangementdeJob:format(v.label))
								end
							})
					    end
					end
					RageUI.Separator()

					RageUI.Separator(Config.Info.Menu.MetierWL)

					for k,v in pairs(allJobsPE) do
						if v.whitelisted then 
							RageUI.Button("~o~→ ~s~"..v.label, nil, { RightLabel = "→→"  }, false, {
								onSelected = function()
								end
							})
					    end
					end

				end)
				Wait(0)
			end
		end)
        if not RageUI.Visible(mainMenu)  then
            mainMenu = RMenu:DeleteType("mainMenu", true)
        end
	end
end


CreateThread(function()
	while true do
		local plyCoords = GetEntityCoords(PlayerPedId(), false)
		local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, Config.Info.Coord)
		if Config.Info.Marker.Activate == true then
			if dist <= 6 then
				DrawMarker(Config.Info.Marker.Type, Config.Info.Coord[1], Config.Info.Coord[2], Config.Info.Coord[3]+Config.Info.Marker.AjustementHauteur, 0, 0, 0, 0, 0, 0, Config.Info.Marker.TailleXYZ, Config.Info.Marker.CouleurRGBA.R, Config.Info.Marker.CouleurRGBA.G, Config.Info.Marker.CouleurRGBA.B, Config.Info.Marker.CouleurRGBA.A, Config.Info.Marker.Saute, Config.Info.Marker.SuivideCam, 0, Config.Info.Marker.Rotate)
			end
		end
		if dist <= 1.8 then
			if Config.AfficherMessagePoleEmploi == "Visual" then
				Visual.Text({message=Config.MessagePoleEmploi, time=1})
			end
			if Config.AfficherMessagePoleEmploi == "ShowHelpNotification" then
				ESX.ShowHelpNotification(Config.MessagePoleEmploi)
			end
            if IsControlJustReleased(0, 38) then
				getAllJobs()
				menuPoleEmploi()
			end
		end
		Wait(0)
	end
end)


--- Blips
if Config.Info.Blips.Activate == true then
	CreateThread(function()
		local poleemploimap = AddBlipForCoord(Config.Info.Coord)
		SetBlipSprite(poleemploimap, Config.Info.Blips.Sprite)
		SetBlipColour(poleemploimap, Config.Info.Blips.Colour)
		SetBlipAsShortRange(poleemploimap, true)
		SetBlipScale(poleemploimap, Config.Info.Blips.Scale)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(Config.Info.Blips.Text)
		EndTextCommandSetBlipName(poleemploimap)
	end)
end

if Config.Info.Ped.Activate == true then
	CreateThread(function()
		local hash = GetHashKey(Config.Info.Ped.HashduPed)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Wait(20)
		end
		ped = CreatePed("PED_TYPE_CIVFEMALE", Config.Info.Ped.HashduPed, Config.Info.Coord[1], Config.Info.Coord[2], Config.Info.Coord[3]-1, Config.Info.Ped.Rotation, false, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		if Config.Info.Ped.JamaisChanger == true then
			SetPedDefaultComponentVariation(ped)
		end
		if Config.Info.Ped.Animation == true then
			TaskStartScenarioInPlace(ped, Config.Info.Ped.AnimationType, 0, true)
		end
	end)
end