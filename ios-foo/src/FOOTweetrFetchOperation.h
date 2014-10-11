#import "FOOTweetrRequestor.h"
#import "FOOBackgroundCoreDataFactory.h"
#import "FOOTweetrRecordCoreDataAdapter.h"

@protocol FOOTweetrFetchOperationDelegate <NSObject>

/// Called on background thread.
- (void)observeContextForChanges:(NSManagedObjectContext *)context;
@end

@interface FOOTweetrFetchOperation : NSOperation

@property (nonatomic, weak) id <FOOTweetrFetchOperationDelegate> delegate;

- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor
              backgroundCoreDataFactory:(FOOBackgroundCoreDataFactory *)backgroundCoreDataFactory
             persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
