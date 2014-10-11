#import <XCTest/XCTest.h>
#import <stubble/Stubble.h>

#import "FOOTweetrSyncer.h"

@interface FOOTweetrSyncerTests : XCTestCase {
    NSManagedObjectContext *coredata;
    id <FOOTweetrRequestor> requestor;
    FOODispatcher *dispatcher;
    
    FOOTweetrSyncer *testObject;
    
    NSNotificationCenter *testCenter;
}
@end

@interface FOOTweetrSyncer (Tests)
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                             tweetrRequestor:(id<FOOTweetrRequestor>)tweetrRequestor
                                  dispatcher:(FOODispatcher *)dispatcher
                          notificationCenter:(NSNotificationCenter *)notificationCenter;
@end


@implementation FOOTweetrSyncerTests

- (void)setUp {
    [super setUp];
    
    coredata = mock([NSManagedObjectContext class]);
    requestor = mock(@protocol(FOOTweetrRequestor));
    dispatcher = mock([FOODispatcher class]);
    testCenter = [[NSNotificationCenter alloc] init];
    
    testObject = [[FOOTweetrSyncer alloc] initWithManagedObjectContext:coredata
                                                       tweetrRequestor:requestor
                                                            dispatcher:dispatcher
                                                    notificationCenter:testCenter];
}

- (void)postNotification {
    [testCenter postNotificationName:NSManagedObjectContextDidSaveNotification
                                                        object:nil
                                                      userInfo:nil];
}

- (void)testWhenBackgroundOperationSavesContext_ThenItIsMergedOnMainThread {
    FOODispatcherMainthreadBlock block = NULL;
    when([dispatcher dispatchOnMainThreadBlock:capture(&block)]);
    
    [self postNotification];
    block();
    
    verifyCalled([coredata mergeChangesFromContextDidSaveNotification:any()]);
}

@end
