$(function(){
    $("#new-task-modal .custom-form").hide()
    $("#new-task-modal .day-ranges-custom").hide()
    $("#new-task-modal .time-ranges-custom").hide()
    
    $(document).on("show.bs.modal", ".modal", function (event) {
        modal_id = event.target.id
        this_modal = $(modal_id)
        if(event.target.id.indexOf("edit-task-") != -1){ // if an edit-task modal has been opened
            //custom_tag_classes = this_modal.find(".custom-tag")
            //if($("#"+modal_id + " " + ))
            if(!$("#"+modal_id + " .custom-tag").hasClass("active")){
                $("#"+modal_id + " .custom-form").hide()
            }
        }
        if(event.target.id.indexOf("edit-tag-") != -1){ // if an edit-task modal has been opened
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
    $(".custom-tag :checkbox").change(function(event) {
        modal_id = $(this).parents(".modal").attr("id")
        //console.log("#"+modal_id + " .tag-button-bar")
        var checkbox = $(event.target);
        //if($(this).hasClass("active")) {
        //console.log("checkbox")
        //console.log(checkbox)
        console.log("checked status")
        console.log(checkbox.is(":checked"))
        console.log(this)
        if (checkbox.is(":checked")) {
            $("#"+modal_id + " .tag-button-bar").removeClass("active")
            // show custom form
            $("#"+modal_id + " .custom-form").show()
            /*console.log("#"+modal_id + " .custom-form")
            console.log(event)
            console.log("custom form shown")*/
        }else{
            $("#"+modal_id + " .custom-form").hide()
            /*console.log("#"+modal_id + " .custom-form")
            console.log(event)
            console.log("custom form hidden")*/
        }
    });
    $('.tag-button-bar').change(function(event) {
        modal_id = $(this).parents(".modal").attr("id")
        var checkbox = $(event.target);
        //console.log("checkbox")
        //console.log(checkbox)
        if (checkbox.is(":checked")) {
        //if(!$(this).hasClass("active")) {
            $("#"+modal_id + " .custom-tag").removeClass("active")
            // hide custom form
            $("#"+modal_id + " .custom-form").hide()
        }   
    });


    $(".modal-form-cancel").click(function(event){
        modal_id = $(this).parents(".modal").attr("id")
        this_modal = $(modal_id)
        //console.log("cancel button pressed")
    });

    $(".modal-form-submit").click(function(){
        console.log("save button pressed")
    });

});

