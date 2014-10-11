@interface FOOBackgroundCoreDataFactory : NSObject

/// Creates a NSManagedObjectContext specifically for background processing
- (NSManagedObjectContext *)createManagedObjectContextForPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;


@end
