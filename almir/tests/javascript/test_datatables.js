$(document).ready(function(){
    module("type_hidden_numeric_data.js");

    test("guess type of column", function() {
        expect(4);
        equal(detect_numeric_data('data-numeric="0.1"'), "datanumeric");
        equal(detect_numeric_data('data-numeric=""'), "datanumeric");
        equal(detect_numeric_data('data-numeric'), null);
        equal(detect_numeric_data('/'), 'datanumeric');
    });
    
    test("column sorting", function() {
      expect(9);
      equal(sort_data_numeric("data-numeric='0'", "data-numeric='0.5'"), -1);
      equal(sort_data_numeric("data-numeric=0.5", "data-numeric=0"), 1);
      equal(sort_data_numeric("data-numeric=0", "data-numeric=0"), 0);
      equal(sort_data_numeric("data-numeric=-100", "data-numeric=0"), -1);
      equal(sort_data_numeric("data-numeric=-100", "data-numeric=500"), -1);
      equal(sort_data_numeric("data-numeric=499.99", 'data-numeric="500"'), -1);
      equal(sort_data_numeric("data-numeric=499.99", "data-numeric=499.99"), 0);
      equal(sort_data_numeric("/", "data-numeric=499.99"), -1);
      equal(sort_data_numeric("data-numeric=499.99", '/'), 1);
    });

    module("type_filesize.js");

    test("guess type of column", function() {
        expect(7);
        equal(detect_file_size('100kB'), "filesize");
        equal(detect_file_size('100.5 GB'), "filesize");
        equal(detect_file_size('95 TB'), "filesize");
        equal(detect_file_size('95.1 B'), "filesize");
        equal(detect_file_size('95.1 MB'), "filesize");

        equal(detect_file_size('95.1 k'), null);
        equal(detect_file_size('95.1 kb'), null);
    });

    test("column sorting", function() {
        expect(8);
        equal(sort_file_size("95.6 kB", "96 kB"), -1);
        equal(sort_file_size("95.6 kB", "96.5 kB"), -1);
        equal(sort_file_size("95.6 kB", "20 MB"), -1);
        equal(sort_file_size("95.6 kB", "20.0 MB"), -1);
        equal(sort_file_size("95.6 kB", "96 B"), 1);
        equal(sort_file_size("0 B", "96 B"), -1);
        equal(sort_file_size("1 B", "0 B"), 1);
        equal(sort_file_size("1 kB", "1024 B"), 0);
    });
});
