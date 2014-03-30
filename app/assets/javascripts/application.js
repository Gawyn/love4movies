//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require modernizr.min
//= require jquery.transit

//Calc poster ratios
function posterRatios() {
  var width = $("[data-ratio]").width(),
      height = 0;

  $("[data-ratio]").each(function(i, o) {
      height = Math.floor(Number($(o).data("ratio")) * width);
      $(o).height(height);
  });
}

// Triggers
$(document).ready(posterRatios);
$(window).on('resize',posterRatios);
$(document).on('page:load', posterRatios);