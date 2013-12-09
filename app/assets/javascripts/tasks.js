// Primary Author: Jonathan Allen (jallen01)

$(function () {
    var update_location_url = $("#location-label").data("update-url");

    var utc_offset = (-60)*(new Date().getTimezoneOffset());
    $.post(update_location_url, { utc_offset: utc_offset });
    watch_location();
    filter_tasks_list();
});

$(document).on("mouseover", "#tasks-list .list-group-item", function () {
    var html_str = "<blockquote>";
    html_str += "<h3><strong>" + $(this).data("title") + "</strong></h3>";
    html_str += "<h5>" + $(this).data("content") + "</h5>";
    html_str += "</blockquote>";
    $("#task-content-panel").html(html_str);
});

$(document).on("mouseout", "#tasks-list .list-group-item", function () {
    $("#task-content-panel").empty();
});

// Tasks List
// ==========

var filter_tasks_list = function () {
    $("#tasks-list .list-group-item").show();

    $(".filter-policy-toggle").each(function (index, checkbox) {
        var filter = $(checkbox).data("filter");
        var checked = $(checkbox).prop("checked");

        $("#tasks-list .list-group-item").each(function (index, item) {
            if (filter === "all") {
                if ($(item).data("relevant") !== true && !checked) {
                    $(item).hide();
                }
            } else {
                if (checked === true) {
                    if ($(item).data(filter) === false) {
                        $(item).hide();
                    }
                }
            }
        });
    });
}
$(document).on("listUpdated", "#tasks-list", filter_tasks_list);
$(document).on("change", ".filter-policy-toggle", filter_tasks_list);


// Primary Author: Rebecca Krosnick (krosnick)

// Task Form
// =========

$(function(){
    $("#new-task-modal .custom-form").hide()
    $("#new-task-modal .day-ranges-custom").hide()
    $("#new-task-modal .time-ranges-custom").hide()
    
    $(document).on("show.bs.modal", ".modal", function () {
        modal_id = $(this).attr("id");
        this_modal = $(modal_id)
        if(modal_id.indexOf("edit-task-") != -1){ // if an edit-task modal has been opened
            if(!$("#"+modal_id + " .custom-tag").hasClass("active")){
                $("#"+modal_id + " .custom-form").hide()
            }
            if(!$("#"+modal_id + " .custom-day-range").hasClass("active")){
                $("#"+modal_id + " .day-ranges-custom").hide()
            }
            if(!$("#"+modal_id + " .custom-time-range").hasClass("active")){
                $("#"+modal_id + " .time-ranges-custom").hide()
            }
        }
        if(modal_id.indexOf("edit-tag-") != -1){ // if an edit-task modal has been opened
            if(!$("#"+modal_id + " .custom-day-range").hasClass("active")){
                $("#"+modal_id + " .day-ranges-custom").hide()
            }
            if(!$("#"+modal_id + " .custom-time-range").hasClass("active")){
                $("#"+modal_id + " .time-ranges-custom").hide()
            }
        }
    });

    $(document).on("hidden.bs.modal", ".modal", function () {
        if($(this).attr("id") === "new-task-modal"){
            $("#new-task-modal .custom-form").hide()
            $("#new-task-modal .custom-tag").removeClass("active")
            $("#new-task-modal .day-ranges-custom").hide()
            $("#new-task-modal .custom-day-range").removeClass("active")
            $("#new-task-modal .time-ranges-custom").hide()
            $("#new-task-modal .custom-time-range").removeClass("active")
            $("#new-task-modal .tag-button-bar").removeClass("active")
            $("#new-task-modal .day-button-bar").removeClass("active")
            $("#new-task-modal .time-button-bar").removeClass("active")
            $("#new-task-modal .btn-day").removeClass("active")
            $("#new-task-modal .btn-time").removeClass("active")
        }
    });
    $(document).on("change", ".custom-tag :checkbox", function() {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .tag-button-bar").removeClass("active")
            $("#"+modal_id + " .tag-button-bar :checked").attr("checked", false)
            // show custom form
            $("#"+modal_id + " .custom-form").show()
        }else{
            $("#"+modal_id + " .spec-tag").removeClass("active")
            $("#"+modal_id + " .spec-tag :checked").attr("checked", false)
            $("#"+modal_id + " .spec-day").removeClass("active")
            $("#"+modal_id + " .spec-day :checked").attr("checked", false)
            $("#"+modal_id + " .spec-time").removeClass("active")
            $("#"+modal_id + " .spec-time :checked").attr("checked", false)
            $("#"+modal_id + " .custom-form").hide()
        }
    });
    $(document).on("change", ".tag-button-bar :checkbox", function() {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(this);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .custom-tag").removeClass("active")
            $("#"+modal_id + " .custom-tag :checked").attr("checked", false)
            $("#"+modal_id + " .spec-tag").removeClass("active")
            $("#"+modal_id + " .spec-tag :checked").attr("checked", false)
            $("#"+modal_id + " .spec-day").removeClass("active")
            $("#"+modal_id + " .spec-day :checked").attr("checked", false)
            $("#"+modal_id + " .spec-time").removeClass("active")
            $("#"+modal_id + " .spec-time :checked").attr("checked", false)
            // hide custom form
            $("#"+modal_id + " .custom-form").hide()
        }   
    });


    $(".modal-form-cancel").click(function(){
        modal_id = $(this).parents(".modal").attr("id")
        this_modal = $(modal_id)
    });

});

