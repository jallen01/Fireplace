// Primary Author: Jonathan Allen (jallen01)

var main = function () {
    $('.btn-group').button();
}

$(document).ready(main);


// Miscellaneous Methods
// =====================

// Remove url hash without reloading page
// Code from http://stackoverflow.com/questions/1397329/how-to-remove-the-hash-from-window-location-with-javascript-without-page-refresh
var removeHash = function () { 
    var scrollV, scrollH, loc = window.location;
    if ("pushState" in history)
        history.pushState("", document.title, loc.pathname + loc.search);
    else {
        // Prevent scrolling by storing the page's current scroll offset
        scrollV = document.body.scrollTop;
        scrollH = document.body.scrollLeft;

        loc.hash = "";

        // Restore the scroll offset, should be flicker free
        document.body.scrollTop = scrollV;
        document.body.scrollLeft = scrollH;
    }
}


// Modal Methods
// =============

// Remove hash on modal close
$(document).on('hidden', '.modal', function (event) {
    removeHash();
    $(event.target).find(".validation-errors").remove();
});

// Reset form fields if data-form="reset"
$(document).on('hidden', '.modal[data-form="reset"]', function (event) {
    $(event.target).find("input[type=text], textarea").not("input[type=hidden]").each(function (i, elem) {
        var id = String($(elem).attr('id'));
        var value = $(event.target).find("#original_" + id).val();
        $(elem).val(value);
    });
});

// Reset form if data-form="temporary"
$(document).on('hidden', '.modal[data-form="temporary"]', function (event) {
    $(event.target).find("input[type=text], textarea").val("");
});

// Destroy modal if data-form="destroy"
$(document).on('hidden', '.modal[data-form="destroy"]', function (event) {
    $(event.target).remove();
});

// Register modal submit button. Submits form in modal with class "modal-form".
$(document).on('click', '.modal-form-submit', function (event) {
    $(event.target).parents('.modal').find(".modal-form").first().submit();
});