#import <XCTest/XCTest.h>
#import <stubble/Stubble.h>

#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrFetchOperationTests : XCTestCase {
    id <FOOTweetrRequestor>requestor;
    FOOBackgroundCoreDataFactory *backgroundCoreDataFactory;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectContext *backgroundContext;
    FOOTweetrRecordCoreDataAdapter *adapter;
    
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
    
    [when([backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:persistentStoreCoordinator]) thenReturn:backgroundContext];

    testObject = [[FOOTweetrFetchOperation alloc] initWithTweetrRequestor:requestor
                                                backgroundCoreDataFactory:backgroundCoreDataFactory
                                               persistentStoreCoordinator:persistentStoreCoordinator
                                                          coreDataAdapter:adapter];
    
}

- (void)testOperationIsSynchronous {
    XCTAssertFalse(testObject.isConcurrent);
}

- (void)testWhenOperationIsStarted_ThenBackgroundContextIsCreated {
    
    [testObject start];
    
    verifyCalled([backgroundCoreDataFactory createManagedObjectContextForPersistentStoreCoordinator:persistentStoreCoordinator]);
}

- (void)testWhenOperationIsStarted_ThenNewRecordsAreFetched {
    [testObject start];
    
    verifyCalled([requestor fetchAllTweetrRecords]);
}

- (void)testWhenOperationIsStarted_ThenNewRecordsAreSaved {
    FOOTweetrRecord *r1 = mock([FOOTweetrRecord class]);
    FOOTweetrRecord *r2 = mock([FOOTweetrRecord class]);
    FOOCoreDataTweetrRecord *c1 = mock([FOOCoreDataTweetrRecord class]);
    FOOCoreDataTweetrRecord *c2 = mock([FOOCoreDataTweetrRecord class]);
    
    [when([requestor fetchAllTweetrRecords]) thenReturn:@[r1, r2]];
    
    [when([adapter convertTweetrRecordToCoreDataType:r1]) thenReturn:c1];
    [when([adapter convertTweetrRecordToCoreDataType:r2]) thenReturn:c2];

    
    [when([backgroundContext hasChanges]) thenReturn:@YES];
    [testObject start];
    
    verifyCalled([backgroundContext insertObject:c1]);
    verifyCalled([backgroundContext insertObject:c2]);
    verifyCalled([backgroundContext save:any(__autoreleasing NSError **)]);
}

@end
