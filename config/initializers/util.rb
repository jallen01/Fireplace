module Util
	def self.process_days(day_list)
		true_false_list = Array.new
		if day_list.index("Sunday") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if day_list.index("Monday") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if day_list.index("Tuesday") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if day_list.index("Wednesday") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if day_list.index("Thursday") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if day_list.index("Friday") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if day_list.index("Saturday") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		true_false_list
	end

	def self.process_times(time_list)
		true_false_list = Array.new
		if time_list.index("12am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("1am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("2am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("3am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("4am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("5am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("6am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("7am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("8am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("9am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("10am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("11am") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end

		if time_list.index("12pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("1pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("2pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("3pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("4pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("5pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("6pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("7pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("8pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("9pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("10pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		if time_list.index("11pm") != nil
			true_false_list.push(true)
		else
			true_false_list.push(false)
		end
		
		true_false_list
	end
end