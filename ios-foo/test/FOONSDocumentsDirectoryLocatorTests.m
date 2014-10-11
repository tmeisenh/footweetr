#import <XCTest/XCTest.h>
#import <stubble/Stubble.h>

#import "FOONSDocumentsDirectoryLocator.h"

@interface FOONSDocumentsDirectoryLocatorTests : XCTestCase {
    FOONSDocumentsDirectoryLocator *testObject;
    NSFileManager *fileManager;
}
@end

@implementation FOONSDocumentsDirectoryLocatorTests

- (void)setUp {
    [super setUp];
    fileManager = mock([NSFileManager class]);
    testObject = [[FOONSDocumentsDirectoryLocator alloc] initWithFileManager:fileManager];
}

- (void)testApplicationDocumentsDirectory {
    NSURL *url1 = mock([NSURL class]);
    NSURL *url2 = mock([NSURL class]);
    
    [when([fileManager URLsForDirectory:NSDocumentDirectory
                              inDomains:NSUserDomainMask]) thenReturn:@[url1, url2]];
    
    NSURL *actual = [testObject applicationDocumentsDirectory];
    
    XCTAssertEqualObjects(url2, actual);
}


@end
