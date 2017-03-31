function draw_network(json, tab){
    // Convert ids to indices in links
	console.log(json)
    var nodeMap = {};
    json.nodes.forEach(function(x) { nodeMap[x.id] = x; });
    json.links = json.links.map(function(x) {
      return {
        source: nodeMap[x.data.source],
        target: nodeMap[x.data.target],
        value: 1
      };
    });
    
    var width = 1024,
        height = 560;

    var color = d3.scale.category20();

    var force = d3.layout.force()
	    .charge(function(node) {
	        if (node.group === 'kinase') {return -30;}
	        else if (node.group === 'tf') {return -30;}
	        else {return -500;};})
	    .linkStrength(function(link) {
	    	if (link.source.group === link.target.group) {return 1.0;}
	    	else if ((link.source.group !== 'other')&&(link.target.group !== 'other')) {return 1.0;}
	        else {return 0.5;}
        })
        .linkDistance(width/10)
        .size([width, height]);

    var svg = d3.select(tab).append("svg")
        .attr("width", width)
        .attr("height", height);
	
    graph = json;
    
      force
          .nodes(graph.nodes)
          .links(graph.links)
          .start();
      
      var link = svg.selectAll("line.link")
          .data(graph.links)
        .enter().append("line")
          .attr("class", "link")
          .style("stroke-width", function(d) { return Math.sqrt(d.value); });

     var node = svg.selectAll("circle.node")
          .data(graph.nodes)

        .enter().append("circle")
          .attr("class", "node")
          .attr("r", width/50)
          .style("fill", function(d) { return color(d.group); })
          .call(force.drag);

     node.append("title")
     .text(function(d) { return d.id; });

         var texts = svg.selectAll("text.label")
         .data(graph.nodes)
         .enter().append("text")
         .attr("class", "label")
         .attr("fill", "black")
         .attr("dx", -12)
      	.attr("dy", ".35em")
         .text(function(d) {  return d.id.split('_')[0];  })
         .style("font-size", function(d){
        	 if(d.id.split('_')[0].length > 5){return "6px";}
        	 else return "8px";
         });
         

      force.on("tick", function() {
        link.attr("x1", function(d) { return d.source.x; })
            .attr("y1", function(d) { return d.source.y; })
            .attr("x2", function(d) { return d.target.x; })
            .attr("y2", function(d) { return d.target.y; });

        node.attr("cx", function(d) { return d.x; })
            .attr("cy", function(d) { return d.y; });
        
        texts.attr("transform", function(d) {
            return "translate(" + d.x + "," + d.y + ")"; });
    });
};