fx_version 'cerulean'
games      { 'gta5' }
lua54      'yes'

author      'Horizon'
description 'UI From Horizon'

--loadscreen 'nui/dist/nui.html'
--loadscreen_manual_shutdown "yes"

--
-- Client
--

client_scripts {
    'client/*.lua',
    'client/**/*.lua',
}

--
-- NUI
--

ui_page 'nui/dist/nui.html'

files {
    'nui/dist/nui.html',
    'nui/dist/app.js',
    'nui/dist/app.css',
    'nui/src/assets/**/*.png',
}