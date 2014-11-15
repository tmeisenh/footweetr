#import "FOOTweetrSyncer.h"

#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrSyncer() <FOOTweetrFetchOperationDelegate, FOORepeatingTimerDelegate>

@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) FOODispatcher *dispatcher;
@property (nonatomic) FOOTweetrFetchOperationFactory *operationFactory;
@property (nonatomic) NSOperationQueue *operationQueue;
@property (nonatomic) NSNotificationCenter *notificationCenter;
@property (nonatomic) FOORepeatingTimer *repeatingTimer;
@end

@implementation FOOTweetrSyncer

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory
                              repeatingTimer:(FOORepeatingTimer *)repeatingTimer {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [self.operationQueue setName:@"TweetrSyncer"];
    [self.operationQueue setMaxConcurrentOperationCount:1];
    
    return [self initWithManagedObjectContext:managedObjectContext
                                   dispatcher:dispatcher
                             operationFactory:operationFactory
                           notificationCenter:[NSNotificationCenter defaultCenter]
                               operationQueue:queue
                               repeatingTimer:repeatingTimer];
}


- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory
                          notificationCenter:(NSNotificationCenter *)notificationCenter
                              operationQueue:(NSOperationQueue *)operationQueue
                              repeatingTimer:(FOORepeatingTimer *)repeatingTimer {
    
    if (self = [super init]) {
        self.managedObjectContext = managedObjectContext;
        self.dispatcher = dispatcher;
        self.operationFactory = operationFactory;
        self.notificationCenter = notificationCenter;
        self.operationQueue = operationQueue;
        self.repeatingTimer = repeatingTimer;
        self.repeatingTimer.delegate = self;
    }
    return self;
}


- (void)sync {
    [self.repeatingTimer startTimer];
}

- (void)scheduleNewSyncJobs {
    if ([self areOperationsRunning]) {
        FOOTweetrFetchOperation *operation = [self.operationFactory createOperation:self.managedObjectContext.persistentStoreCoordinator];
        operation.delegate = self;
        [self.operationQueue addOperation:operation];
    }
}

- (void)timerFired {
    [self scheduleNewSyncJobs];
}

- (BOOL)areOperationsRunning {
    return [self.operationQueue operationCount] <= 0;
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
