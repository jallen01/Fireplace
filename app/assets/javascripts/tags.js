// Day range select

// $(document).on('click', '#day-range-select-toggle', function () {
//     $("#day-range-select .btn").removeClass("disabled");
//     $("#day-range-select-toggle").addClass("active");
//     $("#day-ranges .btn").removeClass("active");
// });

// $(document).on('click', '#day-ranges .btn', function () {
//     $("#day-range-select .btn").addClass("disabled");
//     $("#day-range-select-toggle").removeClass("active");
// });

// // Time range select

// $(document).on('click', '#time-range-select-toggle', function () {
//     $("#time-range-select-toggle").addClass("active");
//     $("#time-ranges .btn").removeClass("active");
// });

// $(document).on('click', '#time-ranges .btn', function () {
//     $("#time-range-select-toggle").removeClass("active");
// });

$(function(){
	// Custom day ranges
	$(".day-ranges-custom").hide()
	$('.custom-day-range').change(function() {
        if(!$(this).hasClass("active")) {
            $('.day-button-bar').removeClass("active")
            // show custom form
            $(".day-ranges-custom").show()
        }else{
        	$(".day-ranges-custom").hide()
        }
    });
    $('.day-button-bar').change(function() {
        if(!$(this).hasClass("active")) {
            $('.custom-day-range').removeClass("active")
            // hide custom form
            $(".day-ranges-custom").hide()
        }   
    });

    // Custom time ranges
    $(".time-ranges-custom").hide()
	$('.custom-time-range').change(function() {
        if(!$(this).hasClass("active")) {
            $('.time-button-bar').removeClass("active")
            // show custom form
            $(".time-ranges-custom").show()
        }else{
        	$(".time-ranges-custom").hide()
        }
    });
    $('.time-button-bar').change(function() {
        if(!$(this).hasClass("active")) {
            $('.custom-time-range').removeClass("active")
            // hide custom form
            $(".time-ranges-custom").hide()
        }   
    });

    // Custom locations
    $(".locations-custom").hide()
    $('.custom-location').change(function() {
        if(!$(this).hasClass("active")) {
            $('.location-button-bar').removeClass("active")
            // show custom form
            $(".location-custom").show()
        }else{
            $(".location-custom").hide()
        }
    });
    $('.location-button-bar').change(function() {
        if(!$(this).hasClass("active")) {
            $('.custom-location').removeClass("active")
            // hide custom form
            $(".location-custom").hide()
        }   
    });

});