$(document).ready(function() {
  $(".stories").on("click", ".body_div", function() {
    $(this).find('.submission_text').slideToggle();
  });
});
