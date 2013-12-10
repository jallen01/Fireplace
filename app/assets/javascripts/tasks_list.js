$(function () {
    var update_utc_offset_url = $("#urls").data("update-utc-offset");
    if (update_utc_offset_url) {
        var utc_offset = (-60)*(new Date().getTimezoneOffset());
        $.post(update_utc_offset_url, { utc_offset: utc_offset });
    }
    
    filter_tasks_list();
});

// Hover preview
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

// Filtering
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