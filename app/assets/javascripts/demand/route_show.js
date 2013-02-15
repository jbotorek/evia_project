$(document).ready(function(){
    fitThumbs(".gallery_thumb"); 
    $('.panels').hide();
    if(window.location.hash==""){
        window.location.hash="info";
    }
    var hash = window.location.hash;
    $(hash).fadeIn();
    checkWhetherRenderMap(hash);
    $('.switch a').click(function(){
        $('.panels').hide();
        $(this.hash).fadeIn();
        checkWhetherRenderMap(this.hash);
    });
});
function checkWhetherRenderMap(hash){
    if(hash=="#maps"){
        initMap();
        loadMapWithRoute();
    }
}