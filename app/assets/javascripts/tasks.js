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

