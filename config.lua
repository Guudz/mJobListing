Config = {}

Config = {
	CheckJob2viaBDD = "job2", -- job2 || SecondaryJob (a ajuster selon l'utilisation de votre BDD)
	
	MessageChangementdeJob = "Nouveau Job !\nVous travailler maintenant pour l'entreprise: ~o~%s",

	AfficherMessagePoleEmploi = "Visual", -- Visual || ShowHelpNotification (selon vos préférence)
	MessagePoleEmploi = "~s~Appuyez sur ~c~[~y~E~c~]~s~ pour trouver un métier",


	Info = {
		Menu = {
			PosduMenuX = 0,
			PosduMenuY = 50,
			CouleurduMenu = {
				R = 0,
				G = 0,
				B = 0,
				A = 255,
			},
			Titre = "Pôle Emploi",
			SousTitre = "Liste des métier",
			MetierLibre = "~g~→→~s~ Metier(s) Libre ~g~←←",
			MetierWL = "~r~→→~s~ Metier(s) WhiteList ~r~←←",
		},

		Coord = vector3(-268.13, -957.65, 31.22),

		Blips = {
			Activate = true,
			Sprite = 590,
			Colour = 38,
			Scale = 0.65,
			Text = "Pôle Emploi",

		},

		Ped = {
			Activate = true,
			Rotation = 205.1,
			HashduPed = "s_m_m_fiboffice_02",
			JamaisChanger = true,
			Animation = true,
			AnimationType = "WORLD_HUMAN_CLIPBOARD", 

		},

		Marker = {
			Activate = false,
			Type = 27,
			TailleXYZ = vector3(3, 3, 1),
			CouleurRGBA = {
				R=255, 
				G=0, 
				B=0, 
				A=255,
			},
			Saute = false,
			SuivideCam = false,
			Rotate = false,
			AjustementHauteur = -0.97
		}
	}
}