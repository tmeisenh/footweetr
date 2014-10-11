#import "FOOTweetrFetchOperation.h"
#import "FOOTweetrRecord.h"

@interface FOOTweetrFetchOperation()

@property (nonatomic) id <FOOTweetrRequestor>tweetrRequestor;
@property (nonatomic) NSPersistentStoreCoordinator *sharedPersistentStoreCoordinator;
@property (nonatomic) NSManagedObjectContext *backgroundContext;
@end

@implementation FOOTweetrFetchOperation

-(instancetype)initWithTweetrRequestor:(id<FOOTweetrRequestor>)tweetrRequestor
            persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (self = [super init]) {
        self.tweetrRequestor = tweetrRequestor;
        self.sharedPersistentStoreCoordinator = persistentStoreCoordinator;
    }
    return self;
}

-(BOOL)isConcurrent {
    return NO;
}

-(void)start {
    
    if (self.isCancelled) {
        return;
    }
    
    self.backgroundContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.backgroundContext.undoManager = nil;
    self.backgroundContext.persistentStoreCoordinator = self.sharedPersistentStoreCoordinator;
    
    NSArray *records;
    if (!self.isCancelled) {
        records = [self.tweetrRequestor fetchAllTweetrRecords];
    }
    
    // for laziness our 'network' object returns the same object as our view takes.
    
    if (!self.isCancelled) {
        for (FOOTweetrRecord *record in records) {
            // convert to coredata type.
            
        }
    }
    
    NSError *error = nil;
    if ([self.backgroundContext hasChanges] && !self.isCancelled) {
        [self.backgroundContext save:&error];
    }
}

@end
