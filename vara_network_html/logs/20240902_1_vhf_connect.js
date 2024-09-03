function htmlTitle(html) {
  const container = document.createElement("div");
  container.innerHTML = html;
  return container;
}

var nodes_connected = [
{ id: 1, label: "AH7RF", group: 1 },
{ id: 2, label: "KH6S", group: 1 },
{ id: 3, label: "WH6CMO", group: 1 },
{ id: 4, label: "WH6FG", group: 1 },
{ id: 5, label: "WH6FXV", group: 1 },
{ id: 6, label: "KH6HC", group: 2 },
{ id: 7, label: "WH6ECG", group: 2 },
{ id: 8, label: "WH7GG", group: 2 },
{ id: 9, label: "NH7YS", group: 2 },
{ id: 10, label: "AH6WF", group: 2 },
];
var edges_connected = [
{ from: 2, to: 9, font: {multi: 'html'}, title: htmlTitle("<b>NH7YS connected to gateway KH6S</b><br>Signal report from gateway KH6S        <p><br>Min S/N: 20.9 dB, Max S/N: 22.2 dB<br>Number of Connections: 2")  },
{ from: 3, to: 10, font: {multi: 'html'}, title: htmlTitle("<b>AH6WF connected to gateway WH6CMO</b><br>Signal report from gateway WH6CMO        <p><br>Min S/N: 23.8 dB, Max S/N: 24.3 dB<br>Number of Connections: 2")  },
{ from: 3, to: 6, font: {multi: 'html'}, title: htmlTitle("<b>KH6HC connected to gateway WH6CMO</b><br>Signal report from gateway WH6CMO        <p><br>Min S/N: 3.9 dB, Max S/N: 3.9 dB<br>Number of Connections: 1")  },
];
