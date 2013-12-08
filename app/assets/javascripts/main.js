// Primary Author: Jonathan Allen (jallen01)

var main = function () {
    widen_modal();
}

$(document).ready(main);
$(document).on("ajaxComplete", main);

// Forms
// =====

$(function () {
    $(".modal form").each(function (i, form) {
        initialize_form(form);
    });
});

$(document).on("formCreated", function (event) {
    initialize_form(event.target);
    widen_modal();
});

var initialize_form = function (form) {
    $(form).find("[id^=_]").remove();

    $(form).find("input[type=text], textarea").each(function (i, input) {
        var id = $(input).attr("id");
        var val = $(input).val();

        var hidden = $("<input type='hidden'>").attr("id", "_" + id).val(val);
        $(input).parent().append(hidden);
    });

    $(form).find("input[type=checkbox]").each(function (i, checkbox) {
        var id = $(checkbox).attr("id");
        var checked = $(checkbox).prop("checked");

        var hidden = $("<input type='hidden'>").attr("id", "_" + id).val(checked);
        $(checkbox).parent().append(hidden);
    });
}


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

var widen_modal = function(){
    $(".modal-dialog").css("min-width", function(){
        return ($("html").width())*4.0/5;
    });
}

enable_modal = function (modal) {
    $(modal).find("fieldset").attr("disabled", false);
    $(modal).find(".modal-submit-btn").button("reset");
    $(modal).find(".modal-cancel-btn").button("reset");
    $(modal).find(".modal-submit-btn").removeClass("disabled");
    $(modal).find(".modal-cancel-btn").removeClass("disabled");
}

disable_modal = function (modal) {
    $(modal).find("fieldset").attr("disabled", true);
    $(modal).find(".modal-submit-btn").addClass("disabled");
    $(modal).find(".modal-cancel-btn").addClass("disabled");
}

// Remove hash on modal close
$(document).on("hidden.bs.modal", ".modal", function (event) {
    removeHash();
    $(event.target).find(".validation-errors").remove();
});

// Reset form fields if data-form="reset"
$(document).on("hidden.bs.modal", ".modal[data-form='reset']", function (event) {
    $(event.target).find("input[type=text], textarea").each(function (i, input) {
        var id = String($(input).attr("id"));
        var val = $(event.target).find("#_" + id).val();

        $(input).val(val);
    });

    $(event.target).find("input[type=checkbox]").each(function (i, checkbox) {
        var id = String($(checkbox).attr("id"));
        var checked = $(event.target).find("#_" + id).val();

        $(checkbox).prop("checked", checked === "true");
    });
});

// Register modal submit button. Submits form in modal with class "modal-form".
$(document).on("click", ".modal-submit-btn", function (event) {
    var modal = $(event.target).parents(".modal");

    modal.find(".modal-form").first().submit();

    $(event.target).button("loading");
    disable_modal(modal);
});

// Register modal delete button. Disables modal buttons.
$(document).on("click", ".modal-delete-btn", function (event) {
    var modal = $(event.target).parents(".modal");

    $(event.target).button("loading");
    disable_modal(modal);
});
