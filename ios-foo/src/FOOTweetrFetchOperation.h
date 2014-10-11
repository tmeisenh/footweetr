#import "FOOTweetrRequestor.h"
#import "FOOBackgroundCoreDataFactory.h"
#import "FOOTweetrRecordCoreDataAdapter.h"

#import "FOOCoreDataContextMerger.h"

@interface FOOTweetrFetchOperation : NSOperation

@property (nonatomic) FOOCoreDataContextMerger *merger;

- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor
              backgroundCoreDataFactory:(FOOBackgroundCoreDataFactory *)backgroundCoreDataFactory
             persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
