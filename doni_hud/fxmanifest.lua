fx_version 'cerulean'
game 'gta5'

author 'Doni Modding'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js',
    'html/*.mp3',
    'html/*.ogg',
    'html/*.png',
    'html/*.wav',
    'html/*.jpg'

}

client_script {
    'client.lua'
}

server_script {
    'server.lua'
}
