$(function(){
	$("#custom-form").hide()
	$('.custom-tag').change(function() {
        if(!$(this).hasClass("active")) {
            $('.tag-button-bar').removeClass("active")
            // show custom form
            $("#custom-form").show()
        }else{
        	$("#custom-form").hide()
        }
    });
    $('.tag-button-bar').change(function() {
        if(!$(this).hasClass("active")) {
            $('.custom-tag').removeClass("active")
            // hide custom form
            $("#custom-form").hide()
        }   
    });
});