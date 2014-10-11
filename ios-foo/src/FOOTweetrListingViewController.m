#import "FOOTweetrListingViewController.h"

#import "FOOFOOTweetrListingView.h"

@interface FOOTweetrListingViewController ()

@end

@implementation FOOTweetrListingViewController

- (instancetype)init {
    if (self = [super initWithNibName:nil bundle:nil]) {
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
