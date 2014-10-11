#import "FOOTweetrSyncer.h"

#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrSyncer() <FOOTweetrFetchOperationDelegate>

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) FOODispatcher *dispatcher;
@property (nonatomic) FOOTweetrFetchOperationFactory *operationFactory;
@property (nonatomic) NSOperationQueue *operationQueue;
@property (nonatomic) NSNotificationCenter *notificationCenter;

@end

@implementation FOOTweetrSyncer

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [self.operationQueue setName:@"TweetrSyncer"];
    [self.operationQueue setMaxConcurrentOperationCount:1];
    
    return [self initWithManagedObjectContext:managedObjectContext
                                   dispatcher:dispatcher
                             operationFactory:operationFactory
                           notificationCenter:[NSNotificationCenter defaultCenter]
                               operationQueue:queue];
}


- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory
                          notificationCenter:(NSNotificationCenter *)notificationCenter
                              operationQueue:(NSOperationQueue *)operationQueue {
    
    if (self = [super init]) {
        self.managedObjectContext = managedObjectContext;
        self.dispatcher = dispatcher;
        self.operationFactory = operationFactory;
        self.notificationCenter = notificationCenter;
        self.operationQueue = operationQueue;
    }
    return self;
}


- (void)sync {
    FOOTweetrFetchOperation *operation = [self.operationFactory createOperation:self.managedObjectContext.persistentStoreCoordinator];
    operation.delegate = self;
    [self.operationQueue addOperation:operation];
}

/*
 WorkAround to avoid listening for notifications on nil.
 Tossing around NSManagedObjectContexts accross threads is dangerous
 but this might be safer/better than just listening on nil which
 could cause more problems down the road with complexity if other
 things would spawn off background coredata contexts as well.
 */
-(void)observeContextForChanges:(NSManagedObjectContext *)context {
    [self.notificationCenter addObserver:self
                                selector:@selector(mergeCoreData:)
                                    name:NSManagedObjectContextDidSaveNotification
                                  object:context];
}

- (void)mergeCoreData:(NSNotification *)notification {
    // avoid anything coming from our own context.
    if (![notification.object isEqual:self.managedObjectContext]) {
        /* remove observation on its originating thread */
        [self.notificationCenter removeObserver:self
                                           name:NSManagedObjectContextDidSaveNotification
                                         object:notification.object];
        /* notification occurs on background thread, merge it on main thread. */
        [self.dispatcher dispatchOnMainThreadBlock:^{
            [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}

@end
