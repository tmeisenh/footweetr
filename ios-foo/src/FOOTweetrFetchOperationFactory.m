#import "FOOTweetrFetchOperationFactory.h"

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

- (FOOTweetrFetchOperation *)createOperation:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    return [[FOOTweetrFetchOperation alloc] initWithTweetrRequestor:self.requestor
                                          backgroundCoreDataFactory:self.backgroundCoreDataFactory
                                         persistentStoreCoordinator:persistentStoreCoordinator];
}

@end
