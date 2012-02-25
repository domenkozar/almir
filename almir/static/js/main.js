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
    trigger: 'manual'
  })

  setInterval(function () {
    var command = $('#command').val(),
        title;

    if (!command) {
       $('#command').popover('hide').data('last-command', "");
       return
    }

    // only change popup if we have new command
    if ($('#command').data('last-command') == command) { return; }

  
    title = $('#command_help tr').filter(function () {
      var current_command = $(this).find('td:first').text(),
          rgp = new RegExp('^' + command + '$');
      return rgp.test(current_command)
    }).attr('data-content');

    if (title) {
        $('#command').attr('data-content', title)
          .attr('data-original-title', "Parameters for " + command)
          .popover('show').data('last-command', command);
    }
  }, 100);

  // TODO: we will have to reimplement this with comet technology (gevent), does not work currently
  $('#command_btn').bind('click', send_command);
  $('#command').bind('keyup', send_command);
});
