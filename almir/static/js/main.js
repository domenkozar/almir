$(function () {
  var linkable_rows = $('tr[data-link]');

  // make rows clikable by provided link
  linkable_rows.click(function (e) {
    window.location = $(e.target).parent('tr').attr('data-link');
  });
});

// console.pt
$(function () {
  function send_command (e) {
      var console = $('#console'),
          command = $('#command'),
          bconsole_text = command.text();

      if (!(e.which == 1 || e.which == 13)) {
        return null;
      }

      $.ajax({
        url: bconsole_url,
        dataType: 'json',
        type: 'POST',
        data: {
          bconsole_command: bconsole_text
        },
        success: function (data, textStatus, jqXHR) {
          console.append('<span class="stdout">' + data.stdout + '</span>');
          console.append('<span class="stderr">'+ data.stderr + '</span>');
          console.scrollTop(
            console[0].scrollHeight - console.height()
          );
        },
        error: function (jqXHR, textStatus, errorThrown) {
          console.log(jqXHR, textStatus);
        }
      });
  }

  $('#command_btn').bind('click', send_command);
  $('#command').bind('keyup', send_command);
});
