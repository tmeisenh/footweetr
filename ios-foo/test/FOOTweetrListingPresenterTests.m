#import <UIKit/UIKit.h>
#import <stubble/Stubble.h>
#import <XCTest/XCTest.h>

#import "FOOTweetrListingPresenter.h"

@interface FOOTweetrListingPresenterTests : XCTestCase {
    FOOTweetrModel *model;
    FOOTweetrListingView *view;
    FOOTweetrViewModel *viewModel;
    FOOTweetrListingPresenter *testObject;
}
@end

@implementation FOOTweetrListingPresenterTests

- (void)setUp {
    [super setUp];
    
    model = mock([FOOTweetrModel class]);
    view = mock([FOOTweetrListingView class]);
    viewModel = mock([FOOTweetrViewModel class]);
    
    testObject = [[FOOTweetrListingPresenter alloc] initWithModel:model
                                                             view:view
                                                        viewModel:viewModel];
}

- (id <FOOTweetrModelDelegate>)modelDelegate {
    return (id <FOOTweetrModelDelegate>)testObject;
}

- (id <FOOTweetrListingViewDelegate>)viewDelegate {
    return (id <FOOTweetrListingViewDelegate>)testObject;
}

- (void)testWhenViewDidLoad_ThenViewIsInitiallyPopulated {
    
    NSArray *records = mock([NSArray class]);
    [when([model fetchAllTweetrRecords]) thenReturn:records];
    
    [testObject viewDidLoad];
    
    verifyCalled([view updateViewWithTweetrRecords:records]);
}

- (void)testWhenDeleteIsPressed_ThenModelDeletesAllRecords {
    [[self viewDelegate] deletePressed];
    
    verifyCalled([model deleteAll]);
}

- (void)testWhenPullToRefreshIsPulled_ThenSyncIsRequestedAndViewStateIsUpdated {
    [[self viewDelegate] updateRequested];
    
    verifyCalled([model requestSync]);
    verifyCalled([viewModel refreshRequested]);
}

//@TODO rethink this
- (void)testWhenViewRequestsDataCount_ThenModelReturnsDataCount {
    [[self viewDelegate] dataCount];
    
    verifyCalled([model fetchAllTweetrRecords]);
}

- (void)testWhenViewRequestsDataAtIndex_ThenModelFetchesIt {
    [[self viewDelegate] dataForIndex:0];
    
    verifyCalled([model fetchAllTweetrRecords]);
}

- (void)testWhenModelStartsUpdating_ThenViewIsUpdated {
    [[self modelDelegate] beginUpdate];
    
    verifyCalled([view beginUpdate]);
}

- (void)testWhenModelStartsUpdating_IfViewStateIsInRefreshingState_ThenStateAndViewAreUpdatedToNotBeRefreshing {
    
    [when([viewModel isRefreshOngoing]) thenReturn:@YES];
    
    [[self modelDelegate] beginUpdate];
    
    verifyCalled([view beginUpdate]);
    verifyCalled([viewModel refreshFinished]);
    verifyCalled([view refreshFinished]);
}

- (void)testWhenModelFinishesUpdating_ThenViewIsUpdated {
    [[self modelDelegate] endUpdate];
    
    verifyCalled([view endUpdate]);
}

- (void)testWhenModelUpdatesData_ThenViewIsUpdated {
    NSArray *paths = mock([NSArray class]);
    [[self modelDelegate] dataUpdated:paths];
    
    verifyCalled([view updateRows:paths]);
}

- (void)testWhenModelRemovesData_ThenViewIsUpdated {
    NSArray *paths = mock([NSArray class]);
    [[self modelDelegate] dataRemoved:paths];
    
    verifyCalled([view removeRows:paths]);
}


- (void)testWhenModelInsertsData_ThenViewIsUpdated {
    NSArray *paths = mock([NSArray class]);
    [[self modelDelegate] dataInserted:paths];
    
    verifyCalled([view insertRows:paths]);
}

@end
