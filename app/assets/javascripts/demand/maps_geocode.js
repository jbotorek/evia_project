/* this library excpect maps.js loaded before. */
$(document).ready(function(){
    var form = JAK.gel("getCoords");
    JAK.Events.addListener(form, "submit", geokoduj); /* Při odeslání formuláře pustit geokódování */
});

function geokoduj(e, elm) {  /* Voláno při odeslání */
    JAK.Events.cancelDef(e); /* Zamezit odeslání formuláře */
    var query = JAK.gel("query").value;
    new SMap.Geocoder(query, odpoved, {});
}

function odpoved(geocoder) { /* Odpověď */
    if (!geocoder.getResults().length) {
        alert("Tohle neznáme.");
        return;
    }
    
    var vysledky = geocoder.getResults()[0].results;
    var data;
    while(vysledky.length){
        var item = vysledky.shift();
        $('#points').append("<a href='javascript:selectOneAndAddToMap("+item.coords.x+","+item.coords.y+",\""+item.label+"\");'>"+item.label+"</a><br />");
    }
}


function selectOneAndAddToMap(coordX,coordY,label){
    var point = [];
    point[0] = SMap.Coords.fromPP(coordX,coordY);
    point[4] = label;
    points.push(point);
    $('#points').html('');
    renderMap();
}

function click(e, elm) { 
    var coords = SMap.Coords.fromEvent(e.data.event, m);
    var point = [];
    point[0]=coords;
    points.push(point);
    var last = (points.length>0)?(points.length-1):0;
    new SMap.Geocoder.Reverse(coords, getLabel, {count:1,offset:last});
    $('#control a').click();
}
function getLabel(geocoder) {
    if (geocoder.getResults()==undefined) {
        alert("Tohle neznáme.");
        return;
    }
    points[geocoder._options.offset][4]=geocoder.getResults().label;
    
    renderMap();
    
}