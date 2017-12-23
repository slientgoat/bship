// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/web/endpoint.ex":
import {Socket,Presence} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}});

socket.connect();



let presences = {}
let lobby = socket.channel("lobby:" + window.lobbyId, {});
let chatInput = document.querySelector("#chat-input");
let messagesContainer = document.querySelector("#messages");
let online_players = document.querySelector("#online_players");

chatInput.addEventListener("keypress", event => {
    if(event.keyCode === 13){
        push_msg();
    }});

$('#push_msg').click(function () {
    push_msg();
});

function push_msg() {
    lobby.push("new_msg", {body: chatInput.value});
    chatInput.value = "";
}

function renderOnlineUsers(presences) {
    online_players.innerHTML="";
    console.log(presences,12)
    Presence.list(presences, (id, {metas: [first, ...rest]}) => {
        console.log(first)
        var li = '<li>' + first.nick + '</li>';
        online_players.append(li)
        // let count = rest.length + 1
        // response += `<br>nick: +"first.nick"+ ${id} (count: ${count})</br>`
    });

    // online_players.innerHTML = response;
}

lobby.on("presence_state", state => {
    presences = Presence.syncState(presences, state);
    renderOnlineUsers(presences);
});

lobby.on("presence_diff", diff => {
    presences = Presence.syncDiff(presences, diff);
    renderOnlineUsers(presences);
})



lobby.on("new_msg", payload => {
    let messageItem = document.createElement("li");
messageItem.innerText = `[${payload.nick}:] ${payload.body}`;
messagesContainer.appendChild(messageItem);
})

lobby.join().receive("ok", resp => {console.log("Joined successfully", resp)})
.receive("error", resp => {console.log("Unable to join", resp)})

export default socket