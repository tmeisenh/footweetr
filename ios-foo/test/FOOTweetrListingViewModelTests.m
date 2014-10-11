#import <XCTest/XCTest.h>
#import <stubble/Stubble.h>

#import "FOOTweetrListingViewModel.h"
#import "FOOTweetrRecord.h"

@interface FOOTweetrListingViewModelTests : XCTestCase {
    id <FOOTweetrRequestor> requestor;
    FOOTweetrListingViewModel *testObject;
}
@end

@implementation FOOTweetrListingViewModelTests

- (void)setUp {
    [super setUp];
    
    requestor = mock(@protocol(FOOTweetrRequestor));
    testObject = [[FOOTweetrListingViewModel alloc] initWithTweetrRequestor:requestor];
    
}

- (void)testFetchAllTweetr_ReturnsAllTweetrRecords {
    FOOTweetrRecord *record1 = mock([FOOTweetrRecord class]);
    FOOTweetrRecord *record2 = mock([FOOTweetrRecord class]);
    
    [when([requestor fetchAllTweetrRecords]) thenReturn:@[record1, record2]];

    NSArray *actual = [testObject fetchAllTweetrRecords];
    
    XCTAssertEqualObjects(record1, [actual firstObject]);
    XCTAssertEqualObjects(record2, [actual lastObject]);
}

@end
