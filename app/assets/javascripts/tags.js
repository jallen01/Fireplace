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

	$(document).on("change", '.custom-day-range :checkbox', function (event) {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(event.target);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .day-button-bar").removeClass("active")
            $("#"+modal_id + " .day-button-bar :checked").attr("checked", false)
            // show custom form
            $("#"+modal_id + " .day-ranges-custom").show()
        }else{
            $("#"+modal_id + " .spec-day").removeClass("active")
            $("#"+modal_id + " .spec-day :checked").attr("checked", false)
        	$("#"+modal_id + " .day-ranges-custom").hide()
        }
    });
    $(document).on("change", '.day-button-bar', function (event) {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(event.target);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .spec-day").removeClass("active")
            $("#"+modal_id + " .custom-day-range").removeClass("active")
            $("#"+modal_id + " .spec-day :checked").attr("checked", false)
            // hide custom form
            $("#"+modal_id + " .day-ranges-custom").hide()
        }   
    });

    // Custom time ranges
    //$(".time-ranges-custom").hide()
	$(document).on("change", '.custom-time-range :checkbox', function (event) {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(event.target);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .time-button-bar").removeClass("active")
            $("#"+modal_id + " .time-button-bar :checked").attr("checked", false)
            // show custom form
            $("#"+modal_id + " .time-ranges-custom").show()
        }else{
            $("#"+modal_id + " .spec-time").removeClass("active")
            $("#"+modal_id + " .spec-time :checked").attr("checked", false)
        	$("#"+modal_id + " .time-ranges-custom").hide()
        }
    });
    $(document).on("change", '.time-button-bar', function (event) {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(event.target);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .spec-time").removeClass("active")
            $("#"+modal_id + " .custom-time-range").removeClass("active")
            $("#"+modal_id + " .spec-time :checked").attr("checked", false)
            // hide custom form
            $("#"+modal_id + " .time-ranges-custom").hide()
        }   
    });

    // Custom locations
    $(".locations-custom").hide()
    $(document).on("change", '.custom-location', function (event) {
        var checkbox = $(event.target);
        if (checkbox.is(":checked")) {
            $('.location-button-bar').removeClass("active")
            // show custom form
            $(".location-custom").show()
        }else{
            $(".location-custom").hide()
        }
    });
    $(document).on("change", '.location-button-bar', function (event) {
        var checkbox = $(event.target);
        if (checkbox.is(":checked")) {
            $('.custom-location').removeClass("active")
            // hide custom form
            $(".location-custom").hide()
        }   
    });

});