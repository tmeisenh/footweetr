#import <XCTest/XCTest.h>
#import <stubble/Stubble.h>

#import "FOOTweetrSyncer.h"

@interface FOOTweetrSyncerTests : XCTestCase {
    NSPersistentStoreCoordinator *coordinator;
    NSManagedObjectContext *coredata;
    FOODispatcher *dispatcher;
    FOOTweetrFetchOperationFactory *operationFactory;
    NSNotificationCenter *testCenter;
    
    NSOperationQueue *queue;
    FOOTweetrSyncer *testObject;
    FOOTweetrFetchOperation *operation;
    id <FOOTweetrFetchOperationDelegate>operationDelegate;

    
}
@end

@interface FOOTweetrSyncer (Tests)
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
                                  dispatcher:(FOODispatcher *)dispatcher
                            operationFactory:(FOOTweetrFetchOperationFactory *)operationFactory
                          notificationCenter:(NSNotificationCenter *)notificationCenter
                              operationQueue:(NSOperationQueue *)operationQueue;
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
    queue = mock([NSOperationQueue class]);
    operationDelegate = NULL;

    operation = mock([FOOTweetrFetchOperation class]);
    [when([operationFactory createOperation:coordinator]) thenReturn:operation];
    when([operation setDelegate:capture(&operationDelegate)]);
    
    testObject = [[FOOTweetrSyncer alloc] initWithManagedObjectContext:coredata
                                                            dispatcher:dispatcher
                                                      operationFactory:operationFactory
                                                    notificationCenter:testCenter
                                                        operationQueue:queue];
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
    
    verifyCalled([queue addOperation:operation]);
}


- (void)testWhenBackgroundOperationSavesContext_ThenItIsMergedOnMainThread {
    NSManagedObjectContext *secondContext = mock([NSManagedObjectContext class]);
    FOODispatcherMainthreadBlock block = NULL;
    when([dispatcher dispatchOnMainThreadBlock:capture(&block)]);
    
    [testObject sync];
    [operationDelegate observeContextForChanges:secondContext];
    
    
    [testCenter postNotificationName:NSManagedObjectContextDidSaveNotification
                              object:secondContext
                            userInfo:nil];
    
    block();
    
    verifyNoInteractions(secondContext);
    verifyCalled([coredata mergeChangesFromContextDidSaveNotification:any()]);
}

- (void)testAfterMergingContext_ThenItIsNoLongerObserved {
    NSManagedObjectContext *secondContext = mock([NSManagedObjectContext class]);
    FOODispatcherMainthreadBlock block = NULL;
    when([dispatcher dispatchOnMainThreadBlock:capture(&block)]);
    
    [testObject sync];
    [operationDelegate observeContextForChanges:secondContext];
    
    
    [testCenter postNotificationName:NSManagedObjectContextDidSaveNotification
                              object:secondContext
                            userInfo:nil];
    block();
    
    resetMock(dispatcher);
    resetMock(coredata);
    
    [testCenter postNotificationName:NSManagedObjectContextDidSaveNotification
                              object:secondContext
                            userInfo:nil];
    
    verifyNever([dispatcher dispatchOnMainThreadBlock:any()]);
    verifyNever([coredata mergeChangesFromContextDidSaveNotification:any()]);}

- (void)testWhenMainContextSaves_ThenSaveEventIsIgnored {
    NSManagedObjectContext *secondContext = mock([NSManagedObjectContext class]);
    
    [testObject sync];
    [operationDelegate observeContextForChanges:secondContext];
    [testCenter postNotificationName:NSManagedObjectContextDidSaveNotification
                              object:nil
                            userInfo:nil];
    
    verifyNoInteractions(dispatcher);
    verifyNever([coredata mergeChangesFromContextDidSaveNotification:any()]);
}
@end
