var detect_numeric_data = function (sData) {
    // if column has only /, just mark it as datanumeric
    if (/(data-numeric=|^\s*\/\s*$)/.test(sData)) {
        return 'datanumeric';
    } else {
        return null;
    }
};

var sort_data_numeric = function (a, b) {
    if (a === '/') {
        return -1;
    } 
    if (b === '/') {
        return 1;
    }
    var x = a.match(/data-numeric=["']?(-?[0-9\.]+)/)[1];
    var y = b.match(/data-numeric=["']?(-?[0-9\.]+)/)[1];
    x = parseFloat(x);
    y = parseFloat(y);
    return ((x < y) ? -1 : ((x > y) ?  1 : 0));
};

jQuery.fn.dataTableExt.aTypes.unshift(detect_numeric_data);

jQuery.fn.dataTableExt.oSort['datanumeric-asc'] = function(a, b) {
    return sort_data_numeric(a, b) * -1;
};
 
jQuery.fn.dataTableExt.oSort['datanumeric-desc'] = function(a, b) {
    return sort_data_numeric(a, b);
};
