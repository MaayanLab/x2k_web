function exportJson(el,name,export_json) {
    date = new Date()

    date_string = "_" + date.getMonth() + "-" + date.getDate() + "-" + (date.getYear()+1900);

    var data = "text/json;charset=utf-8," + encodeURIComponent(export_json);
    // what to return in order to show download window?

    el.setAttribute("href", "data:"+data);
    el.setAttribute("download", name + date_string + ".json");
}

