#import <XCTest/XCTest.h>
#import <stubble/Stubble.h>

#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrFetchOperationTests : XCTestCase {
    id <FOOTweetrRequestor>requestor;
    FOOBackgroundCoreDataFactory *backgroundCoreDataFactory;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectContext *backgroundContext;
    FOOTweetrRecordCoreDataAdapter *adapter;
    
    id <FOOTweetrFetchOperationDelegate> delegate;
    FOOTweetrFetchOperation *testObject;
}
@end

@implementation FOOTweetrFetchOperationTests

- (void)setUp {
    [super setUp];
    requestor = mock(@protocol(FOOTweetrRequestor));
    backgroundCoreDataFactory = mock([FOOBackgroundCoreDataFactory class]);
    persistentStoreCoordinator = mock([NSPersistentStoreCoordinator class]);
    backgroundContext = mock([NSManagedObjectContext class]);
    adapter = mock([FOOTweetrRecordCoreDataAdapter class]);
    delegate = mock(@protocol(FOOTweetrFetchOperationDelegate));

    testObject = [[FOOTweetrFetchOperation alloc] initWithTweetrRequestor:requestor
                                                backgroundCoreDataFactory:backgroundCoreDataFactory
                                               persistentStoreCoordinator:persistentStoreCoordinator];
    testObject.delegate = delegate;
    
}

- (void)testOperationIsSynchronous {
    XCTAssertFalse(testObject.isConcurrent);
    XCTAssertFalse(testObject.isAsynchronous);
}

- (void)testWhenOperationIsStarted_ThenBackgroundContextIsCreatedAndDelegateIsNotified {
    [when([backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:persistentStoreCoordinator]) thenReturn:backgroundContext];
    
    [testObject main];
    
    verifyCalled([delegate observeContextForChanges:backgroundContext]);
}

- (void)testWhenOperationIsStarted_ThenNewRecordsAreFetched {
    [testObject main];
    
    verifyCalled([requestor fetchAllTweetrRecords]);
}

- (void)testWhenOperationIsStarted_ThenNewRecordsAreSaved {
    FOOTweetrRecord *r1 = mock([FOOTweetrRecord class]);
    FOOTweetrRecord *r2 = mock([FOOTweetrRecord class]);
    FOOCoreDataTweetrRecord *c1 = mock([FOOCoreDataTweetrRecord class]);
    FOOCoreDataTweetrRecord *c2 = mock([FOOCoreDataTweetrRecord class]);
    
    [when([requestor fetchAllTweetrRecords]) thenReturn:@[r1, r2]];
    [when([backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:persistentStoreCoordinator]) thenReturn:backgroundContext];
    [when([backgroundCoreDataFactory createCoreDataAdapterForContext:backgroundContext]) thenReturn:adapter];
    [when([adapter convertTweetrRecordToCoreDataType:r1 user:nil]) thenReturn:c1];
    [when([adapter convertTweetrRecordToCoreDataType:r2 user:nil]) thenReturn:c2];

    
    [when([backgroundContext hasChanges]) thenReturn:@YES];
    [testObject main];
    
    verifyCalled([backgroundContext insertObject:c1]);
    verifyCalled([backgroundContext insertObject:c2]);
    verifyCalled([backgroundContext save:any(__autoreleasing NSError **)]);
}

- (void)testWhenOperationIsStarted_AndFindsNoRecords_ThenContextIsNotSaved {
    [when([backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:persistentStoreCoordinator]) thenReturn:backgroundContext];
    [when([backgroundContext hasChanges]) thenReturn:@NO];
    
    [testObject main];
    
    verifyNever([backgroundContext save:any(__autoreleasing NSError **)]);
}

- (void)testWhenOperationIsCanceledBeforeStarting_ThenItDoesNothing {
    [testObject cancel];
    [testObject main];
    
    verifyNoInteractions(requestor);
    verifyNoInteractions(backgroundCoreDataFactory);
    verifyNoInteractions(backgroundContext);
    verifyNoInteractions(adapter);
}

- (void)testWhenOperationIsCanceledAfterCreatingContext_ThenNothingIsFetched {
    [when([backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:any()]) thenDo:^{
        [testObject cancel];
    }];
    
    [testObject main];
    
    verifyNoInteractions(requestor);
    verifyNoInteractions(backgroundContext);
    verifyNoInteractions(adapter);
}

- (void)testWhenOperationIsCanceledAfterFetchingRecords_ThenTheyAreNotSaved {
    [when([backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:persistentStoreCoordinator]) thenReturn:backgroundContext];

    [when([requestor fetchAllTweetrRecords]) thenDo:^{
        [testObject cancel];
    }];
    
    [testObject main];
    
    verifyNoInteractions(adapter);
    verifyNever([backgroundContext insertObject:any()]);
    verifyNever([backgroundContext save:any(__autoreleasing NSError **)]);
}

- (void)testWhenOperationIsCanceledAfterFinishingAllProcessing_ThenTheyAreNotSaved {

    FOOTweetrRecord *r1 = mock([FOOTweetrRecord class]);
    FOOTweetrRecord *r2 = mock([FOOTweetrRecord class]);
    FOOCoreDataTweetrRecord *c1 = mock([FOOCoreDataTweetrRecord class]);
    FOOCoreDataTweetrRecord *c2 = mock([FOOCoreDataTweetrRecord class]);
    
    [when([requestor fetchAllTweetrRecords]) thenReturn:@[r1, r2]];
    [when([backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:persistentStoreCoordinator]) thenReturn:backgroundContext];
    [when([backgroundCoreDataFactory createCoreDataAdapterForContext:backgroundContext]) thenReturn:adapter];
    [when([adapter convertTweetrRecordToCoreDataType:r1 user:nil]) thenReturn:c1];
    [when([adapter convertTweetrRecordToCoreDataType:r2 user:nil]) thenReturn:c2];
    [when([backgroundContext insertObject:c2]) thenDo:^{
        [testObject cancel];
    }];
    
    [when([backgroundContext hasChanges]) thenReturn:@YES];
    
    [testObject main];
    
    verifyNever([backgroundContext save:any(__autoreleasing NSError **)]);
}

@end
