#import "FOOTweetrListingViewController.h"

#import "FOOFOOTweetrListingView.h"
#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewController ()

@property (nonatomic)FOOTweetrListingViewModel *viewModel;

@end

@implementation FOOTweetrListingViewController

- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.viewModel = [[FOOTweetrListingViewModel alloc] initWithTweetrRequestor:tweetrRequestor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FOOFOOTweetrListingView *listingView = [[FOOFOOTweetrListingView alloc] initWithFrame:CGRectZero];
    [listingView updateViewWithTweetrRecords:[self.viewModel fetchAllTweetrRecords]];
    self.view = listingView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
