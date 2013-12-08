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


