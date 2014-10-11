#import "FOOTweetrFetchOperation.h"
#import "FOOTweetrRecord.h"

@interface FOOTweetrFetchOperation()

@property (nonatomic) id <FOOTweetrRequestor>tweetrRequestor;
@property (nonatomic) FOOBackgroundCoreDataFactory *backgroundCoreDataFactory;
@property (nonatomic) FOOTweetrRecordCoreDataAdapter *adapter;
@property (nonatomic) NSPersistentStoreCoordinator *sharedPersistentStoreCoordinator;
@property (nonatomic) NSManagedObjectContext *backgroundContext;
@end

@implementation FOOTweetrFetchOperation

-(instancetype)initWithTweetrRequestor:(id<FOOTweetrRequestor>)tweetrRequestor
             backgroundCoreDataFactory:(FOOBackgroundCoreDataFactory *)backgroundCoreDataFactory
            persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (self = [super init]) {
        self.tweetrRequestor = tweetrRequestor;
        self.backgroundCoreDataFactory = backgroundCoreDataFactory;
        self.sharedPersistentStoreCoordinator = persistentStoreCoordinator;
    }
    return self;
}

-(BOOL)isAsynchronous {
    return NO;
}

-(void)main {
    
    if (self.isCancelled) {
        return;
    }
    
    self.backgroundContext = [self.backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:self.sharedPersistentStoreCoordinator];
    [self.delegate observeContextForChanges:self.backgroundContext];
    self.adapter = [self.backgroundCoreDataFactory createCoreDataAdapterForContext:self.backgroundContext];
    
    NSArray *records;
    if (!self.isCancelled) {
        records = [self.tweetrRequestor fetchAllTweetrRecords];
    }
    
    // for laziness our 'network' object returns the same object as our view takes.
    // In real code, we'd build up batch sizes to save to core data...
    if (!self.isCancelled) {
        for (FOOTweetrRecord *record in records) {
            FOOCoreDataTweetrRecord *coreDataRecord = [self.adapter convertTweetrRecordToCoreDataType:record];
            [self.backgroundContext insertObject:coreDataRecord];
        }
    }
    
    NSError *error = nil;
        
    if ([self.backgroundContext hasChanges] && !self.isCancelled) {
        [self.backgroundContext save:&error];
    }
}

@end
