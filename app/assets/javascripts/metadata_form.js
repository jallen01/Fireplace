var reset_metadata_form = function (form) {
    $(".hidden-tag-toggle :checkbox").trigger("change");  
    $(".tag-button-bar :checkbox").trigger("change"); 
    $(".hidden-tag-toggle :checkbox").trigger("change"); 
    $(".tag-button-bar :checkbox").trigger("change"); 
    $(".time-range-toggle :checkbox").trigger("change"); 
    $(".hidden-day-range-toggle :checkbox").trigger("change"); 
    $("day-range-toggle :checkbox").trigger("change");
}

$(document).on("formReset", reset_metadata_form);

// Click hidden tag toggle
$(document).on("change", ".hidden-tag-toggle :checkbox", function() {
    var modal = $(this).parents(".modal");
    
    if ($(this).is(":checked")) {
        $(modal).find(".tag-toggle").removeClass("active");
        $(modal).find(".tag-toggle :checkbox").prop("checked", false);
        $(modal).find(".hidden-tag-form").removeClass("hidden");
    } else {
        $(modal).find(".hidden-tag-form").addClass("hidden");
    }
});

// Click tag
$(document).on("change", ".tag-button-bar :checkbox", function() {
    var modal = $(this).parents(".modal");

    if ($(this).is(":checked")) {
        $(modal).find(".hidden-tag-toggle").removeClass("active");
        $(modal).find(".hidden-tag-toggle :checkbox").prop("checked", false);
        $(modal).find(".hidden-tag-form").parent().addClass("hidden");
    }   
});

// Click hidden time range toggle
$(document).on("change", ".hidden-time-range-toggle :checkbox", function () {
    var modal = $(this).parents(".modal");

    if ($(this).is(":checked")) {
        $(modal).find(".time-range-toggle").removeClass("active");
        $(modal).find(".time-range-toggle :checkbox").prop("checked", false);
        $(modal).find(".time-range-select").parent().removeClass("hidden");
    } else {
        $(modal).find(".time-range-select").parent().addClass("hidden");
    }
});

// Click time range
$(document).on("change", ".time-range-toggle :checkbox", function () {
    var modal = $(this).parents(".modal");

    if ($(this).is(":checked")) {
        $(modal).find(".hidden-time-range-toggle").removeClass("active")
        $(modal).find(".hidden-time-range-toggle :checkbox").prop("checked", false);
        $(modal).find(".time-range-select").parent().addClass("hidden");
    }   
});

// Click hidden day range toggle
$(document).on("change", ".hidden-day-range-toggle :checkbox", function () {
    var modal = $(this).parents(".modal");

    if ($(this).is(":checked")) {
        $(modal).find(".day-range-toggle").removeClass("active");
        $(modal).find(".day-range-toggle :checkbox").prop("checked", false);
        $(modal).find(".day-range-select").parent().removeClass("hidden");
    } else {
        $(modal).find(".day-range-select").parent().addClass("hidden");
    }
});

// Click day range
$(document).on("change", ".day-range-toggle :checkbox", function () {
    var modal = $(this).parents(".modal");

    if ($(this).is(":checked")) {
        $(modal).find(".hidden-day-range-toggle").removeClass("active");
        $(modal).find(".hidden-day-range-toggle :checkbox").prop("checked", false);
        $(modal).find(".day-range-select").parent().addClass("hidden");
    }   
});