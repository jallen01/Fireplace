$(document).on("change", ".filter-policy-toggle", function(event) {
    var checkbox = $(event.target);
    var filter = checkbox.data("filter");
    if (checkbox.is(":checked")) {
    	$("#tasks-list .list-group-item").each(function (index, elem) {
    		if ($(elem).data(filter) === false) {
    			$(elem).hide();
    		}
    	});
    } else {
    	$("#tasks-list .list-group-item").show();
    }
});

$(function(){
    //$(".custom-form").hide()
    /*$("#new-task-modal").on("close", function(){
        console.log("show modal");
    });*/
    $("#new-task-modal .custom-form").hide()
    $("#new-task-modal .day-ranges-custom").hide()
    $("#new-task-modal .time-ranges-custom").hide()
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
    $('.custom-tag').change(function() {
        if(!$(this).hasClass("active")) {
            $('.tag-button-bar').removeClass("active")
            // show custom form
            $(".custom-form").show()
        }else{
            $(".custom-form").hide()
        }
    });
    $('.tag-button-bar').change(function() {
        if(!$(this).hasClass("active")) {
            $('.custom-tag').removeClass("active")
            // hide custom form
            $(".custom-form").hide()
        }   
    });
});

