//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require modernizr.min
//= require responsive-nav
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

//Slider for movies show
(function ( $ ) {

    $.fn.slider = function( ) {

      var items = $(this).find('li'),
        current = 0,
        itemsCount = items.length,
        navNext = $(this).find( '.next' ),
        navPrev = $(this).find( '.prev' ),
        isAnimating = false;

      function init() {
        navNext.on( 'click', function( ev ) { ev.preventDefault(); navigate( 'next' ); } );
        navPrev.on( 'click', function( ev ) { ev.preventDefault(); navigate( 'prev' ); } );
      }

      function navigate( dir ) {
        var cntAnims = 0;

        var currentItem = items[ current ];

        if( dir === 'next' ) {
          current = current < itemsCount - 1 ? current + 1 : 0;
        }
        else if( dir === 'prev' ) {
          current = current > 0 ? current - 1 : itemsCount - 1;
        }

        var nextItem = items[ current ];

        $(currentItem).transition({ scale: '1.2', opacity: '0' }, 700, 'cubic-bezier(.68,.05,.59,1)', function() {
          $(this).removeClass('current');
          $(this).removeAttr('style');
          $(nextItem).addClass('current');
        });

        $(nextItem).transition({ opacity: '1' }, 700, 'cubic-bezier(.68,.05,.59,1)', function() {
          $(this).addClass('current');
        });
      }

      init();

    };

}( jQuery ));
