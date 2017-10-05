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
            text_input = $("#genelist").val();

        $form.attr("action", endpoint);
        
        // Hack that works like a charm        
        var input = $("<input>")
        	.attr("type", "hidden")
        	.attr("name", "text-genes").val(text_input);
        $form.append($(input));
        
        if (text_input.length > 0) {
            $form.submit();
        }
    });
}

$(function () {
	$(".desc").hide();
	$("#x2k-desc").show();
    submitButtonListener("chea_submit", "http://localhost:8080/X2K/ChEA", "#chea-form");
    submitButtonListener("kea_submit", "http://localhost:8080/X2K/KEA", "#kea-form");
    // submitButtonListener("x2k_submit", "http://localhost:8080/X2K/network");
    submitButtonListener("g2n_submit", "http://localhost:8080/X2K/G2N", "#g2n-form");
    submitButtonListener("results_submit", "http://localhost:8080/X2K/results", "#x2k-form");
    
    $("#nav-x2k-tab").on("click", function(){$(".desc").hide(); $("#x2k-desc").show();})
    $("#nav-chea-tab").on("click", function(){$(".desc").hide(); $("#chea-desc").show();})
    $("#nav-g2n-tab").on("click", function(){$(".desc").hide(); $("#g2n-desc").show();})
    $("#nav-kea-tab").on("click", function(){$(".desc").hide(); $("#kea-desc").show();})
    
});