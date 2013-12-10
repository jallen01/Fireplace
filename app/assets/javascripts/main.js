// Forms
// =====

$(function () {
    $("form").trigger("formCreated");
});

$(document).on("formCreated", function () {
    initialize_form(this);
});

var initialize_form = function (form) {
    $(form).find("[id^=_]").remove();

    $(form).find("input:text, textarea, input:checkbox, select").each(function () {
        var id = $(this).attr("id");
        var val = undefined;

        if ($(this).is("input:text, textarea")) {
            val = $(this).val();
        } else if ($(this).is("select")) {
            val = $(this).find("option:selected").val();
        } else if ($(this).is("input:checkbox")) {
            val = $(this).prop("checked");
        }

        var html = $("<input type='hidden'>").attr("id", "_" + id).val(val);
        $(this).parent().append(html);
    });
}

var reset_form = function (form) {
    $(form).find("input:text, textarea, input:checkbox, select").each(function () {
        var id = $(this).attr("id");
        var val = $(this).parent().find("#_" + id).val();

        if ($(this).is("input:text, textarea")) {
            $(this).val(val);
        } else if ($(this).is("select")) {
            $(this).find("option[value='" + val + "']").prop("selected", true);
        } else if ($(this).is("input:checkbox")) {
            $(this).prop("checked", val === "true");
            if ($(this).parents("[data-toggle='buttons']").length !== 0) {
                if (val === "true") {
                    $(this).parents(".btn").addClass("active");
                } else {
                    $(this).parents(".btn").removeClass("active");
                }
            }
        }
    });

    $(form).trigger("formReset");
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

enable_modal = function (modal) {
    $(modal).find("fieldset").attr("disabled", false);
    $(modal).find(".modal-submit-btn").button("reset");
    $(modal).find(".modal-delete-btn").button("reset");
    $(modal).find(".modal-submit-btn").removeClass("disabled");
    $(modal).find(".modal-cancel-btn").removeClass("disabled");
    $(modal).find(".modal-delete-btn").removeClass("disabled");
}

disable_modal = function (modal) {
    $(modal).find("fieldset").attr("disabled", true);
    $(modal).find(".modal-submit-btn").addClass("disabled");
    $(modal).find(".modal-cancel-btn").addClass("disabled");
    $(modal).find(".modal-delete-btn").addClass("disabled");
}

// Remove hash on modal close
$(document).on("hidden.bs.modal", ".modal", function () {
    $(this).find(".validation-errors").remove();
    $(this).find(".nav-tabs a:first").tab("show"); 
});

// Reset form fields if data-form="reset"
$(document).on("hidden.bs.modal", ".modal[data-form='reset']", function () {
    reset_form($(this).find("form"));
});

// Register modal submit button. Submits form in modal with class "modal-form".
$(document).on("click", ".modal-submit-btn", function () {
    var modal = $(this).parents(".modal");

    modal.find(".modal-form").first().submit();

    $(this).button("loading");
    disable_modal(modal);
});

// Register modal delete button. Disables modal buttons.
$(document).on("click", ".modal-delete-btn", function () {
    var modal = $(this).parents(".modal");

    $(this).button("loading");
    disable_modal(modal);
});





