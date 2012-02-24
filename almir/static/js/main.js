$(function () {
  // global
  var linkable_rows = $('tr[data-link]');

  // make datatables rows clickable by provided link
  linkable_rows.click(function (e) {
    window.location = $(e.target).parent('tr').attr('data-link');
  });

  // console.pt
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

  $('#command_help tr').popover();
  $('#command').popover({
    placement: 'left',
    trigger: 'manual',
  });

  $('#command').change(function (e) {
    var title = $('#command_help tr').filter(function () {
        var rgp = new RegExp($('#command').val())
        return rgp.test($(this).text())
    }).attr('data-original-title');
    if (title) {
      $(this).attr('data-original-title', title);
      $(this).popover('show');
    }
  });

  // TODO: we will have to reimplement this with comet technology (gevent), does not work currently
  $('#command_btn').bind('click', send_command);
  $('#command').bind('keyup', send_command);
});
