fx_version 'cerulean'
game 'gta5'

author 'HTXLUX'
description 'Divine Messenger - HTXLUX'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua', -- if you need it later; safe to leave
    '@qb-core/shared/locale.lua',
    'server.lua',
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
