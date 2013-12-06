$(document).on("change", ".filter-policy-toggle", function(event) {
    var checkbox = $(event.target);
    var toggle = checkbox.data("toggle");
    if (checkbox.is(":checked")) {
    	$("#tasks-list .list-group-item").each(function (index, elem) {
    		if ($(elem).data(toggle) === false) {
    			$(elem).hide();
    		}
    	});
    } else {
    	$("#tasks-list .list-group-item").show();
    }
});

