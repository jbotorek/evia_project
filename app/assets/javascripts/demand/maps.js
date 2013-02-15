Loader.load();
var m;
var center;
var layer;
var trasaLayer;
var inited = 0;
var criterion = "";
var canRemovePoints = true;
var points=[];
var clickOn=false;
$(document).ready(function(){
    $("#gpx").hide();
});

function initMap(){
    if(inited==0){
        center = SMap.Coords.fromWGS84(15.335764, 49.742466);
        m = new SMap(JAK.gel("m"), center, 0);
        m.addDefaultLayer(SMap.DEF_TURIST).enable();
        m.addDefaultControls(); 
        layer = new SMap.Layer.Marker();
        m.addLayer(layer);
        layer.enable();
        trasaLayer = new SMap.Layer.Geometry();
        m.addLayer(trasaLayer).enable();
        var mouse = new SMap.Control.Mouse(SMap.MOUSE_PAN | SMap.MOUSE_WHEEL | SMap.MOUSE_ZOOM);
        m.addControl(mouse);
        inited = 1;
    }
}
function loadMapWithRoute(){
    load();
    renderMap();
}
function load() { /* Funkce volaná po stisku tlačítka */
    var value = JAK.gel("gpx").value.trim();
    var doc = $.parseXML(value);
    var gpx = $(doc).find("gpx");
    var pointsFromXml = $(gpx).find("trkpt");
    var point=[];
    for(i=0;i<pointsFromXml.length;i++){
        point[0] = SMap.Coords.fromWGS84($(pointsFromXml[i]).attr("lon"),$(pointsFromXml[i]).attr("lat"));
        point[4] = $(pointsFromXml[i]).find("name").text();
        points.push(point);
        point = [];
    }
    renderMap();
}

function routeToGpx(){
    var gpx = '';
    gpx = gpx + '<gpx creator="eVia" version="1.1" xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">'
    gpx = gpx + '<trk><name>'+$('#route_title').val()+'</name>';
    gpx = gpx + '<trkseg>';
    for (i=0;i<points.length;i++){
        p = points[i];
        wgspoint = p[0].toWGS84(0);
        gpx = gpx + '<trkpt lat="'+wgspoint[1]+'" lon="'+wgspoint[0]+'"><name>'+p[4]+'</name></trkpt>'
    }
    gpx = gpx + '</trkseg>';
    gpx = gpx + '</trk></gpx>';
    $('#route_map').val(gpx);
}
function addPoints(){
        $('#points').html('');
        layer.removeAll();
        for(var i=0;i<points.length;i++){
            var marker = new SMap.Marker(points[i][0],"marker"+i,{});
            layer.addMarker(marker);
            if(points.length == 1){
                m.setCenter(points[0][0]);
            }
            var card = new SMap.Card();
            card.getHeader().innerHTML = "<strong>"+points[i][4]+"</strong>";
            if(canRemovePoints){
                card.getBody().innerHTML = "<a href=\"javascript:removePoint('"+i+"')\">odebrat</a>!";
            }
            marker.decorate(SMap.Marker.Feature.Card,card);
            points[i][1]=marker;
            points[i][2]=card;
        }
        layer.redraw();
}
function removePoint(offset){
    m.removeCard();
    points.splice(offset,1);
    renderMap();
}
function getPointsCoords(){
    var coords=[];
    for(var i=0;i<points.length;i++){
        coords.push(points[i][0]);
    }
    return coords;
}

function renderMap(){
    $(document).ready(function(){
        trasaLayer.removeAll();
        addPoints();
        if(points.length>1){
            var route = new SMap.Route(getPointsCoords(), addToMap, {criterion:criterion});
        }
        /*var options = {};
        var marker = new SMap.Marker(center, "myMarker", options);
        layer.addMarker(marker);
        var point = SMap.Coords.fromWGS84(16.9654061,49.0);
        var anotherMarker  = new SMap.Marker(point, "another", options);
        layer.addMarker(anotherMarker);
        route = new SMap.Route([center,point], addToMap, {criterion:"fast"});*/
    });
}
var addToMap = function(route){
    var coords = route.getResults().geometry;
    var cz = m.computeCenterZoom(coords);
    m.setCenterZoom(cz[0], cz[1]);
    var g = new SMap.Geometry(SMap.GEOMETRY_POLYLINE, null, coords);
    trasaLayer.addGeometry(g);
}

function turnClickOn(){
    mapClick = m.getSignals().addListener(window, "map-click", click);
}

function turnClickOff(){
    m.getSignals().removeListener(mapClick);
}
