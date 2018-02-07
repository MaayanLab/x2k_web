function insertExample() {
    $.get('static/example_list.txt', function (data) {
        $('textarea#genelist').val(data);
    });
    return false;
}

function submitButtonListener(button, endpoint, settings_form) {
    $('#' + button).click(function (evt) {
    	$("#blocker").show();
    	$("#loader").show().css({position: 'absolute', top: $(window).scrollTop() + $(window).height() / 2});;
    	
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

function geneCount(){
	if ($('#genelist').val()){
		var len_num = $('#genelist').val().trim().split(/\r?\n/g).length.toString();
		var len = len_num.toString();
		var last_chr = len[len.length-1];
		var warning = "";
		if (len_num < 100){
			//	TODO 
			warning = "Number of genes is lower than recommended.\nIf a gene list is shorter than 100 genes result can be ...";
		}
		else if(len_num > 500){
			//	TODO
			warning = "Number of genes is higher than recommended.\nIf a gene list is longer than 500 genes result can be ...";
		}
		
		var genes = " genes";
		if(last_chr==="1"){
			genes = " gene";
		}
		
		$('#gene-count').text(len_num + genes);
	}
	
}


$(function () {
    submitButtonListener("results_submit", "/X2K/results", "#x2k-form");
    submitButtonListener("results_submit_ljp", "/X2K/results", "#x2k-form");
    // submitButtonListener("x2k_submit", "http://localhost:8080/X2K/network");
    submitButtonListener("chea_submit", "/X2K/ChEA", "#chea-form");
    submitButtonListener("kea_submit", "/X2K/KEA", "#kea-form");
    submitButtonListener("g2n_submit", "/X2K/G2N", "#g2n-form");
    

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