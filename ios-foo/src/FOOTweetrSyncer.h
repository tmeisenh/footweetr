#import "FOOTweetrRequestor.h"
#import "FOODispatcher.h"
@interface FOOTweetrSyncer : NSObject

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                             tweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor
                                  dispatcher:(FOODispatcher *)dispatcher;

- (void)sync;

@end
