$(document).ready(function(){
    fitThumbs(".photo_thumb");
    
    $('.photo_thumb a').click(function(ev){
        ev.preventDefault();
        var img = $(this).find('img');
        $('#photo_detail').html('');
        img.clone().appendTo('#photo_detail');
        $('#photo_detail').show();
        detailOn = true;
        var imgClass = (img.width/img.height > 1) ? 'wide' : 'tall';
        /** removing styles assigned to pictures by fitPhotoThumbs namely width, height, margin-top, margin-left **/
        $('#photo_detail > img').css("width","").css("height","").css("margin-top","").css("margin-left","").addClass(imgClass);
        
    });
    $('#photo_detail').click(function(){
        $('#photo_detail').hide();
    });
});