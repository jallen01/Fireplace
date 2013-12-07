var main = function () {
}

$(document).ready(main);
$(document).on("ajaxComplete", main);

$(document).on("mouseover", "#tasks-list .list-group-item", function (event) {
    $(event.target).popover("show");
    console.log("hi");
});

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
    $(".custom-form").hide()
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

