Programming Questions
=====================

A place to put code demonstrating programming questions I have.

### Unpopulated associations in ember-data

In the directory `association-null` I have code demonstrating a problem with unpopulated DS.Models that have associations. The problem is that the assoicated object cannot be used in isolation, it must be used relative to the root object. This is because the association will return null until `load()` has completed. See my [question][q] on StackOverflow.

[q]: http://stackoverflow.com/questions/11838423
