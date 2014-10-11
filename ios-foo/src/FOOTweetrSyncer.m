#import "FOOTweetrSyncer.h"
#import "FOOCoreDataContextMerger.h"
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
        
    }
    return self;
}


- (void)sync {
    //@todo add logic to prevent multiple syncs in progress
    FOOCoreDataContextMerger *merger = [[FOOCoreDataContextMerger alloc] init];
    [merger setMainContext:self.managedObjectContext];
    
    FOOTweetrFetchOperation *operation = [self.operationFactory createOperation:self.managedObjectContext.persistentStoreCoordinator];
    [operation setMerger:merger];
    
    [self.operationQueue addOperation: operation];
}




@end
