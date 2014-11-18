#import "FOOTweetrListingViewController.h"

#import "FOOTweetrListingPresenter.h"

@interface FOOTweetrListingViewController ()

@property (nonatomic) FOOTweetrModel *model;
@property (nonatomic) FOOTweetrListingPresenter *presenter;

@end

@implementation FOOTweetrListingViewController

- (instancetype)initWithTweetrModel:(FOOTweetrModel *)tweetrModel {
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.model = tweetrModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FOOTweetrListingView *listingView = [[FOOTweetrListingView alloc] initWithFrame:CGRectZero];
    self.view = listingView;

    FOOTweetrViewModel *viewModel = [[FOOTweetrViewModel alloc] init];
    FOOTweetrListingPresenter *presenter = [[FOOTweetrListingPresenter alloc] initWithModel:self.model
                                                                                       view:listingView
                                                                                  viewModel:viewModel];
    self.presenter = presenter;
    
    [self.presenter viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
