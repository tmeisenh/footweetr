#import "FOOTweetrRequestor.h"

@interface FOOTweetrFetchOperation : NSOperation

- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor
             persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
