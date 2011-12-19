$(function () {
  var linkable_rows = $('.content tr[data-link]');

  // make rows clikable by provided link
  linkable_rows.click(function (e) {
    window.location = $(e.target).parent('tr').attr('data-link');
  });
});
