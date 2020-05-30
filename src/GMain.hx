import js.Browser.document;

class GMain {

  // constructor
  function new() {
    trace("DOM example");

    document.addEventListener("DOMContentLoaded", init);
  }

  function init(_) {
    // Shorthand for document.createElement("p");
    var p = document.createParagraphElement();
    p.innerText = 'DOM ready';

    document.querySelector("#servers").appendChild(p);
  }

  static function main() new GMain();
}
