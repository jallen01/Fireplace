var update_location_url = "";

$(function () {
    update_location_url = $("#location-label").data("update-url");

    $.post(update_location_url, { utc_offset: (-60)*(new Date().getTimezoneOffset()) });
    watch_location();
    filter_tasks_list();
});

var main = function () {
    $('#tasks-list tr').each(function(index, elem) {
        $(elem).popover();
    });
}

$(document).ready(main);
$(document).on("ajaxComplete", main);

// User Context
// ============

// Code from https://developer.mozilla.org/en-US/docs/Web/API/Geolocation.watchPosition?redirectlocale=en-US&redirectslug=Web%2FAPI%2Fwindow.navigator.geolocation.watchPosition
var watch_location = function () {
    function success(pos) {
      var crd = pos.coords;

      $.post(update_location_url, { latitude: crd.latitude, longitude: crd.longitude });
    };

    function error(err) {
      console.warn('ERROR(' + err.code + '): ' + err.message);
    };

    var options = {
      enableHighAccuracy: true,
      timeout: 5000,
      maximumAge: 0
    };

    var geo_watcher = navigator.geolocation.watchPosition(success, error, options);
}

// Tasks List
// ==========

var filter_tasks_list = function () {
    $("#tasks-list tr").show();

    $(".filter-policy-toggle").each(function (index, checkbox) {
        var filter = $(checkbox).data("filter");
        var checked = $(checkbox).prop("checked");

        $("#tasks-list tr").each(function (index, elem) {
            if (filter === "all") {
                if ($(elem).data("relevant") !== true && !checked) {
                    $(elem).hide();
                }
            } else {
                if (checked === true) {
                    $("#tasks-list tr").each(function (index, elem) {
                        if ($(elem).data(filter) === false) {
                            $(elem).hide();
                        }
                    });
                }
            }
        });
    });
}
$(document).on("listUpdated", "#tasks-list", filter_tasks_list);
$(document).on("change", ".filter-policy-toggle", filter_tasks_list);


// Task Form
// =========

$(function(){
    $("#new-task-modal .custom-form").hide()
    $("#new-task-modal .day-ranges-custom").hide()
    $("#new-task-modal .time-ranges-custom").hide()
    
    $(document).on("show.bs.modal", ".modal", function (event) {
        modal_id = event.target.id
        this_modal = $(modal_id)
        console.log("modal_id")
        console.log(modal_id)
        if(modal_id.indexOf("edit-task-") != -1){ // if an edit-task modal has been opened
            //custom_tag_classes = this_modal.find(".custom-tag")
            //if($("#"+modal_id + " " + ))
            console.log("entered if statement")
            console.log($("#"+modal_id + " .custom-tag").attr("class"))
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
            //custom_tag_classes = this_modal.find(".custom-tag")
            //if($("#"+modal_id + " " + ))
            if(!$("#"+modal_id + " .custom-day-range").hasClass("active")){
                $("#"+modal_id + " .day-ranges-custom").hide()
            }
            if(!$("#"+modal_id + " .custom-time-range").hasClass("active")){
                $("#"+modal_id + " .time-ranges-custom").hide()
            }
        }
    });

    $(document).on("hidden.bs.modal", ".modal", function (event) {
        if(event.target.id === "new-task-modal"){
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
    $(document).on("change", ".custom-tag :checkbox", function(event) {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(event.target);
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
    $(document).on("change", ".tag-button-bar", function(event) {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(event.target);
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


    $(".modal-form-cancel").click(function(event){
        modal_id = $(this).parents(".modal").attr("id")
        this_modal = $(modal_id)
    });

    $(".modal-form-submit").click(function(){

    });

});

