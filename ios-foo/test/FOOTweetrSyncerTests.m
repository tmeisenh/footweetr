#import <XCTest/XCTest.h>
#import <stubble/Stubble.h>

#import "FOOTweetrSyncer.h"

@interface FOOTweetrSyncerTests : XCTestCase {
    NSPersistentStoreCoordinator *coordinator;
    NSManagedObjectContext *coredata;
    FOODispatcher *dispatcher;
    FOOTweetrFetchOperationFactory *operationFactory;
    NSNotificationCenter *testCenter;
    
    FOOTweetrSyncer *testObject;
    
}
@end

@interface FOOTweetrSyncer (Tests)
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory
                          notificationCenter:(NSNotificationCenter *)notificationCenter;
@end


@implementation FOOTweetrSyncerTests

- (void)setUp {
    [super setUp];
    
    coordinator = mock([NSPersistentStoreCoordinator class]);
    coredata = mock([NSManagedObjectContext class]);
    [when([coredata persistentStoreCoordinator]) thenReturn:coordinator];
    dispatcher = mock([FOODispatcher class]);
    operationFactory = mock([FOOTweetrFetchOperationFactory class]);
    testCenter = [[NSNotificationCenter alloc] init];
    
    testObject = [[FOOTweetrSyncer alloc] initWithManagedObjectContext:coredata
                                                            dispatcher:dispatcher
                                                      operationFactory:operationFactory
                                                    notificationCenter:testCenter];
}
/*
 Since this class needs to listen for notifications, we need to be
 specific with its context.  Our tests will push notifications to
 a specific context and we only want our test object to handle it.
 If we didn't do this then when our test pushes a notification
 the test and real instance (via appdelegate) would get the notification.
 */

- (void)testSync_AddsOperationToQueue {
    [testObject sync];
    
    verifyCalled([operationFactory createOperation:coordinator]);
}

- (void)testWhenBackgroundOperationSavesContext_ThenItIsMergedOnMainThread {
    FOODispatcherMainthreadBlock block = NULL;
    when([dispatcher dispatchOnMainThreadBlock:capture(&block)]);
    [testCenter postNotificationName:NSManagedObjectContextDidSaveNotification
                              object:nil
                            userInfo:nil];
    
    block();
    
    verifyCalled([coredata mergeChangesFromContextDidSaveNotification:any()]);
}

- (void)testWhenMainContextSaves_ThenSaveEventIsIgnored {
    [testCenter postNotificationName:NSManagedObjectContextDidSaveNotification
                              object:coredata
                            userInfo:nil];
    
    verifyNoInteractions(dispatcher);
    verifyNever([coredata mergeChangesFromContextDidSaveNotification:any()]);
}
@end
