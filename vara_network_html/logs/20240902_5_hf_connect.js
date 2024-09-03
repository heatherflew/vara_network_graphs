function htmlTitle(html) {                                                                                                                 
  const container = document.createElement("div");                                                                                                         
  container.innerHTML = html;                                                                                                                                
  return container;                                                                                                                                          
}                                                                                                                                                            

var nodes_connected = [
{ id: 1, label: "KH6ESK", group: 1 },
{ id: 2, label: "KH6TU", group: 1 },
{ id: 3, label: "WH6FG", group: 1 },
{ id: 4, label: "WH6GDC", group: 1 },
{ id: 5, label: "NH7YS", group: 2 },
{ id: 6, label: "AH7L", group: 2 },
{ id: 7, label: "WB6TT", group: 2 },
{ id: 8, label: "WH6BS", group: 2 },
{ id: 9, label: "WH6ECG", group: 2 },
{ id: 10, label: "AH6KW", group: 2 },
];
var edges_connected = [
{ from: 1, to: 5, font: {multi: 'html'}, title: htmlTitle("<b>NH7YS connected to gateway KH6ESK</b><br>Signal report from gateway KH6ESK<p><br>Min S/N: -14.5 dB, Max S/N: -14.5 dB<br>Number of Connections: 1")  },
{ from: 2, to: 5, font: {multi: 'html'}, title: htmlTitle("<b>NH7YS connected to gateway KH6TU</b><br>Signal report from gateway KH6TU<p><br>Min S/N: -8.1 dB, Max S/N: 0.8 dB<br>Number of Connections: 2")  },
{ from: 3, to: 6, font: {multi: 'html'}, title: htmlTitle("<b>AH7L connected to gateway WH6FG</b><br>Signal report from gateway WH6FG<p><br>Min S/N: -8.5 dB, Max S/N: -8.5 dB<br>Number of Connections: 1")  },
{ from: 3, to: 7, font: {multi: 'html'}, title: htmlTitle("<b>WB6TT connected to gateway WH6FG</b><br>Signal report from gateway WH6FG<p><br>Min S/N: -12.2 dB, Max S/N: -12.2 dB<br>Number of Connections: 1")  },
{ from: 3, to: 8, font: {multi: 'html'}, title: htmlTitle("<b>WH6BS connected to gateway WH6FG</b><br>Signal report from gateway WH6FG<p><br>Min S/N: -9.7 dB, Max S/N: -9.7 dB<br>Number of Connections: 1")  },
{ from: 3, to: 9, font: {multi: 'html'}, title: htmlTitle("<b>WH6ECG connected to gateway WH6FG</b><br>Signal report from gateway WH6FG<p><br>Min S/N: -19.0 dB, Max S/N: -19.0 dB<br>Number of Connections: 1")  },
{ from: 4, to: 10, font: {multi: 'html'}, title: htmlTitle("<b>AH6KW connected to gateway WH6GDC</b><br>Signal report from gateway WH6GDC<p><br>Min S/N: 5.8 dB, Max S/N: 6.1 dB<br>Number of Connections: 2")  },
{ from: 4, to: 5, font: {multi: 'html'}, title: htmlTitle("<b>NH7YS connected to gateway WH6GDC</b><br>Signal report from gateway WH6GDC<p><br>Min S/N: 7.4 dB, Max S/N: 7.4 dB<br>Number of Connections: 1")  },
{ from: 4, to: 9, font: {multi: 'html'}, title: htmlTitle("<b>WH6ECG connected to gateway WH6GDC</b><br>Signal report from gateway WH6GDC<p><br>Min S/N: 2.6 dB, Max S/N: 2.6 dB<br>Number of Connections: 1")  },
];
