// This is a manifest file that'll be compiled into application.js,
// will include all the files listed below.
//
//= require jquery
//= require jquery_ujs
//= require lib/jquery-ui
//= require lib/jquery.ui.touch-punch
//= require lib/bootstrap
//= require lib/color-picker
//= require lib/jCarouselLite
//= require lib/bootstrap-datepicker
//= require lib/bootstrap-datepicker.de
//= require lib/bootstrap_modal
//= require lib/youtube_player
//= require lib/datepicker
//- ..
//= require i18n
//= require i18n/translations
//= require moment
//= require moment/de
//- ..
//= require helper/render_eco
//= require helper/flash_msg
//= require helper/draggable_helper
//= require helper/employments
//= require helper/modal
//= require helper/requests
//= require helper/search
//= require helper/shared
//= require helper/dependent_hide
//= require helper/ajax_help
//- ..
//= require_tree ./views
//- ..
//= require_tree ./app
//- ..



$('body').on('hidden.bs.modal', '.modal', function () {
    $(this).removeData('bs.modal');
});
$('#business-carousel').on('slid.bs.carousel', function () {
  $(".icn-link-bar .icn-link.active").removeClass("active")
  $(".icn-link-bar .icn-link[data-slide-to='" + $(this).data('bs.carousel').getActiveIndex() + "']").addClass("active")
})


$(function() {
    $('.sp-tooltip').tooltip({ placement: "top" });

    $('[rel="tooltip"]').tooltip();

    $(".shiftplan-carousel").jCarouselLite({
      circular: false,
      btnNext: ".next-carousel",
      btnPrev: ".prev-carousel",
      start: $(".shiftplan-carousel").attr("data-active")
    });

    $('#sign_up_banner').affix({
      offset: {
        top: function () {
          return (this.top = $('#front-banner').outerHeight(true) - 82 )
        }
      }
    });


});


String.prototype.repeat = function( num ) {
  return new Array( num + 1 ).join( this );
}


$(".colorPicker").colorPicker({
  onSelect: function(ui, c){
    ui.css("background", c);
    ui.prev(".color-inpt").val( c );
  }
});

// $.ajaxSetup({
//   dataType: 'script',
//   headers: { "X-CSRF-Token": $("meta[name=csrf-token]").attr("content") }
// });



// $(function() {
//   $( ".employee-btn.dragable" ).draggable({
//     appendTo: "body",
//     helper: "clone"
//   });
//   $( ".employee-dropbox" ).droppable({
//     activeClass: "ui-state-default",
//     hoverClass: "ui-state-hover",
//     accept: ":not(.ui-sortable-helper)",
//     drop: function( event, ui ) {
//       $( this ).find( ".placeholder" ).remove();
//       $( ui.draggable[0] ).appendTo( this );
//     }
//   });
// });