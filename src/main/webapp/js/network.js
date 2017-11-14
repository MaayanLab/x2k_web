function draw_network(json, svg_id, body){
    // Convert ids to indices in links
    var nodeMap = {};

    json.nodes.forEach(function(x) {nodeMap[x.name] = x;});

    json.links = json.links.map(function(x) {
      return {
        source: nodeMap[x.data.source].name,
        target: nodeMap[x.data.target].name,
        value: nodeMap[x.data.source].pvalue,
      };
    });

    var nodes_data = json.nodes;
    var links_data = json.links

    // Size of a node depends linearly on a number of edges
    function radius(d){
        // This one is the most accurate representation
        // return Math.sqrt((single_degree_node_size * d.degree) / Math.PI);
    	if (body === "#x2k-network") {
    		return Math.floor(Math.sqrt(20*d.degree));
    	}
    	else{
    		return 20;
    	}
    }

    function tickActions() {
        nodes
            .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });

        link
            .attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });    
    }

    function drag_start(d) {
        if (!d3.event.active) simulation.alphaTarget(0.01).restart();
        d.fx = d.x;
        d.fy = d.y;
    }
     
    function drag_drag(d) {
        d.fx = d3.event.x;
        d.fy = d3.event.y;
    }
     
    function drag_end(d) {
        if (!d3.event.active) simulation.alphaTarget(0);
        d.fx = d.x;
        d.fy = d.y;
    }

    function circleColour(d){
      if(d.group =="tf"){
        return "#FF546D";
      } else if((d.group =="kinase")||(d.group =="input_protein")){
        return "#339DCC";
      }
      else {
        return "#FF7F0E";
      }
    }

    function linkColour(d){
        var source_tf = (d.source_type === "tf"),
            source_kinase = ((d.source_type === "kinase")||(d.source_type === "input_protein")),
            source_other = ((d.source_type === "other")||(d.source_type === "intermediate")),
            target_tf = (d.target_type === "tf"),
            target_kinase = ((d.target_type === "kinase")||(d.target_type === "input_protein")),
            target_other = ((d.target_type === "other")||(d.target_type === "intermediate"));

        if((source_tf)&&(target_tf)) {
            return "#FF546D";
        } else if((source_kinase)&&(target_kinase)) {
            return "#339DCC";
        } else if((source_other)&&(target_other)) {
            return "lightgray";
        } else if(((source_tf)&&(target_kinase))||((source_kinase)&&(target_tf))) {
            return "#339DCC";
        } else if(((source_tf)&&(target_other))||((source_other)&&(target_tf))) {
            return "#FF6A3C";
        } else if(((source_kinase)&&(target_other))||((source_other)&&(target_kinase))) {
            return "#269C26";
        }
    }

    function box_force() {
      for (var i = 0, n = nodes_data.length; i < n; i++) {
	    	  (function (i){	    		  
				curr_node = nodes_data[i];
				r = radius(curr_node);
				if((curr_node.group == "tf")||(curr_node.group == "kinase")){
					curr_node.x = Math.max(r, Math.min(width - r, curr_node.x));
					curr_node.y = Math.max(r + r * 2, Math.min(height - r - r * 2, curr_node.y));
				} else if(curr_node.group == "other"){
					curr_node.x = Math.max(r, Math.min(width - r, curr_node.x));
				}
	    	  })(i);
    	  }
    }

    function splitting_force() {
      for (var i = 0, n = nodes_data.length; i < n; i++) {
    	  (function(i){
    		  if(body === "#x2k-network"){
		        curr_node = nodes_data[i];
		        if((curr_node.group == "tf")||(curr_node.group == "intermediate")){
		            curr_node.y += 10;
		        } else if((curr_node.group == "kinase")||(curr_node.group == "input_protein")){
		            curr_node.y -= 10;
		        }
    		  }
    	  })(i);
      }
    }

    function zoom_actions(){
        g.attr("transform", d3.event.transform)
    }

    function link_mouseover() {
        div.style("display", "inline");
    }

    function link_mousemove(d) {
        div
            .text("p-value: " + d.value)
            .style("left", (d3.event.pageX - 34) + "px")
            .style("top", (d3.event.pageY - 12) + "px");
    }

    function link_mouseout() {
        div.style("display", "none");
    }

    function node_mouseover(d) {
    	console.log('node_mouseover');
        div.style("display", "inline");
        
        // connectedNodes()
        if (toggle == 0) {
            node.attr("opacity", function (o) {
                return neighboring(d, o) | neighboring(o, d) ? 1 : 0.15;
            });
            toggle = 1;
        } else {
            node.attr("opacity", 1);
            toggle = 0;
        }

      link.attr("stroke-width", function(l) {
    	  if (d === l.source || d === l.target) return 2;
        });
      link.attr("stroke-opacity", function(l) {
    	  if (d === l.source || d === l.target) return 1;
    	  else return 0.05
        });
    }

    function node_mousemove(d) {
    	console.log('node_mousemove');
        if (d.group === "tf"){
            div
                .text(d.name)
                .style("left", (d3.event.pageX - 34) + "px")
                .style("top", (d3.event.pageY - 12) + "px");
        } 
        else{ div.style("display", "none");}
    }

    function node_mouseout() {
    	console.log('node_mouseout');
        div.style("display", "none");

        node.attr("opacity", 1);
        toggle = 0;
        link.attr("stroke-width", 1.2);    
        link.attr("stroke", linkColour)
            .attr("stroke-opacity", function(d) {
            	if (body === "#x2k-network") {
            		return linkOpacity(d.value);
            	}
            	else { return 0.3; }
            });    
    }

    function neighboring(a, b) {
        return linkedByIndex[a.name + "," + b.name];
    }

    function connectedNodes() {
        if (toggle == 0) {

            d = d3.select(this).node().__data__;
            node.style("opacity", function (o) {
                return neighboring(d, o) | neighboring(o, d) ? 1 : 0.15;
            });
            toggle = 1;
        } else {
            node.style("opacity", 1);
            toggle = 0;
        }
    }

    var svg = d3.select(svg_id),
	    width = 1000,
	    height = 600;
    
