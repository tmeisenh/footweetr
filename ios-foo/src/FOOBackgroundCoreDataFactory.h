#import "FOOTweetrRecordCoreDataAdapter.h"

@interface FOOBackgroundCoreDataFactory : NSObject

/// Creates a NSManagedObjectContext specifically for background processing
- (NSManagedObjectContext *)createManagedObjectContextForPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

- (FOOTweetrRecordCoreDataAdapter *)createCoreDataAdapterForContext:(NSManagedObjectContext *)context;

@end
