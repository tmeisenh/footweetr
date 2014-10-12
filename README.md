footweetr
=========

Disclaimer: This was done test-driven but in reality this is more or less a
big spike that has tests around it.  It's not polished and I ran into
issues with the xcode 6 upgrade.

This is a demonstration iOS app for multi-threaded core data that doesn't throw
everything into a UIViewController, has tests, and encapsulates core
data as strictly a database layer.

Things left to learn
* how many edge cases around canceling the syncer and its operation?
* I wanted to avoid observing on object:nil for context save events in
  the syncer/operation is my approach correct?  Is there a better way
  that also avoids listining on object:nil?
* Is there an acceptable way to let a FetchResultsController drive my
  TableView without coupling my datastore to my view?
