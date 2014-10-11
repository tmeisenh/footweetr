#import "FOOTweetrFetchOperationFactory.h"
#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrFetchOperationFactory ()

@property (nonatomic) id <FOOTweetrRequestor>requestor;
@property (nonatomic) FOOBackgroundCoreDataFactory *backgroundCoreDataFactory;
@property (nonatomic) FOOTweetrRecordCoreDataAdapter *coreDataAdapter;

@end

@implementation FOOTweetrFetchOperationFactory

-(instancetype)initWithTweetrRequestor:(id<FOOTweetrRequestor>)requestor
             backgroundCoreDataFactory:(FOOBackgroundCoreDataFactory *)backgroundCoreDataFactory
                       coreDataAdapter:(FOOTweetrRecordCoreDataAdapter *)coreDataAdapter {
    
    if (self = [super init]) {
        self.requestor = requestor;
        self.backgroundCoreDataFactory = backgroundCoreDataFactory;
        self.coreDataAdapter = coreDataAdapter;
    }
    return self;
}
- (NSOperation *)createOperation:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    return [[FOOTweetrFetchOperation alloc] initWithTweetrRequestor:self.requestor
                                          backgroundCoreDataFactory:self.backgroundCoreDataFactory
                                         persistentStoreCoordinator:persistentStoreCoordinator
                                                    coreDataAdapter:self.coreDataAdapter];
}

@end
