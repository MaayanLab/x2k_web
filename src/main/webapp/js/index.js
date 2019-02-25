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

function checkSpecies(h, m, b) {
    $('#chea-x2k-human').prop('checked', h);
    $('#chea-x2k-mouse').prop('checked', m);
    $('#chea-x2k-both').prop('checked', b);
}

function deactivateSpecies(h, m, b) {
    $('#chea-x2k-human').prop('disabled', h);
    $('#chea-x2k-mouse').prop('disabled', m);
    $('#chea-x2k-both').prop('disabled', b);
}

function db2species() {
    $("#x2k_chea2015").change(function () {
        checkSpecies(false, false, true);
        deactivateSpecies(false, false, false)
    });
    $("#x2k_encode2015").change(function () {
        checkSpecies(false, false, true);
        deactivateSpecies(false, false, false)
    });
    $("#x2k_chea-encode").change(function () {
        checkSpecies(false, false, true);
        deactivateSpecies(true, true, false)
    });
    $("#x2k_transfac-jaspar").change(function () {
        checkSpecies(false, false, true);
        deactivateSpecies(false, false, false)
    });
    $("#x2k_ChEA_2016").change(function () {
        checkSpecies(false, false, true);
        deactivateSpecies(true, true, false)
    });
    $("#x2k_ARCHS4").change(function () {
        checkSpecies(true, false, false);
        deactivateSpecies(false, true, true)
    });
    $("#x2k_CREEDS").change(function () {
        checkSpecies(false, false, true);
        deactivateSpecies(true, true, false)
    });
    $("#x2k_Enrichr_Co-occurrence").change(function () {
        checkSpecies(false, false, true);
        deactivateSpecies(true, true, false)
    });
}


function cleanArray(actual) {
	  var newArray = [];
	  for (var i = 0; i < actual.length; i++) {
	    if (actual[i]) {
	      newArray.push(actual[i]);
	    }
	  }
	  return newArray;
	}

$(document).ready(function () {
    if(window.location.hash.indexOf('=') > 0) {
        const hash_args = window.location.hash.slice(1).split('&').reduce((args, arg) => {
            const [key, val] = arg.split('=')
            args[decodeURIComponent(key.replace(/\+/g, '%20'))] = decodeURIComponent(val.replace(/\+/g, '%20'))
            return args
        }, {})
        if(hash_args.error !== undefined) {
            $('#error').show();
            $('#error').text(hash_args.error);
        }
    }

    db2species();

    // Checkboxes listener
    $('.form-check-input').change(function(){$(this).val($(this).prop('checked'));});

    submitButtonListener("results_submit", "/X2K/results", "#x2k-form");
    submitButtonListener("results_submit_ljp", "/X2K/results", "#x2k-form");
    submitButtonListener("chea_submit", "/X2K/ChEA", "#chea-form");
    submitButtonListener("kea_submit", "/X2K/KEA", "#kea-form");
    submitButtonListener("g2n_submit", "/X2K/G2N", "#g2n-form");

    // Check for Internet Explorer
    $(document).ready(function() {
        if ((!!window.MSInputMethodContext && !!document.documentMode) || navigator.userAgent.indexOf("MSIE")!=-1) {
            $('.show-on-ie').show();
        }
    });

    // text area listener
    $("#genelist").on("change keyup paste", function () {
        $('#genelist').val($('#genelist').val().trim().split(/[\s\n,]/).join('\n'));
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

    $('.datatable').DataTable({
        scrollX: true,
    });

    $("body").tooltip({ selector: '[data-toggle=tooltip]' });
});