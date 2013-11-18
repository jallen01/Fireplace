$(function(){

	$('.btn-group').button();

	$("#create_task_btn").click(function(){
		$("#new-task-modal").modal('show');
	});


	var dayTruthList = [false, false, false, false, false, false, false]

	$("#sun").click(function(){
		dayTruthList[0] = !dayTruthList[0];
		console.log("sun");
	});
	$("#mon").click(function(){
		dayTruthList[1] = !dayTruthList[1];
		console.log("mon");
	});
	$("#tues").click(function(){
		dayTruthList[2] = !dayTruthList[2];
		console.log("tues");
	});
	$("#wed").click(function(){
		dayTruthList[3] = !dayTruthList[3];
		console.log("wed");
	});
	$("#thurs").click(function(){
		dayTruthList[4] = !dayTruthList[4];
		console.log("thurs");
	});
	$("#fri").click(function(){
		dayTruthList[5] = !dayTruthList[5];
		console.log("fri");
	});
	$("#sat").click(function(){
		dayTruthList[6] = !dayTruthList[6];
		console.log("sat");
	});

	var getDayTruthList = function(){
		return dayTruthList;
	};



	var timeTruthList = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]

	$("#time_12am").click(function(){
		timeTruthList[0] = !timeTruthList[0]
	});
	$("#time_1am").click(function(){
		timeTruthList[1] = !timeTruthList[1]
	});
	$("#time_2am").click(function(){
		timeTruthList[2] = !timeTruthList[2]
	});
	$("#time_3am").click(function(){
		timeTruthList[3] = !timeTruthList[3]
	});
	$("#time_4am").click(function(){
		timeTruthList[4] = !timeTruthList[4]
	});
	$("#time_5am").click(function(){
		timeTruthList[5] = !timeTruthList[5]
	});
	$("#time_6am").click(function(){
		timeTruthList[6] = !timeTruthList[6]
	});
	$("#time_7am").click(function(){
		timeTruthList[7] = !timeTruthList[7]
	});
	$("#time_8am").click(function(){
		timeTruthList[8] = !timeTruthList[8]
	});
	$("#time_9am").click(function(){
		timeTruthList[9] = !timeTruthList[9]
	});
	$("#time_10am").click(function(){
		timeTruthList[10] = !timeTruthList[10]
	});
	$("#time_11am").click(function(){
		timeTruthList[11] = !timeTruthList[11]
	});
	$("#time_12pm").click(function(){
		timeTruthList[12] = !timeTruthList[12]
	});
	$("#time_1pm").click(function(){
		timeTruthList[13] = !timeTruthList[13]
	});
	$("#time_2pm").click(function(){
		timeTruthList[14] = !timeTruthList[14]
	});
	$("#time_3pm").click(function(){
		timeTruthList[15] = !timeTruthList[15]
	});
	$("#time_4pm").click(function(){
		timeTruthList[16] = !timeTruthList[16]
	});
	$("#time_5pm").click(function(){
		timeTruthList[17] = !timeTruthList[17]
	});
	$("#time_6pm").click(function(){
		timeTruthList[18] = !timeTruthList[18]
	});
	$("#time_7pm").click(function(){
		timeTruthList[19] = !timeTruthList[19]
	});
	$("#time_8pm").click(function(){
		timeTruthList[20] = !timeTruthList[20]
	});
	$("#time_9pm").click(function(){
		timeTruthList[21] = !timeTruthList[21]
	});
	$("#time_10pm").click(function(){
		timeTruthList[22] = !timeTruthList[22]
	});
	$("#time_11pm").click(function(){
		timeTruthList[23] = !timeTruthList[23]
	});

	var getTimeTruthList = function(){
		return timeTruthList
	};

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
