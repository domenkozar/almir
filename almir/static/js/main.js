function send_command (e, force_command) {
    var $console = $('#console'),
        $command = $('#command'),
        lines,
        bconsole_text = $command.val();

    if (e.which == 27) {
        $command.val('');
        return null;
    }

    if (!(e.which == 1 || e.which == 13)) {
        return null;
    }
    
    if (force_command !== true && !bconsole_text) {
        return null;
    }
    // clear command line to mimic console
    // TODO: does not work since typeahead will repopulate it
    $command.val('');

    $.ajax({
      url: '/console/input/',
      dataType: 'json',
      type: 'POST',
      data: {
        bconsole_command: bconsole_text
      },
      success: function (data, textStatus, jqXHR) {
        console.log(data.commands);
        if (data.commands) {
            $.each(data.commands, function(index, value) {
                // prettyfy first line, which is the command
                lines = value.split('<br />');
                lines[0] = '<strong>&gt;&gt;&gt; ' + lines[0] + '</strong>';
                value = lines.join('<br />');
                $console.append($('<pre>' + value + '</pre'));
            });

            // scroll nicely to the bottom of text
            $console.animate({scrollTop: $console.prop("scrollHeight") - $console.height() }, 300);
        }
      },
      error: function (jqXHR, textStatus, errorThrown) {
        alert(textStatus);
      }
    });
}

$(function () {
    /* make datatables rows clickable by provided link */
    $('tr[data-link]').click(function (e) {
       window.location = $(e.target).parents('tr').data('link');
    });

    $('.datatables').each(function () {
        var $this = $(this),
            /* datatables initialisation: http://datatables.net/usage/options */
            options = {
              "sDom": "<'row-fluid'<'span5'l><'span7'fT>r>t<'row-fluid'<'span6'i><'span6'p>>",
              "sPaginationType": "bootstrap",
              "oLanguage": {
                  "sLengthMenu": "_MENU_ per page"
              },
              "oTableTools": {
                  sSwfPath: tabletools_swf,
                  aButtons: ["copy", "xls", "pdf", "print"]
              },
              "iDisplayLength": 50,
           };

        if ($.inArray($this.prevAll('h2').attr('id'), ['last_jobs', 'upcoming_jobs', 'running_jobs']) != -1) {
           options.sDom = "<'row-fluid'<'span12'fT>r>t<'row-fluid'>";
        }
        if ($this.prevAll('h2').attr('id') == "command_help") {
           options.sDom = "<'row-fluid'<'span12'f>r>t<'row-fluid'>";
           options.iDisplayLength = 200;
        }

        $this.find('thead th').each(function (index) {
           if ($.inArray($(this).text(), ['Scheduled', 'Started']) != -1) {
              options.aaSorting = [[index, "asc"]];
           }
           if ($.inArray($(this).text(), ['Time', 'Last written']) != -1) {
              options.aaSorting = [[index, "desc"]];
           }
        }); 

        $this.dataTable(options);
    });
    // apply twitter.bootstrap markup on tabletools
    $('.DTTT_button').addClass('btn');

    // -- console.pt
    if ($('#console').length == 1) {
        // calculate height of console
        var window_height = $(window).height(),
            console_offset = $('#console').offset().top,
            command_height = $('#command').parents('.row-fluid').height() + 100,
            console_height = window_height - console_offset - command_height;
        $('#console').height(console_height);

        // enable popovers
        $('#command_help tr').popover();
        $('#command').popover({
            placement: 'left',
            trigger: 'manual'
        })

        // every 100ms check command input and display help if apropriate
        setInterval(function () {
            var command = $('#command').val(),
                title;

            // when there is no input, hide popover
            if (!command) {
                 $('#command').popover('hide').data('last-command', "");
                 return
            }

            // only change popup if we have new command
            if ($('#command').data('last-command') == command) {
                return;
            }

            // match command title to list of help commands
            title = $('#command_help tr').filter(function () {
                var current_command = $(this).find('td:first').text(),
                    rgp = new RegExp('^' + command + '$');
                return rgp.test(current_command)
            }).attr('data-content');

            // if we have a match, display popover
            if (title) {
                $('#command').attr('data-content', title)
                    .attr('data-original-title', "Parameters for " + command)
                    .popover('show').data('last-command', command);
              }
        }, 100);

        $('#command-btn').bind('click', send_command);
        $('#command').bind('keyup', send_command);

        // connect to director right away
        send_command({which: 1}, true);
    }

   // TODO: forms
   function submitForm () {
    console.log('submitted form');
    $('form').submit();
   }

   $(function () {
     deform.load();
     $('form')
       .data('timeout', null)
       .keyup(function(){
         clearTimeout($(this).data('timeout'));
         jQuery(this).data('timeout', setTimeout(submitForm, submit_delay_miliseconds));
       });
     });
});
