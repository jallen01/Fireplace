Mentor Meeting #2 - Notes
=========================

Present - Tyler, Jon, Rebecca, Michelle, Dalton, Vikas

- render multiple partials in a view
- does user need to have any locations? could they not have or not use locations at all? maybe there can be an option to not use their current location and then just ignore the location field
- confusion to users over what attributes are currently chosen
- ability to view hierarchy of tags
- need to express to user how tags work
- parent Tag with two subclasses HiddenTag and VisibleTag
- for MVP, perhaps do simple solution of just taking all the times (ORing them), all the days (ORing them), and all the locations (ORing them), and then ANDing these 3 categories; the other idea of not mixing and matching tags is more complicated and maybe we’ll implement this for the final product if we think this idea makes sense
- in design doc, break the goals/purpose up into two sections (goals into bulleted list)
- for a tag/task good idea to show user all of the times/days/locations selected (based on all the nested tags)
- cancan for security purposes
- NOT “fireplace has minimal security requirements”, say it has “simple security”
- maybe or maybe not for MVP: for a task specify due date and how many days before the due date you want to start seeing that task
- add into design doc (in features section) mention that tasks are deleted (not marked complete) when done
- option to show all items due today? mitigate user concern that they’re not being shown everything
- teamwork plan - be more specific than you need to be, then change it later if circumstances change