$(function(){

	$('.btn-group').button();

	$("#create_task_btn").click(function(){
		$("#new-task-modal").modal('show');
	});

	$('#form-control').change(function() {
	    var val = $("#form-control option:selected").text();
	    alert(val);
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

	$(document).on("click", "#time-input button", function (event) {
		var button = $(event.target);
		var index = parseInt(button.attr("id").split("-")[1]);
		var form_time_range = JSON.parse($("#form_time_range").val());

		if (button.hasClass("btn-default")) {
			// Select button
			button.removeClass("btn-default");
			button.addClass("btn-info");
			form_time_range[index][0] = true;
		} else {
			// Unselect button
			button.removeClass("btn-info");
			button.addClass("btn-default");
			form_time_range[index][0] = false;
		}
		$("#form_time_range").val(JSON.stringify(form_time_range));
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
