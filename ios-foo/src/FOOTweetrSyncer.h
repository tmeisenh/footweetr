#import "FOOTweetrRequestor.h"
#import "FOODispatcher.h"
#import "FOOTweetrFetchOperationFactory.h"
#import "FOORepeatingTimer.h"

@interface FOOTweetrSyncer : NSObject

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory
                              repeatingTimer:(FOORepeatingTimer *)repeatingTimer;

- (void)sync;



/*
 How core data threaded works.
 
 Warnings - NSManagedObjectContext are "attached" to their creation thread.  Do not cross the threads/streams.
 
 1. You have a regular "main" context that is attached to the main thread and is of the type NSMainQueueConcurrencyType.
 
 2. You then init your NSOperation with the same NSPersistentStoreCoordinator as your main/regular coredata context.
 3. Your operation inside start or main (NEVER in init) then creates its own context with the type NSPrivateQueueConcurrencyType and uses the same NSPersistentStoreCoordinator.
 
 4. The owner of the NSOperationQueue then needs to observe NSNotificationCenter  for NSManagedObjectContextDidSaveNotification events.
 When he gets this event he simply calls mergeChangesFromContextDidSaveNotification:notification on his coredata context being careful to do this merge on the **main** thread.
 
 Where this syncer adds some complexity is that the syncer and the operation are **intentionally** coupled together somewhat.  The operation takes a delegate for the purpose
 of reporting which coredata context needs to be observed for changes.  Then when the merge notification is handled the context is no longer observed.
 
 This isn't ideal but given that 1) context merges only work by using NSNotification and 2) it's really bad to observe on object:nil this workaround isn't too horrible.
 It does introduce risk because we have to ensure nothing is ever invoked on the background NSManagedObjectContext and that things occur on the right threads.
 
 */
@end
