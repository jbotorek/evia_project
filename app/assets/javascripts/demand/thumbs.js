function fitThumbs(thumbClass){
    $(thumbClass).find('img').each(function(){ 
        var thumbWidth = $(thumbClass).css('width').match(/([0-9]+)/)[0];
        var thumbHeight = $(thumbClass).css('height').match(/([0-9]+)/)[0];
        var originalWidth = this.width;
        var originalHeight = this.height;
        var imgClass = ((this.width-thumbWidth)/(this.height-thumbHeight) > 1) ? 'wide' : 'tall';
        if((this.width/thumbWidth)/(this.height/thumbHeight) > 1){
            $(this).width("auto").height(thumbHeight+"px");
            ratio = originalHeight/thumbHeight;
            $(this).css('margin-left',-(originalWidth/ratio-thumbWidth)/2);
        }else{
            $(this).width(thumbWidth+"px").height("auto");
            ratio = originalWidth/thumbWidth;
            $(this).css('margin-top',-(originalHeight/ratio-thumbHeight)/2);
        }
    });
}