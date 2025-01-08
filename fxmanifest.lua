fx_version 'cerulean'
games      { 'gta5' }
lua54      'yes'

author      'Horizon'
description 'UI From Horizon'

--
-- Client
--

client_scripts {
    'client/*.lua',
}

--
-- NUI
--

ui_page 'nui/dist/nui.html'

files {
    'nui/dist/nui.html',
    'nui/dist/app.js',
    'nui/dist/app.css',
}

loadscreen 'nui/dist/nui.html'
loadscreen_manual_shutdown "yes"

exports {
    'openUI',
    'sendDataToPage',
    'sendNotification',
    'ShutdownLoadingScreen'
}
