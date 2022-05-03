fx_version 'adamant'
game 'gta5'
lua54 'yes'
author "Edited by: 12LetterMeme#0001"
description "A Simple Police Garage("NevoSwissa#0111")"
version "1.1"

client_scripts {
    'client/client.lua',
    'config.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'config.lua',
}
