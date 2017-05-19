var ww = $(window).width();
var wh = $(window).height();


var w = 600,
    h = 600,
    nodes = [],
    node;

var vis = d3.select(".intro-img").append("svg")
    .attr("width", w)
    .attr("height", h);

var force = d3.layout.force()
    .nodes(nodes)
    .links([])
    .size([w, h]);

force.on("tick", function(e) {
    vis.selectAll("path")
        .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
});

var nodecolors = ["#FFD900","317EDB","E93681","#43F4D2"];

setInterval(function(){

    totalnodes = vis.selectAll("path").size();

    if (totalnodes < 200) {
        // Add a new random shape.
        nodes.push({
            type: d3.svg.symbolTypes[~~(Math.random() * d3.svg.symbolTypes.length)],
            size: Math.random() * 300 + 10
        });

        // Restart the layout.
        force.start();

        vis.selectAll("path")
            .data(nodes)
            .enter().append("path")
            .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; })
            .attr("d", d3.svg.symbol()
                .size(function(d) { return d.size; })
                .type(function(d) { return d.type; }))
            .style("fill", nodecolors[Math.floor(Math.random() * nodecolors.length) + 0])
            // 			.style("stroke", "white")
            // 			.style("stroke-width", "1.5px")
            .call(force.drag);


        totalnodes = vis.selectAll("path").size();

    } else {
        return false
    }




}, 50);








$nav = $('.nav');
$intro = $('.intro');



$(window).scroll(function(){
    var scroll = $(window).scrollTop();
    var introOffset = $intro.offset().top;
    var introHeight = $intro.height();

    if (scroll > introOffset + introHeight) {
        $nav.addClass('shazam');
    } else {
        $nav.removeClass('shazam');
    }
})





$productitem = $('.product-item');

$productitem.on('click',function(){
    $productitem.removeClass('active');
    $(this).addClass('active');
})








$(function() {
    $('a[href*="#"]:not([href="#"])').click(function() {
        if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
            if (target.length) {
                $('html, body').animate({
                    scrollTop: target.offset().top
                }, 400);
                return false;
            }
        }
    });
});


