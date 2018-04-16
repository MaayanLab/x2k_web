function drawBargraph(chart, bargraph_data) {
    bargraph_data = bargraph_data.slice(0, 10);

    function sortByScore(data, score, dir) {
        if (dir == "desc") {
            data.sort(function (a, b) {
                return (a[score] > b[score]) ? 1 : ((b[score] > a[score]) ? -1 : 0);
            });
        } else {
            data.sort(function (a, b) {
                return (a[score] < b[score]) ? 1 : ((b[score] < a[score]) ? -1 : 0);
            });
        }
    }

    function change(score) {
        var range0 = function (d) {
            return d[score];
        };
        sortByScore(bargraph_data, score, "asc");

        if (score === "combinedScore") {
            sortByScore(bargraph_data, score, "desc");
            var x0 = x.domain([0, d3.max(bargraph_data, function (d) {
                return d[score];
            })]);
            var caption = "Combined score";
        }
        else if (score === "pvalue") {
            var x0 = x.domain([0, d3.max(bargraph_data, function (d) {
                return -Math.log10(d[score]);
            })]);
            var range0 = function (d) {
                return -Math.log10(d[score]);
            }
            var caption = "-log₁₀(p-value)";
        }
        else if (score === "zscore") {
            var x0 = x.domain([d3.max(bargraph_data, function (d) {
                return d[score];
            }), d3.min(bargraph_data, function (d) {
                return d[score];
            })]);
            var caption = "Z-score"
        }

        var y0 = y.domain(bargraph_data.map(function (d) {
            return d.name;
        }));

        var transition = svg.transition().duration(750),
            delay = function (d, i) {
                return i * 50;
            };

        transition.selectAll(".bar")
            .attr("width", function (d) {
                return x0(range0(d));
            })
            .attr("y", function (d) {
                return y0(d.name);
            });

        transition.select(".axis--x")
            .call(d3.axisBottom(x0));

        transition.select(".caption")
            .text(caption);

        transition.select(".axis--y")
            .call(d3.axisLeft(y0).tickSize(0))
            .selectAll("text")
            .text(function (d) {
                return d.split(/[_-]/)[0]
            });

        transition.selectAll(".bar-label")
            .attr("x", function (d) {
                return Math.max(x0(range0(d)) - 5, 80);
            })
            .attr("y", function (d) {
                return y0(d.name) + y.bandwidth() / 2;
            })
            .attr("fill", function (d) {
                if ((x0(range0(d)) - 5) < 80) {
                    return "gray"
                }
                else {
                    return "white"
                }
            })
            .text(function (d) {
                if (score === "pvalue") {
                    return d[score].toExponential(2);
                }
                else {
                    return d[score].toFixed(3);
                }

            });
    }

    function onClick(chart, score) {
        $("input[class*='" + chart.substr(1) + "-']").removeClass("selected");
        change(score);
    }

    sortByScore(bargraph_data, "pvalue", "asc");

    // Change buttons listeners
    $(chart + "-pvalue").on("click", function () {
        onClick(chart, "pvalue");
        $(this).addClass("selected");
    });
    $(chart + "-zscore").on("click", function () {
        onClick(chart, "zscore");
        $(this).addClass("selected");
    });
    $(chart + "-combinedScore").on("click", function () {
        onClick(chart, "combinedScore");
        $(this).addClass("selected");
    });

    var svg = d3.select(chart),
        margin = {top: 10, right: 10, bottom: 50, left: 100},
        width = 1000 - margin.left - margin.right,
        height = 600 - margin.top - margin.bottom;

    var x = d3.scaleLinear().rangeRound([0, width]),
        y = d3.scaleBand().rangeRound([height, 0]).padding(0.3);

    var g = svg.append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    x.domain([0, d3.max(bargraph_data, function (d) {
        return -Math.log10(d.pvalue);
    })]);
    y.domain(bargraph_data.map(function (d) {
        return d.name;
    }));

    g.append("g")
        .attr("class", "axis axis--x")
        .attr("transform", "translate(0," + height + ")")
        .call(d3.axisBottom(x))
        .attr("font-size", "1.1rem");

    // X-axis caption
    g.select(".axis--x")
        .append("text")
        .attr("class", "caption")
        .attr("x", width / 2)
        .attr("y", margin.bottom / 1.5)
        .attr("dy", "0.71em")
        .attr("font-size", "1.2rem")
        .text("-log₁₀(p-value)");

    // X-axis ticks
    g.selectAll(".axis--x text")
        .attr("fill", "black")
        .attr("font-size", "1.2rem");

    // Bar names
    g.append("g")
        .attr("class", "axis axis--y")
        .attr("fill", "none")
        .call(d3.axisLeft(y).tickSize(0))
        .selectAll("text")
        .attr("fill", "black")
        .attr("font-size", "1.2rem")
        .text(function (d) {
            return d.split(/[_-]/)[0]
        });

    g.select(".axis--y path")
        .attr("display", "none");

    // Entering joins for bars
    g.selectAll(".bar")
        .data(bargraph_data)
        .enter()
        .append("g")
        .attr("class", "bar-container");

    // Determine whether network is kinase or TF - please change this is a terrible hack :)
    var network_type = bargraph_data[0]['name'].indexOf('_') > -1 ? 'tf' : 'kinase',
        fill = network_type === 'tf' ? "#FF546D" : "#6B9BC3";

    // Drawing bars
    g.selectAll(".bar-container")
        .append("rect")
        .attr("class", "bar")
        .attr("x", 0)
        .attr("y", function (d) {
            return y(d.name);
        })
        .attr("width", function (d) {
            return x(-Math.log10(d.pvalue));
        })
        .attr("height", y.bandwidth())
        .attr("fill", fill);

    // Values on bars
    g.selectAll(".bar-container")
        .append("text")
        .attr("class", "bar-label")
        .attr("text-anchor", "end")
        .attr("x", function (d) {
            return Math.max(x(-Math.log10(d.pvalue)) - 5, 80);
        })
        .attr("y", function (d) {
            return y(d.name) + y.bandwidth() / 2;
        })
        .attr("dy", ".35em")
        .attr("fill", function (d) {
            if (Math.max(x(-Math.log10(d.pvalue)) - 5) < 80) {
                return "gray"
            }
            else {
                return "white"
            }
        })
        .attr("font-size", "1.2rem")
        .text(function (d) {
            return d["pvalue"].toExponential(2);
        });
}