#import "FOOTweetrSyncer.h"

#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrSyncer()

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
    
    return [self initWithManagedObjectContext:managedObjectContext
                                   dispatcher:dispatcher
                             operationFactory:operationFactory
                           notificationCenter:[NSNotificationCenter defaultCenter]];
}


- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory
                          notificationCenter:(NSNotificationCenter *)notificationCenter {
    
    if (self = [super init]) {
        self.managedObjectContext = managedObjectContext;
        self.dispatcher = dispatcher;
        self.operationFactory = operationFactory;
        self.operationQueue = [[NSOperationQueue alloc] init];
        [self.operationQueue setName:@"TweetrSyncer"];
        [self.operationQueue setMaxConcurrentOperationCount:1];
        self.notificationCenter = notificationCenter;
        
        [self.notificationCenter addObserver:self
                                    selector:@selector(mergeCoreData:)
                                        name:NSManagedObjectContextDidSaveNotification
                                      object:nil];
        
    }
    return self;
}

-(void)dealloc {
    [self.notificationCenter removeObserver:self
                                       name:NSManagedObjectContextDidSaveNotification
                                     object:nil];
}

- (void)sync {
    //@todo add logic to prevent multiple syncs in progress
    NSOperation *operation = [self.operationFactory createOperation:self.managedObjectContext.persistentStoreCoordinator];
    
    [self.operationQueue addOperation:operation];
}



- (void)mergeCoreData:(NSNotification *)notification {
    // avoid anything coming from our own context.
    if (![notification.object isEqual:self.managedObjectContext]) {
        /* notification occurs on background thread, merge it on main thread. */
        [self.dispatcher dispatchOnMainThreadBlock:^{
            [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
        }];
    }
}

@end
