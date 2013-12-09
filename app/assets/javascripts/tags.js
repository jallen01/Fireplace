// Primary Author: Rebecca Krosnick (krosnick)

$(function(){
	// Custom day ranges
    $("#new-tag-modal .day-ranges-custom").hide()
    $("#new-tag-modal .time-ranges-custom").hide()
    $(document).on("hidden.bs.modal", ".modal", function () {
        if($(this).attr("id") === "new-tag-modal"){
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

	$(document).on("change", '.custom-day-range :checkbox', function () {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .day-button-bar").removeClass("active")
            $("#"+modal_id + " .day-button-bar :checked").attr("checked", false)
            $("#"+modal_id + " .day-ranges-custom").show()
        }else{
            $("#"+modal_id + " .spec-day").removeClass("active")
            $("#"+modal_id + " .spec-day :checked").attr("checked", false)
        	$("#"+modal_id + " .day-ranges-custom").hide()
        }
    });
    $(document).on("change", '.day-button-bar', function () {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .spec-day").removeClass("active")
            $("#"+modal_id + " .custom-day-range").removeClass("active")
            $("#"+modal_id + " .spec-day :checked").attr("checked", false)
            $("#"+modal_id + " .day-ranges-custom").hide()
        }   
    });

    // Custom time ranges
	$(document).on("change", '.custom-time-range :checkbox', function () {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .time-button-bar").removeClass("active")
            $("#"+modal_id + " .time-button-bar :checked").attr("checked", false)
            $("#"+modal_id + " .time-ranges-custom").show()
        }else{
            $("#"+modal_id + " .spec-time").removeClass("active")
            $("#"+modal_id + " .spec-time :checked").attr("checked", false)
        	$("#"+modal_id + " .time-ranges-custom").hide()
        }
    });
    $(document).on("change", '.time-button-bar', function () {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .spec-time").removeClass("active")
            $("#"+modal_id + " .custom-time-range").removeClass("active")
            $("#"+modal_id + " .spec-time :checked").attr("checked", false)
            $("#"+modal_id + " .time-ranges-custom").hide()
        }   
    });

    // Custom locations
    $(".locations-custom").hide()
    $(document).on("change", '.custom-location', function () {
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            $('.location-button-bar').removeClass("active")
            $(".location-custom").show()
        }else{
            $(".location-custom").hide()
        }
    });
    $(document).on("change", '.location-button-bar', function () {
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            $('.custom-location').removeClass("active")
            $(".location-custom").hide()
        }   
    });

});