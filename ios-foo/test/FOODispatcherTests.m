#import <XCTest/XCTest.h>
#import "FOODispatcher.h"

@interface FOODispatcherTests : XCTestCase {
    FOODispatcher *testObject;
}
@end

@implementation FOODispatcherTests

- (void)setUp {
    [super setUp];
    
    testObject = [[FOODispatcher alloc] init];
}

- (void)testBlockIsExecutedOnMainThread {
    [testObject dispatchOnMainThreadBlock:^{
        XCTAssertFalse([[NSThread currentThread] isMainThread]);
    }];
}


@end
