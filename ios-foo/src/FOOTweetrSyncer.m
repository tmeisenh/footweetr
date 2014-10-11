#import "FOOTweetrSyncer.h"

#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrSyncer()

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) id <FOOTweetrRequestor>tweetrRequestor;
@property (nonatomic) FOODispatcher *dispatcher;
@property (nonatomic) NSOperationQueue *operationQueue;

@end

@implementation FOOTweetrSyncer

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                             tweetrRequestor:(id<FOOTweetrRequestor>)tweetrRequestor
                                  dispatcher:(FOODispatcher *)dispatcher {
    
    if (self = [super init]) {
        self.managedObjectContext = managedObjectContext;
        self.tweetrRequestor = tweetrRequestor;
        self.dispatcher = dispatcher;
        self.operationQueue = [[NSOperationQueue alloc] init];
        [self.operationQueue setName:@"TweetrSyncer"];
        [self.operationQueue setMaxConcurrentOperationCount:1];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(mergeCoreData:)
                                                     name:NSManagedObjectContextDidSaveNotification
                                                   object:nil];
        
    }
    return self;
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:nil];
}

- (void)sync {
    //@todo add logic to prevent multiple syncs in progress
    [self.operationQueue addOperation:[self createOperation:self.managedObjectContext.persistentStoreCoordinator]];
}

- (FOOTweetrFetchOperation *)createOperation:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    return [[FOOTweetrFetchOperation alloc] initWithTweetrRequestor:self.tweetrRequestor
                                         persistentStoreCoordinator:self.managedObjectContext.persistentStoreCoordinator];
}


- (void)mergeCoreData:(NSNotification *)notification {
    /* notification occurs on background thread, merge it on main thread. */
    [self.dispatcher dispatchOnMainThreadBlock:^{
        [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
    }];
}

@end