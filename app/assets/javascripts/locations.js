/* Code from https://github.com/sgruhier/jquery-addresspicker */
    $(function() {
                var addresspickerMap = $( "#address_string" ).addresspicker({
                        regionBias: "fr",
                        reverseGeocode: true, 
      updateCallback: showCallback,
                  elements: {
                    map:      "#map",
                    lat:      "#lat",
                    lng:      "#lng",
                    street_number: '#street_number',
                    route: '#route',
                    locality: '#locality',
                    administrative_area_level_2: '#administrative_area_level_2',
                    administrative_area_level_1: '#administrative_area_level_1',
                    country:  '#country',
                    postal_code: '#postal_code',
        type:    '#type'
                  }
                });

                //var gmarker = addresspickerMap.addresspicker( "marker");
                //gmarker.setVisible(true);
                addresspickerMap.addresspicker( "updatePosition");

    $('#reverseGeocode').change(function(){
      $("#address_string").addresspicker("option", "reverseGeocode", ($(this).val() === 'true'));
    });

    function showCallback(geocodeResult, parsedGeocodeResult){
      $('#callback_result').text(JSON.stringify(parsedGeocodeResult, null, 4));
    }

        });