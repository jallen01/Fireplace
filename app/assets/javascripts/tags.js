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
	//$(".day-ranges-custom").hide()

    $("#new-tag-modal .day-ranges-custom").hide()
    $("#new-tag-modal .time-ranges-custom").hide()
    $(document).on("hidden.bs.modal", ".modal", function (event) {
        if(event.target.id === "new-tag-modal"){
            $("#new-tag-modal .day-ranges-custom").hide()
            $("#new-tag-modal .custom-day-range").removeClass("active")
            $("#new-tag-modal .time-ranges-custom").hide()
            $("#new-tag-modal .custom-time-range").removeClass("active")
            $("#new-tag-modal .day-button-bar").removeClass("active")
            $("#new-tag-modal .time-button-bar").removeClass("active")
            $("#new-tag-modal .btn-day").removeClass("active")
            $("#new-tag-modal .btn-time").removeClass("active")
        }
    });

	$('.custom-day-range').change(function() {
        modal_id = $(this).parents(".modal").attr("id")
        if(!$(this).hasClass("active")) {
            $("#"+modal_id + " .day-button-bar").removeClass("active")
            // show custom form
            $("#"+modal_id + " .day-ranges-custom").show()
        }else{
        	$("#"+modal_id + " .day-ranges-custom").hide()
        }
    });
    $('.day-button-bar').change(function() {
        modal_id = $(this).parents(".modal").attr("id")
        if(!$(this).hasClass("active")) {
            $("#"+modal_id + " .custom-day-range").removeClass("active")
            // hide custom form
            $("#"+modal_id + " .day-ranges-custom").hide()
        }   
    });

    // Custom time ranges
    //$(".time-ranges-custom").hide()
	$('.custom-time-range').change(function() {
        modal_id = $(this).parents(".modal").attr("id")
        if(!$(this).hasClass("active")) {
            $("#"+modal_id + " .time-button-bar").removeClass("active")
            // show custom form
            $("#"+modal_id + " .time-ranges-custom").show()
        }else{
        	$("#"+modal_id + " .time-ranges-custom").hide()
        }
    });
    $('.time-button-bar').change(function() {
        modal_id = $(this).parents(".modal").attr("id")
        if(!$(this).hasClass("active")) {
            $("#"+modal_id + " .custom-time-range").removeClass("active")
            // hide custom form
            $("#"+modal_id + " .time-ranges-custom").hide()
        }   
    });
});