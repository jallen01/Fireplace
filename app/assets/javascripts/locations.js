var counter = 0;
$('div').find('#add-address').on('click', function() {
    counter++;
    if (counter % 2 == 0) {
        $(this).text('Hide Address');
    } else {
        $(this).text("Enter Address");
    }
    
    $('.loc').toggle();

    $('.loc').find('input').each(function() {
        $(this).val('');
    })
});
