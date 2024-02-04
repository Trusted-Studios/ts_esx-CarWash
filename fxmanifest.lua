-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Trusted Development || FX-Manifest
-- ════════════════════════════════════════════════════════════════════════════════════ --
fx_version 'cerulean'
lua54 'yes'
games { 'gta5' }

author 'Trusted-Development | Vehicle carwash sponge Script'
description 'Vehicle carwash sponge Script made by Trusted-Service'
repository 'https://trusted.tebex.io'
version '1.0.0'

shared_scripts {
    'config.lua',
    'lib/modules/shared/*.lua',
}

client_scripts {
   'lib/modules/client/*.lua',
   'client/main.lua',
}

server_scripts {
    'lib/modules/server/*.lua',
    'server/main.lua',
}