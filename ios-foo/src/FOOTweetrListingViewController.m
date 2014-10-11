#import "FOOTweetrListingViewController.h"

#import "FOOFOOTweetrListingView.h"
#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewController () <FOOFOOTweetrListingViewDelegate, FOOTweetrListingViewModelDelegate>

@property (nonatomic)FOOTweetrListingViewModel *viewModel;
@property (nonatomic) FOOFOOTweetrListingView *listingView;
@end

@implementation FOOTweetrListingViewController

- (instancetype)initWithTweetrListingModel:(FOOTweetrListingModel *)tweetrListingModel {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.viewModel = [[FOOTweetrListingViewModel alloc] initWithTweetrListingModel:tweetrListingModel];
        self.viewModel.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listingView = [[FOOFOOTweetrListingView alloc] initWithFrame:CGRectZero];
    self.listingView.delegate = self;
    [self.listingView updateViewWithTweetrRecords:[self.viewModel fetchAllTweetrRecords]];
    self.view = self.listingView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark FOOFOOTweetrListingViewDelegate

-(void)selectedRecord:(FOOTweetrRecord *)record {
    // do something like a popover
}

-(void)dataChanged {
    [self.listingView updateViewWithTweetrRecords:[self.viewModel fetchAllTweetrRecords]];
}

@end
