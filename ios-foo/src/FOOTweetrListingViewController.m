#import "FOOTweetrListingViewController.h"

#import "FOOTweetrListingView.h"
#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewController () <FOOTweetrListingViewDelegate, FOOTweetrListingViewModelDelegate>

@property (nonatomic) FOOTweetrListingViewModel *viewModel;
@property (nonatomic) FOOTweetrListingView *listingView;
@end

@implementation FOOTweetrListingViewController

- (instancetype)initWithTweetrModel:(FOOTweetrModel *)tweetrModel {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.viewModel = [[FOOTweetrListingViewModel alloc] initWithTweetrModel:tweetrModel];
        self.viewModel.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listingView = [[FOOTweetrListingView alloc] initWithFrame:CGRectZero];
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
