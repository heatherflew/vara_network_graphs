function htmlTitle(html) {
  const container = document.createElement("div");
  container.innerHTML = html;
  return container;
}

var nodes_heard = [
{ id: 1, label: "AH7RF", group: 1 },
{ id: 2, label: "KH6S", group: 1 },
{ id: 3, label: "WH6CMO", group: 1 },
{ id: 4, label: "WH6FG", group: 1 },
{ id: 5, label: "WH6FXV", group: 1 },
{ id: 6, label: "WH6BS", group: 2 },
{ id: 7, label: "WH6ECG", group: 2 },
{ id: 8, label: "NH7YS", group: 2 },
{ id: 9, label: "NH7IT", group: 2 },
{ id: 10, label: "KH6HC", group: 2 },
{ id: 11, label: "WH7GG", group: 2 },
{ id: 12, label: "AH6WF", group: 2 },
];
var edges_heard = [
{ from: 1, to: 9, font: {multi: 'html'}, title: htmlTitle("<b>NH7IT heard by gateway AH7RF</b><br>Signal report from gateway AH7RF   <p>Monitor Report<br>Min S/N: -0.2 dB, Max S/N: 6.9 dB<br>Number Heard: 31 <br>")  },
{ from: 2, to: 8, font: {multi: 'html'}, title: htmlTitle("<b>NH7YS heard by gateway KH6S</b><br>Signal report from gateway KH6S   <p>Monitor Report<br>Min S/N: 19.9 dB, Max S/N: 25.2 dB<br>Number Heard: 21 <br>")  },
{ from: 2, to: 6, font: {multi: 'html'}, title: htmlTitle("<b>WH6BS heard by gateway KH6S</b><br>Signal report from gateway KH6S   <p>Monitor Report<br>Min S/N: -0.1 dB, Max S/N: 4.4 dB<br>Number Heard: 9 <br>")  },
{ from: 3, to: 10, font: {multi: 'html'}, title: htmlTitle("<b>KH6HC heard by gateway WH6CMO</b><br>Signal report from gateway WH6CMO   <p>Monitor Report<br>Min S/N: 2.4 dB, Max S/N: 5.7 dB<br>Number Heard: 4 <br>")  },
{ from: 3, to: 7, font: {multi: 'html'}, title: htmlTitle("<b>WH6ECG heard by gateway WH6CMO</b><br>Signal report from gateway WH6CMO   <p>Monitor Report<br>Min S/N: 8.5 dB, Max S/N: 8.5 dB<br>Number Heard: 1 <br>")  },
{ from: 3, to: 11, font: {multi: 'html'}, title: htmlTitle("<b>WH7GG heard by gateway WH6CMO</b><br>Signal report from gateway WH6CMO   <p>Monitor Report<br>Min S/N: 3.3 dB, Max S/N: 4.0 dB<br>Number Heard: 2 <br>")  },
{ from: 5, to: 9, font: {multi: 'html'}, title: htmlTitle("<b>NH7IT heard by gateway WH6FXV</b><br>Signal report from gateway WH6FXV   ")  },
];
