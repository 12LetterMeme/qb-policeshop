fx_version 'adamant'
game 'gta5'
lua54 'yes'
author "Created by: NevoSwissa#0111.. Edited by: 12LetterMeme#0001"
description "A Simple Police Garage"
version "1.0.2"

client_scripts {
    'client/client.lua',
    'config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'config.lua',
}
