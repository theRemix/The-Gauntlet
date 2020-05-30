import js.Browser.document;
import js.html.DOMElement;
import js.html.InputElement;

using StringTools;

class GMain {

  var servers_container:DOMElement;
  var server_address:DOMElement;
  var players_container:DOMElement;
  var controls_container:DOMElement;
  var status_container:DOMElement;
  var status:DOMElement;
  var server_address_input:InputElement;
  var create_server_btn:DOMElement;

  var server_name:String;

  function new() {
    document.addEventListener("DOMContentLoaded", init);
  }

  function init(_) {
    servers_container = document.querySelector("#servers_container");
    server_address = document.querySelector("#server_address");
    players_container = document.querySelector("#players_container");
    controls_container = document.querySelector("#controls_container");
    status_container = document.querySelector("#status_container");
    status = document.querySelector("#status");
    server_address_input = cast(document.querySelector("#server_address_input"), InputElement);
    create_server_btn = document.querySelector("#create_server");

    players_container.hidden = true;
    controls_container.hidden = true;
    status_container.hidden = true;

    server_address_input.onchange = function(e){
      server_name = e.target.value;
    }

    create_server_btn.onclick = function(_){
      if(server_name == "") return;

      server_address.innerText = server_address_input.value;
      server_address_input.hidden = true;
      create_server_btn.hidden = true;
    }

  }

  static function main() new GMain();
}
