Mentor Meeting #1 - Agenda
==========================

Items
-----
    + Introduce ourselves
        + names should be enough
    + Overview of our app idea, Fireplace
        + todo list that doesn’t overwhelm user with too many tasks
        + only shows relevant tasks, unless specified otherwise
        + Concepts
            + Task
            + Filter
            + Classification
    + Design questions
        + Nature of Classifications and possible options
            + single vs multiple Classifications per task (category vs tag)
            + possible filters: times of day, days of week, location, important, long, due date
            + filter rules
            + which filters take precedence if multiple selected? or will no conflicts arise if we just union all applied filters, and is that the most intuitive way?
        + Balance between simplicity and user freedom
            + favor quick and simple user interaction over complicated filters
            + small amount of user input when listing tasks to select location (would override GPS) and to toggle showing tasks deemed long/important
        + Data model
            + modeling filters
    + Implementation questions
        + any suggestions for API/gem to help retrieve current location
        + if not, any strategies for finding one
    + Ask about critique due on Sunday
        + good strategies
        + common issues that we should avoid
