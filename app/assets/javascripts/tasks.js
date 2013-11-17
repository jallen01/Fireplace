$(function(){

	$('.btn-group').button()

	$("#create_task_btn").click(function(){
		$("#new-task-modal").modal('show');
	});


	var tagIDList = []
	var timeIDList = []
	var locationIDList = []
	var dayIDList = []


	$(".tag").click(function(){
		var this_btn = $(this)
		var btn_id = this_btn.attr('id')
		var id_index = tagIDList.indexOf(btn_id)
		if(id_index != -1){
			tagIDList.splice(id_index, 1)
		}else{
			tagIDList.push(btn_id)
		}
	});


	$(".range_days").click(function(){
		var this_btn = $(this)
		var btn_id = this_btn.attr('id')
		var id_index = dayIDList.indexOf(btn_id)
		if(id_index != -1){
			dayIDList.splice(id_index, 1)
		}else{
			dayIDList.push(btn_id)
		}
	});

	$(".range_times").click(function(){
		var this_btn = $(this)
		var btn_id = this_btn.attr('id')
		var id_index = timeIDList.indexOf(btn_id)
		if(id_index != -1){
			timeIDList.splice(id_index, 1)
		}else{
			timeIDList.push(btn_id)
		}
	});

	$(".loc").click(function(){
		var this_btn = $(this)
		var btn_id = this_btn.attr('id')
		var id_index = locationIDList.indexOf(btn_id)
		if(id_index != -1){
			locationIDList.splice(id_index, 1)
		}else{
			locationIDList.push(btn_id)
		}
	});



	$(document).on("submit", "form.new_task", function(){
		//console.log(dayTruthList)
		$("#tags").val(tagIDList)
		$("#day_ranges").val(dayIDList)
		//$("#form_day_range").val(dayTruthList)
		//console.log($("#form_day_range").val())
		$("#time_ranges").val(timeIDList)
		//$("#form_time_range").val(timeTruthList)
		$("#locations").val(locationIDList)
	});


	// var coords = [];

	// function getLocation() {
	// 	if (navigator.geolocation) {
	// 		function showLocation(position) {
	// 		  var latitude = position.coords.latitude;
	// 		  var longitude = position.coords.longitude;
	// 		  coords.push(latitude)
	// 		  coords.push(longitude)
	// 		}

	// 		function errorMessage() {
	// 			alert("Location can't be found");
	// 		}

	// 		navigator.geolocation.getCurrentPosition(showLocation, errorMessage, {maximumAge:600000, timeout:5000, enableHighAccuracy: false});
	// 	} else {
	// 		console.log('sorry');
	// 	}
	// }



	// console.log('made it here!');
	// console.log(coords[0], coords[1]);

	// $.ajax({
	// 	url: "/tasks/update_session",
	// 	data: "lat=" + getLocation()[0]},
	// 	success: function() {
	// 		console.log("success!");
	// 	}

	// });
	
	/*function getGeoLocation() {
	  navigator.geolocation.getCurrentPosition(setGeoCookie, errorMsg, {enableHighAccuracy: true});
	}

	function errorMsg() {
		console.log("couldn't get location");
	}

	function setGeoCookie(position) {
	  var cookie_val = position.coords.latitude + "|" + position.coords.longitude;
	  document.cookie = "lat_lng=" + escape(cookie_val);
	}

	getGeoLocation();*/

})
