function insertExample(genelist_id) {
    $.get('static/example_list.txt', function (data) {
        $('textarea#' + genelist_id).val(data);
    });
    return false;
}

function submitButtonListener(button, endpoint, settings_form) {
    $('#' + button).click(function (evt) {
        // evt.preventDefault();
        var $form = $(settings_form),
            text_input;

        $form.attr("action", endpoint);
        text_input = $("#genelist").val();
        console.log(JSON.stringify($form.serializeArray()))
        if (text_input.length > 0) {
            $form.submit();
        }
    });
}

$(function () {
    submitButtonListener("chea_submit", "ChEA", "#chea-form");
    submitButtonListener("kea_submit", "KEA", "#kea-form");
    // submitButtonListener("x2k_submit", "network");
    submitButtonListener("g2n_submit", "G2N", "#g2n-form");
    submitButtonListener("results_submit", "results", "#x2k-form");
});