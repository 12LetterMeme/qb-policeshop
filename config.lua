Config = Config or {}
Config.UsePreviewMenuSync = true -- Sync for the prewview menu when player is inside the prewview menu other players cant get inside (can prevent bugs but not have to use)
Config.UseMarkerInsteadOfMenu = false -- Want to use the marker to return the vehice? if false you can do that by opening the menu
Config.MS = 'high' -- MS for the script recommended using high if not the "close" will get a bit baggy. options high / low
Config.Job = 'police' --The job needed to open the menu

--DO NOT add vehicles that are not in your shared ! otherwise the qb-garages wont work
Config.Vehicles = {
    [0] = { --grade 0
        { ['vehiclename'] = "car 1 grade 0",         ['vehicle'] = "car1",          ['price'] = 37000},
        { ['vehiclename'] = "car 2 grade 0",         ['vehicle'] = "car2",          ['price'] = 37000},
    },
    [1] = { --grade 1
        { ['vehiclename'] = "car 1 grade 1",         ['vehicle'] = "car1",          ['price'] = 37000},
        { ['vehiclename'] = "car 2 grade 1",         ['vehicle'] = "car2",          ['price'] = 37000},
    },
}

Config.AirVehicles = {
    [0]  = {--grade 0
        { ['vehiclename'] = "car 1 grade 0",         ['vehicle'] = "heli1",         ['price'] = 37000},
        { ['vehiclename'] = "car 1 grade 0",         ['vehicle'] = "heli2",         ['price'] = 37000},
    },
    [1]  = {--grade 1
        { ['vehiclename'] = "car 1 grade 1",         ['vehicle'] = "heli1",         ['price'] = 37000},
        { ['vehiclename'] = "car 1 grade 1",         ['vehicle'] = "heli2",         ['price'] = 37000},
    },
}
