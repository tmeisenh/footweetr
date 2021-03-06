#import "FOOBackgroundCoreDataFactory.h"

@implementation FOOBackgroundCoreDataFactory

-(NSManagedObjectContext *)createManagedObjectContextForPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.undoManager = nil;
    context.persistentStoreCoordinator = persistentStoreCoordinator;
    
    return context;
}

-(FOOTweetrRecordCoreDataAdapter *)createCoreDataAdapterForContext:(NSManagedObjectContext *)context {
    FOOTweetrRecordCoreDataAdapter *adapter = [[FOOTweetrRecordCoreDataAdapter alloc] initWithManagedObjectContext:context];
    
    return adapter;
}

@end
