Mentor Meeting #2 - Agenda
==========================

Questions
---------

+Do you have any comments on our data model?

+Do you have any comments/suggestions for our UI (based on wireframes)?

+How to combine tags (two possibilities):
	+Recursive ANDing and ORing
		+For each tag, determine the tag’s truth value by ANDing the truth values of its tags
		+For a tag that has only attributes, AND it’s attributes
		+How to combine tags and attributes for a tag that has both?
			+Overriding location/time/day information of inner-tags appropriately based on which attributes are selected
			+No override, just ANDing
	+Overall ANDing and ORing
		+For a particular tag, OR all of the locations encompassed in that tag, OR all of the times, and OR all of the days, and then AND those 3 values together

+When creating a task, if you select attributes and tags, should attributes override tags?

+When creating a task or tag, should we show the user all the raw location/day/time information compiled from all the tags and attributes chosen?

+How are we going to incorporate the concept of due dates?