function draw_network(json){
	console.log(json);
    // Convert ids to indices in links
    var nodeMap = {};
    json.nodes.forEach(function(x) { nodeMap[x.id] = x; });
    json.links = json.links.map(function(x) {
      return {
        source: nodeMap[x.source],
        target: nodeMap[x.target],
        value: x.weight
      };
    });
    
    var width = 1024,
        height = 768;

    var color = d3.scale.category20();

    var force = d3.layout.force()
        .charge(-120)
        .linkDistance(50)
        .size([width, height]);

    var svg = d3.select("body").append("svg")
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
          .attr("r", 10)
          .style("fill", function(d) { return color(d.group); })
          .call(force.drag);

     node.append("title")
     .text(function(d) { return d.id; });

         var texts = svg.selectAll("text.label")
         .data(graph.nodes)
         .enter().append("text")
         .attr("class", "label")
         .attr("fill", "white")
         .attr("dx", -3)
      	.attr("dy", ".35em")
         .text(function(d) {  return d.id;  });
         

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