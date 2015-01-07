#import "FOOTweetrListingPresenter.h"

@interface FOOTweetrListingPresenter() < FOOTweetrListingViewDelegate, FOOTweetrModelDelegate>

@property (nonatomic) FOOTweetrModel *model;
@property (nonatomic) FOOTweetrListingView *view;
@property (nonatomic) FOOTweetrViewModel *viewModel;
@end

@implementation FOOTweetrListingPresenter

- (instancetype)initWithModel:(FOOTweetrModel *)model
                         view:(FOOTweetrListingView *)view
                    viewModel:(FOOTweetrViewModel *)viewModel {
    
    if (self = [super init]) {
        self.model = model;
        self.view = view;
        self.viewModel = viewModel;
        
        self.model.delegate = self;
        self.view.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [self.model viewNeedsData];
}

- (void)didReceiveMemoryWarning {
    
}

#pragma mark FOOFOOTweetrListingViewDelegate

-(void)selectedRecord:(FOOTweetrRecord *)record {
    // do something like a popover
}

-(void)deletePressed {
    [self.model deleteAll];
}

- (void)swipeToDelete:(NSIndexPath *)index {
    [self.model deleteRecordAtIndex:index];
}

-(void)updateRequested {
    [self.viewModel refreshRequested];
    [self.model requestSync];
}

#pragma mark FOOTweetrModelDelegate

- (void)syncFinished {
    [self.view refreshFinished];
}

- (void)setViewDataSource:(id<IOBTableViewDataSource>)dataSource {
    [self.view setDataSource:dataSource];
    [self.view reloadTableView];
}

@end
