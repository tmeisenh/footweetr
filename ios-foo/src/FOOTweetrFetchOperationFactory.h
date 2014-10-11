#import "FOOTweetrRequestor.h"
#import "FOOBackgroundCoreDataFactory.h"
#import "FOOTweetrRecordCoreDataAdapter.h"
#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrFetchOperationFactory : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)requestor
              backgroundCoreDataFactory:(FOOBackgroundCoreDataFactory *)backgroundCoreDataFactory;

- (FOOTweetrFetchOperation *)createOperation:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;


@end
