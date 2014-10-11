#import "FOOTweetrRequestor.h"
#import "FOOBackgroundCoreDataFactory.h"
#import "FOOTweetrRecordCoreDataAdapter.h"

@interface FOOTweetrFetchOperation : NSOperation

- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor
              backgroundCoreDataFactory:(FOOBackgroundCoreDataFactory *)backgroundCoreDataFactory
             persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
