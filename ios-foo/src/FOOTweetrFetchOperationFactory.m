#import "FOOTweetrFetchOperationFactory.h"
#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrFetchOperationFactory ()

@property (nonatomic) id <FOOTweetrRequestor>requestor;
@property (nonatomic) FOOBackgroundCoreDataFactory *backgroundCoreDataFactory;

@end

@implementation FOOTweetrFetchOperationFactory

-(instancetype)initWithTweetrRequestor:(id<FOOTweetrRequestor>)requestor
             backgroundCoreDataFactory:(FOOBackgroundCoreDataFactory *)backgroundCoreDataFactory {
    
    if (self = [super init]) {
        self.requestor = requestor;
        self.backgroundCoreDataFactory = backgroundCoreDataFactory;
    }
    return self;
}
- (NSOperation *)createOperation:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    return [[FOOTweetrFetchOperation alloc] initWithTweetrRequestor:self.requestor
                                          backgroundCoreDataFactory:self.backgroundCoreDataFactory
                                         persistentStoreCoordinator:persistentStoreCoordinator];
}

@end
