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
            persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
                       coreDataAdapter:(FOOTweetrRecordCoreDataAdapter *)coreaDataAdapter {

    if (self = [super init]) {
        self.tweetrRequestor = tweetrRequestor;
        self.backgroundCoreDataFactory = backgroundCoreDataFactory;
        self.sharedPersistentStoreCoordinator = persistentStoreCoordinator;
        self.adapter = coreaDataAdapter;
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
    
    self.backgroundContext = [self.backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:self.sharedPersistentStoreCoordinator];
    
    NSArray *records;
    if (!self.isCancelled) {
        records = [self.tweetrRequestor fetchAllTweetrRecords];
    }
    
    // for laziness our 'network' object returns the same object as our view takes.
    
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
