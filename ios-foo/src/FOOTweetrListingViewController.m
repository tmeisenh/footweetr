#import "FOOTweetrListingViewController.h"

#import "FOOFOOTweetrListingView.h"
#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewController ()

@property (nonatomic)FOOTweetrListingViewModel *viewModel;

@end

@implementation FOOTweetrListingViewController

- (instancetype)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.viewModel = [[FOOTweetrListingViewModel alloc] initWithTweetrRequestor:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FOOFOOTweetrListingView *listingView = [[FOOFOOTweetrListingView alloc] initWithFrame:CGRectZero];
    
    self.view = listingView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
