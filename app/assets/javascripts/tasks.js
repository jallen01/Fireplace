var main = function () {
    filter_tasks_list();

    $('.task').each(function(index, elem) {
        $(elem).popover();
    });
}

$(document).ready(main);
$(document).on("ajaxComplete", main);

filter_tasks_list = function () {
    $("#tasks-list .list-group-item").show();

    $(".filter-policy-toggle").each(function (index, checkbox) {
        var filter = $(checkbox).data("filter");
        var checked = $(checkbox).prop("checked");


        if (filter === "all") {
            $("#tasks-list .list-group-item").each(function (index, elem) {
                if ($(elem).data("relevant") !== true && !checked) {
                    $(elem).hide();
                }
            });

        } else {
            if (checked === true) {
                $("#tasks-list .list-group-item").each(function (index, elem) {
                    if ($(elem).data(filter) === false) {
                        $(elem).hide();
                    }
                });
            }
        }
    });
}

$(document).on("change", ".filter-policy-toggle", function(event) {
    filter_tasks_list();
});

$(document).on("click", "#user-context-modal .modal-close-btn", function (event) {
    var modal = $(event.target).parents(".modal");
    $(event.target).button("loading");
    modal.find("form").first().submit();
});

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
            // show custom form
            $("#"+modal_id + " .custom-form").show()
        }else{
            $("#"+modal_id + " .custom-form").hide()
        }
    });
    $(document).on("change", ".tag-button-bar", function(event) {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(event.target);
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .custom-tag").removeClass("active")
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

