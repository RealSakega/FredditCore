const mcapi = 'https://eu.mc-api.net/v3/server'

const servers = [
    {
        'name': 'Freddit Freebuild',
        'address': 'play.freddit.net',
        'map_url': 'http://map.freddit.net'
    },
    {
        'name': 'Freddit Survival',
        'address': 'survival.freddit.net',
        'map_url': 'https://survivalmap.freddit.net'
    }
]

const copyToClipboard = (text) => {
    navigator.clipboard.writeText(text)
    var toastEl = document.getElementById('copied-toast');
    var toast = new bootstrap.Toast(toastEl);
    toast.show();
}

const serverStatusCardHTML = (server_name, server_address, status, map_url, players, version) => {
    return `
        <div class="col-md-4 p-2">
            <div class="card">
                <div class="card-header">
                    <img src="${mcapi}/favicon/${server_address}" alt="Server icon" style="width: 16px; height: 16px;">
                    ${server_name}
                    <div class="badge bg-${status === 'online' ? 'success' : 'danger'}">${status}</div>
                    ${version ? `<span class="badge bg-secondary">${version}</span>` : ''}
                </div>
                <div class="card-body">
                    <p>${players} player${players !== 1 ? 's' : ''} online</p>
                    <button class="btn btn-sm btn-outline-primary" onclick="window.open('${map_url}')">Map</button>
                </div>
                <div class="card-footer" onclick="copyToClipboard('${server_address}')" style="cursor: pointer;">
                    <code>${server_address}</code>
                </div>
            </div>
        </div>
    `
}

servers.forEach(server => {
    $.get(mcapi + "/ping/" + server.address, function(data) {
        if (data.error) {
            $('#server-status').append(serverStatusCardHTML(server.name, server.address, 'offline', server.map_url, 0))
            return
        }
        $('#server-status').append(serverStatusCardHTML(server.name, server.address, 'online', server.map_url, data.players.online, data.version.name))
    }).fail(function() {
        $('#server-status').append(serverStatusCardHTML(server.name, server.address, 'offline', server.map_url, 0))
    })
})