#import <XCTest/XCTest.h>
#import <stubble/Stubble.h>

#import "FOOTweetrListingViewModel.h"
#import "FOOTweetrRecord.h"

@interface FOOTweetrListingViewModelTests : XCTestCase {
    FOOTweetrModel * lister;
    FOOTweetrListingViewModel *testObject;
}
@end

@implementation FOOTweetrListingViewModelTests

- (void)setUp {
    [super setUp];
    
    lister = mock([FOOTweetrModel class]);
    testObject = [[FOOTweetrListingViewModel alloc] initWithTweetrModel:lister];
    
}

- (void)testFetchAllTweetr_ReturnsAllTweetrRecords {
    FOOTweetrRecord *record1 = mock([FOOTweetrRecord class]);
    FOOTweetrRecord *record2 = mock([FOOTweetrRecord class]);
    
    [when([lister fetchAllTweetrRecords]) thenReturn:@[record1, record2]];

    NSArray *actual = [testObject fetchAllTweetrRecords];
    
    XCTAssertEqualObjects(record1, [actual firstObject]);
    XCTAssertEqualObjects(record2, [actual lastObject]);
}

@end
