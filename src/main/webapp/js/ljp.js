function sendToX2K(sig, dir) {
    var file = 'static/ljp/' + dir + '/' + sig.split('.')[0] + '.json';
    $.getJSON(file, function (data) {
    	var uniques = new Set(data[sig]);
        $('textarea#ljp-genelist').val(Array.from(uniques).join('\n'));
        $('textarea#genelist').val(Array.from(uniques).join('\n'));
    });
}

$(function () {
    $.getJSON("static/meta.json", function (meta_json) {
        $('#ljp-table').DataTable({
            data: meta_json,
            columns: [
                {data: 'batch'},
                {data: 'pert'},
                {data: 'pert_desc'},
                {data: 'dose'},
                {data: 'time'},
                {data: 'cell'},
                {data: 'link'}
            ],
            initComplete: function () {
                this.api().columns().every(function () {
                    var column = this;
                    if (column.index() <= 5) {
                        var select = $('<select><option value=""></option></select>')
                            .appendTo($(column.footer()).empty())
                            .on('change', function () {
                                var val = $.fn.dataTable.util.escapeRegex(
                                    $(this).val()
                                );
                                column
                                    .search(val ? '^' + val + '$' : '', true, false)
                                    .draw();
                            });
                        // Default sort is alphabetical and it doesn't work for numerical columns, so
                        if ((column.index() === 3) || (column.index() === 4)) {
                            column.data().unique().sort(function (a, b) {
                                return a - b;
                            }).each(function (d, j) {
                                select.append('<option value="' + d + '">' + d + '</option>')
                            });
                        }
                        else {
                            column.data().unique().sort().each(function (d, j) {
                                select.append('<option value="' + d + '">' + d + '</option>')
                            });
                        }
                    }
                });
            }
        });
    });
});
