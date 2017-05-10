function draw_network(json, tab){
    // Convert ids to indices in links
    var nodeMap = {};
    json.nodes.forEach(function(x) { nodeMap[x.id] = x; });
    json.links = json.links.map(function(x) {
      return {
        source: nodeMap[x.data.source],
        target: nodeMap[x.data.target],
        value: 1
      };
    });
    
    var width = 1000,
        height = 600;

    var color = d3.scale.category20();

    if (tab === '#x2k-network'){
    var force = d3.layout.force()
	    .charge(function(node) {
	        if (node.group === 'kinase') {return -500;}
	        else if (node.group === 'tf') {return -500;}
	        else {return -600;};})
	    .linkStrength(function(link) {
	    	if (link.source.group === link.target.group) {return 1.0;}
	    	else if ((link.source.group !== 'other')&&(link.target.group !== 'other')) {return 0.0;}
	        else {return 0.05;}
        })
        .linkDistance(width/60)
        .size([width, height]);}
    else if (tab === '#network-g2n'){
        var force = d3.layout.force()
	    .charge(function(node) {
	        if (node.group === 'kinase') {return -400;}
	        else if (node.group === 'tf') {return -400;}
	        else {return -400;};})
	    .linkStrength(function(link) {
	    	if (link.source.group === link.target.group) {return 1.0;}
	    	else if ((link.source.group !== 'other')&&(link.target.group !== 'other')) {return 1.0;}
	        else {return 0;}
        })
        .linkDistance(width/80)
        .size([width, height]);}

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
	          .attr("r", width/70)
	          .style("fill", function(d) { return color(d.group); })
	          .call(force.drag);

     node.append("title")
     	.text(function(d) { return d.id; });
     
     var texts = svg.selectAll("text.label")
         .data(graph.nodes)
         .enter().append("text")
         .attr("class", "label")
         .attr("fill", "black")
         .style("text-anchor", "middle")
      	.attr("dy", ".35em")
         .text(function(d) {  return d.id.split('_')[0];  })
         .style("font-size", function(d){
        	 if(d.id.split('_')[0].length < 7){return "6px";}
        	 else return "5px";
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