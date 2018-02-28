function insertExample() {
    $.get('static/example_list.txt', function (data) {
        $('textarea#genelist').val(data);
    });
    $('#gene-count').text("375 genes");
    $('#results_submit').prop("disabled", false);
    return false;
}

function submitButtonListener(button, endpoint, settings_form) {
    $('#' + button).click(function (evt) {
        $("#blocker").show();
        $("#loader").show().css({position: 'absolute', top: $(window).scrollTop() + $(window).height() / 2});
        ;

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

function showToolDesc(tool) {
    $("#nav-" + tool + "-tab").on("click", function () {
        $(".desc").hide();
        $("#" + tool + "-desc").show();
        $("#analysis-row").show();
    })
}

function showHelpDesc(page) {
    $("#nav-" + page + "-tab").on("click", function () {
        $(".desc").hide();
        $("#analysis-row").hide();

        if (page === "datasets") {

        }
    });
}

function cleanArray(actual) {
	  var newArray = new Array();
	  for (var i = 0; i < actual.length; i++) {
	    if (actual[i]) {
	      newArray.push(actual[i]);
	    }
	  }
	  return newArray;
	}

$(function () {
    submitButtonListener("results_submit", "/X2K/results", "#x2k-form");
    submitButtonListener("results_submit_ljp", "/X2K/results", "#x2k-form");
    // submitButtonListener("x2k_submit", "http://localhost:8080/X2K/network");
    submitButtonListener("chea_submit", "/X2K/ChEA", "#chea-form");
    submitButtonListener("kea_submit", "/X2K/KEA", "#kea-form");
    submitButtonListener("g2n_submit", "/X2K/G2N", "#g2n-form");


    // text area listener
    $("#genelist").on("change keyup paste", function () {
        var len = cleanArray($('#genelist').val().trim().split('\n')).length;
        
        if (len === 0) {
        	$('#warning').text('');
        	$('#gene-count').text('');
        	$('#results_submit').prop("disabled", true); 
        } 
        else if (len > 0) {
        	$('#results_submit').prop("disabled", false);
	        if (len < 20) {
	            $('#warning').text('Warning! Inputting gene lists containing less than 20 genes may produce inaccurate results.');
	        }
	        else if (len > 3000) {
	            $('#warning').text('Warning! Inputting gene lists containing more than 3000 genes may produce inaccurate results.');
	        }
	        else {
	        	$('#warning').text('');
	        }
	
	        var genes = " genes";
	        if (len.toString()[len.toString().length - 1] === "1") {
	            genes = " gene";
	        }
	        
	        $('#gene-count').text(len + genes);
        }
    });

//    showToolDesc("x2k");
//    showToolDesc("chea");
//    showToolDesc("g2n");
//    showToolDesc("kea");
//
//    showHelpDesc("about");
//    showHelpDesc("api");
//    showHelpDesc("commandline");
//    showHelpDesc("datasets");
//
//    $("#nav-case-tab").on("click", function () {
//        $(".desc").hide();
//        $("#case-desc").show();
//        $("#analysis-row").hide();
//    })
});