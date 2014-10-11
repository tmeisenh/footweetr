#import "FOOTweetrListingViewController.h"

#import "FOOFOOTweetrListingView.h"
#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewController () <FOOFOOTweetrListingViewDelegate>

@property (nonatomic)FOOTweetrListingViewModel *viewModel;

@end

@implementation FOOTweetrListingViewController

- (instancetype)initWithTweetrListingModel:(FOOTweetrListingModel *)tweetrListingModel {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.viewModel = [[FOOTweetrListingViewModel alloc] initWithTweetrListingModel:tweetrListingModel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FOOFOOTweetrListingView *listingView = [[FOOFOOTweetrListingView alloc] initWithFrame:CGRectZero];
    listingView.delegate = self;
    [listingView updateViewWithTweetrRecords:[self.viewModel fetchAllTweetrRecords]];
    self.view = listingView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark FOOFOOTweetrListingViewDelegate

-(void)selectedRecord:(FOOTweetrRecord *)record {
    // do something like a popover
}

@end
