#import "FOOTweetrListingViewController.h"

#import "FOOTweetrListingView.h"

@interface FOOTweetrListingViewController () <FOOTweetrListingViewDelegate, FOOTweetrModelDelegate>

@property (nonatomic) FOOTweetrModel *model;
@property (nonatomic) FOOTweetrListingView *listingView;
@end

@implementation FOOTweetrListingViewController

- (instancetype)initWithTweetrModel:(FOOTweetrModel *)tweetrModel {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.model = tweetrModel;
        self.model.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listingView = [[FOOTweetrListingView alloc] initWithFrame:CGRectZero];
    self.listingView.delegate = self;
    [self.listingView updateViewWithTweetrRecords:[self.model fetchAllTweetrRecords]];
    self.view = self.listingView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark FOOFOOTweetrListingViewDelegate

-(void)selectedRecord:(FOOTweetrRecord *)record {
    // do something like a popover
}

-(void)deletePressed {
    [self.model deleteAll];
}

-(void)updateRequested {
    [self.model requestSync];
}

- (void)beginUpdate {
    [self.listingView beginUpdate];
}

- (void)endUpdate {
    [self.listingView endUpdate];
}

- (void)dataUpdated:(NSArray *)paths {
    [self.listingView updateRows:paths];
}

- (void)dataInserted:(NSArray *)paths {
    [self.listingView insertRows:paths];
}

- (void)dataRemoved:(NSArray *)paths {
    [self.listingView removeRows:paths];
}

-(NSInteger)dataCount {
    return [[self.model fetchAllTweetrRecords] count];
}

- (FOOTweetrRecord *)dataForIndex:(NSInteger)index {
    return [self.model fetchAllTweetrRecords][index];
}

@end
