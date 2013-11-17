$(function(){
	$("#create_task_btn").click(function(){
		$("#new-task-modal").show();
	});

	var dayTruthList = [false, false, false, false, false, false, false]

	$("#sun").click(function(){
		dayTruthList[0] = !truthList[0]
	});
	$("#mon").click(function(){
		dayTruthList[1] = !truthList[1]
	});
	$("#tues").click(function(){
		dayTruthList[2] = !truthList[2]
	});
	$("#wed").click(function(){
		dayTruthList[3] = !truthList[3]
	});
	$("#thurs").click(function(){
		dayTruthList[4] = !truthList[4]
	});
	$("#fri").click(function(){
		dayTruthList[5] = !truthList[5]
	});
	$("#sat").click(function(){
		dayTruthList[6] = !truthList[6]
	});

	var getDayTruthList = function(){
		return dayTruthList
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



	document.on("submit", "form_custom", function(){
		$("#tags").val(tagIDList)
	});

	document.on("submit", "form_custom", function(){
		$("#day_ranges").val(dayIDList)
	});

	document.on("submit", "form_custom", function(){
		$("#form_day_range").val(dayTruthList)
	});

	document.on("submit", "form_custom", function(){
		$("#time_ranges").val(timeIDList)
	});

	document.on("submit", "form_custom", function(){
		$("#form_time_range").val(timeTruthList)
	});

	document.on("submit", "form_custom", function(){
		$("#locations").val(locationIDList)
	});


});