var detect_file_size = function (sData) {
    if (/[0-9\.]+\s*[kMGT]?B/.test(sData)) {
        return 'filesize';
    } else {
        return null;
    }
};

var sort_file_size = function (a, b) {
    var a_re = a.match(/([0-9\.]+)\s*([kMGT]?B)/),
        b_re = b.match(/([0-9\.]+)\s*([kMGT]?B)/),
        byte_conversion = {
            'B': 1,
            'kB': 1024,
            'MB': 1024*1024,
            'GB': 1024*1024*1024,
            'TB': 1024*1024*1024*1024
        },
        x,
        y;

    x = parseFloat(a_re[1]) * byte_conversion[a_re[2]];
    y = parseFloat(b_re[1]) * byte_conversion[b_re[2]];
     
    return ((x < y) ? -1 : ((x > y) ?  1 : 0));
};

jQuery.fn.dataTableExt.aTypes.unshift(detect_file_size);

jQuery.fn.dataTableExt.oSort['filesize-asc']  = function(a, b) {
    return sort_file_size(a, b);
};
 
jQuery.fn.dataTableExt.oSort['filesize-desc'] = function(a,b) {
    return sort_file_size(a, b) * -1;
};
