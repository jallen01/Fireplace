Fireplace
=========
*the to-do list that doesn't burn you out*


**Sit by the Fireplace and relax:**
http://fireplace-todo.herokuapp.com/


Fireplace is a to-do list app that automatically shows only relevant tasks at any given time, so that users see fewer and more pertinent tasks.
Fireplace allows users to add metadata (like times, days, and locations) to each task they create, and Fireplace uses this metadata to show each task only when the user might want to see it.
Fireplace also allows users to create tags which they can attach to tasks for quick and easy metadata input, streamlining the process of creating tasks that fit into common categories.
Additional task viewing options Fireplace can take into account include importance, due date, and looking ahead to the next day or week.


General:

- manual location input: To utilize the filtering of tasks based on location metadata, click the `Change Context` button below the Fireplace header on the task list page. For now, rather than an override of the automatic location, this is the only way of specifying location.

- future iterations:
	- automatic location pulling, still allow manual override
	- deadline/days notice, only show task when user context date is within `days_notice` days of `deadline` if specified in task metadata
	- improve layout/ui/graphic design

For 6.170 staff:

- non-deterministic tests: Google Geocoder has limits on how many times an app can make requests within different time frames. When all our tests run, since they happen in such quick succession they sometimes go over Google Geocoder's 4 req/sec limit. This does not happen every time, and when it does, the error is very clear, and only triggers on 1 or 2 of the 50+ tests any given run, so it is not a big deal because you can simply run the tests again a few times to see that everything works. But just a heads up that if any tests fail it is probably because of this Geocoder limit and the nature of the many small tests.