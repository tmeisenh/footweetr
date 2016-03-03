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
            FOOCoreDataTweetrRecord *coreDataRecord = [self.adapter convertTweetrRecordToCoreDataType:record user:[self getUser]];
            int times = [self randomNumber];
            NSMutableString *randomTitle = [[NSMutableString alloc] init];
            for (int i = 0; i < times; i++) {
                [randomTitle appendString:[self randomChar]];
            }
            coreDataRecord.title = randomTitle;
            [self.backgroundContext insertObject:coreDataRecord];
        }
    }
    
    NSError *error = nil;
        
    if ([self.backgroundContext hasChanges] && !self.isCancelled) {
        [self.backgroundContext save:&error];
    }
}

- (int)randomNumber {
    return arc4random() % 5;
}


- (NSString *)randomChar {
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyz";
    NSMutableString *s = [NSMutableString stringWithCapacity:20];
    for (NSUInteger i = 0U; i < 20; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return s;
}

// always gets the lowest user
- (FOOCoreDataUserRecord *)getUser {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([FOOCoreDataUserRecord class])];
    
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [request setSortDescriptors:@[nameSorter]];
    NSArray *allUsers = [self.backgroundContext executeFetchRequest:request
                                                              error:nil];

    
    NSSortDescriptor *lowestTweetrSorter = [NSSortDescriptor sortDescriptorWithKey:@"tweetrs.@count" ascending:YES];

    FOOCoreDataUserRecord *user = [[allUsers sortedArrayUsingDescriptors:@[lowestTweetrSorter]] firstObject];
    return user;
}

@end
