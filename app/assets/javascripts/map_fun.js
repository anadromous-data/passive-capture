function newMap(token,zoom) {
  L.mapbox.accessToken = token;
  var map = L.mapbox.map('map', 'sillson.lhm0n06m').setView([46.24, -120.14], zoom);
  
}


function mapNadd(token, zoom, line) {

  var map = newMap(token, zoom);

  var col_polyline = L.polyline([]).addTo(map);
  var col_length = line.length
  var pointsAdded = 0;

    // `addLatLng` takes a new latLng coordinate and puts it at the end of the line. To draw multiple lines, will have to switch out Columbia North Line for something dynamic.
    col_polyline.addLatLng(
        L.latLng(line.shift())
        );
   
    if (++pointsAdded < col_length) window.setTimeout(add, 50);

    // Panning? Gives me a headache
    // map.setView([46.24, (line_points.shift())[1]], 6);
}