//        width = +svg.attr("width"),
//        height = +svg.attr("height");
     
    var g = svg.append("g");

    var simulation = d3.forceSimulation()
            .nodes(nodes_data);
    
    var link = g.append("g")
            .attr("class", "links")
            .selectAll("line")
            .data(links_data)
            .enter()
            .append("line")
            .attr("stroke-width", 1.2)
            .on("mouseover", link_mouseover)
            .on("mousemove", function(d) { return link_mousemove(d); })
            .on("mouseout", link_mouseout);

    var node = g.append("g")
            .attr("class", "nodes")
            .selectAll("circle")
            .data(nodes_data)
            .enter()
            .append("g")
            .attr("class", "node")
            .append("circle")
            .attr("stroke", circleColour)
            .attr("stroke-width", 0.5)
            .attr("fill", circleColour)
            .on("mouseover", function(d) { return node_mouseover(d); })
            .on("mousemove", function(d) { return node_mousemove(d); })
            .on("mouseout", node_mouseout);

    // Make font size for longer labels smaller
    var font_size = d3.scaleLinear()
            .domain([d3.min(nodes_data, function(d) { return d.name.split('_')[0].length; }), d3.max(nodes_data, function(d) { return d.name.split('_')[0].length; })])
            .range([0.8, 0.5])

    var label = g.selectAll(".node")
            .append("text")
            .attr("class", "text")
            .attr("text-anchor", "middle")
            .attr("dy", ".35em")
            .style("font", function(d) { return font_size(d.name.split('_')[0].length) + "em sans-serif" })
            .attr("title", function(d) { return d.name; })
            .text(function(d) { return d.name.split('_')[0]; })
            .attr("labelLength", function(d){ return this.getComputedTextLength(); });

    // Add zoom capabilities 
    var zoom_handler = d3.zoom()
        .on("zoom", zoom_actions);

    zoom_handler(svg); 

    var nodes = g.selectAll(".node");
    var labels = g.selectAll(".text");

    // In and out degrees and radius
    node.each(function(d) {
            d.degree = 0;
    });

    link.each(function(d) {
            var node_source = $.grep(node.data(), function(e){ return e.name === d.source; });
            var node_target = $.grep(node.data(), function(e){ return e.name === d.target; });
            d.source_type = node_source[0].group;
            d.target_type = node_target[0].group;
            node_source[0].degree += 1;
            node_target[0].degree +=1;
    });


    // Highlight neighbours
    var linkedByIndex = {};
    var toggle = 0;
    for (i = 0; i < nodes_data.length; i++) {
        linkedByIndex[nodes_data[i].name + "," + nodes_data[i].name] = 1;
    };

    links_data.forEach(function (d) {
        linkedByIndex[d.source + "," + d.target] = 1;
    });

    // base_radius is length of the longest label
    var base_radius = [];
    var degrees = [];

    label.each(function(d){
        base_radius.push(this.getComputedTextLength() / 2);
    });

    nodes.each(function(d){
        degrees.push(d.degree);
    });

    var base_radius = Math.floor(d3.max(base_radius)) + 1;
    var min_node_size = Math.PI * Math.pow(base_radius, 2)
    var single_degree_node_size = min_node_size / d3.min(degrees);

    // Coloring links
    var linkOpacity = d3.scaleLinear()
            .domain([0, d3.max(links_data, function(d) { return -Math.log10(Math.abs(d.value)); })])
            .range([0.3, 0.8]);

    node.attr("r",  function(d){ return radius(d); });
    link.attr("stroke", linkColour)
        .attr("stroke-opacity", function(d) {
        	if (body === "#x2k-network") {
        		return linkOpacity(d.value);
        	}
        	else { return 0.3; }
        });

    // Forces

    var link_force =  d3.forceLink(links_data)
            .id(function(d) { return d.name; }).strength(0);

    var charge_force = d3.forceManyBody()
            .strength(-600);

    var center_force = d3.forceCenter(width / 2, height / 2);  

    var forceCollide = d3.forceCollide(function(d){ return radius(d); })
            .strength(1).iterations(3);

    var forceY = d3.forceY(height / 2)
            .strength(1);

    var forceX = d3.forceX(width / 2)
            .strength(0.4);

    var drag_handler = d3.drag()
            .on("start", drag_start)
            .on("drag", drag_drag)
            .on("end", drag_end);

    var div = d3.select(body).append("div")
        .attr("class", "d3-tooltip")
        .style("display", "none");

    simulation
            .force("links",link_force)
            .force("box_force", box_force)
            .force("charge_force", charge_force)
            .force("center_force", center_force)
            .force("forceCollide", forceCollide)
            .force("splitting", splitting_force)
            .force("forceX", forceX)        
            .force("forceY", forceY);

    simulation
            .on("tick", tickActions );    

    drag_handler(node);
    
    var x2k_legend = [["Transcription factor", "#FF546D"], ["Intermediate protein", "#FF7F0E"], ["Kinase", "#1F77B4"]],
    g2n_legend = [["Seed protein", "#1F77B4"], ["Intermediate protein", "#FF7F0E"]];
    
    if (body === "#x2k-network") {
    var legend = g.append("g")
		    .attr("font-family", "sans-serif")
		    .attr("font-size", 14)
		    .attr("text-anchor", "end")
		  .selectAll("g")
		  .data(x2k_legend)
		  .enter().append("g")
		    .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });}
    else{
        var legend = g.append("g")
	    .attr("font-family", "sans-serif")
	    .attr("font-size", 14)
	    .attr("text-anchor", "end")
	  .selectAll("g")
	  .data(g2n_legend)
	  .enter().append("g")
	    .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });
    }

	legend.append("circle")
	    .attr("cx", width - 6)
	    .attr("cy", 10)
	    .attr("r", 6)
	    .attr("fill", function(d) { return d[1]; });
	
	legend.append("text")
	    .attr("x", width - 24)
	    .attr("y", 9.5)
	    .attr("dy", "0.5em")
	    .text(function(d) { return d[0]; });    
	    
}