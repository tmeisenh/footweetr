#import "FOOTweetrRequestor.h"
#import "FOODispatcher.h"
#import "FOOTweetrFetchOperationFactory.h"

@interface FOOTweetrSyncer : NSObject

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory;

- (void)sync;

@end
