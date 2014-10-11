#import "FOOTweetrRequestor.h"
#import "FOOBackgroundCoreDataFactory.h"
#import "FOOTweetrRecordCoreDataAdapter.h"

@interface FOOTweetrFetchOperationFactory : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)requestor
              backgroundCoreDataFactory:(FOOBackgroundCoreDataFactory *)backgroundCoreDataFactory;

- (NSOperation *)createOperation:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;


@end
