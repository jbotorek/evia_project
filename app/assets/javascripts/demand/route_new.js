
$(document).ready(function(){
    initMap();
    renderMap();
    criterion = $('#select_criterion').val();
    $('#route_criterion').val(criterion);
    $('#select_criterion').change(function(){
        criterion = $(this).val();
        $('#route_criterion').val(criterion);
        renderMap();
    });
    var clickOn=false;

    $('#control a').click(function(ev){
        ev.preventDefault();
        if(clickOn==false){
            turnClickOn();
            clickOn = true;
            $(this).html("Turn OFF place picker");
        }else{
            clickOn = false;
            turnClickOff();
            $(this).html("Turn ON place picker");
        }
    });
});


