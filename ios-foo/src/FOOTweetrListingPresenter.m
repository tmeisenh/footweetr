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
    [self.view reloadTableView];
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

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfRowsInSection:section];
}

- (NSInteger)numberOfSections {
    return [self.model numberOfSections];
}

- (NSInteger)dataCount {
    return [[self.model fetchAllTweetrRecords] count];
}

- (FOOCoreDataTweetrRecord *)dataForIndex:(NSIndexPath *)index {
    return [self.model dataForIndex:index];
}

- (NSString *)sectionValue:(NSInteger)section {
    return [[self.model dataForSection:section] name];
}

#pragma mark FOOTweetrModelDelegate

- (void)beginUpdate {
    if ([self.viewModel isRefreshOngoing]) {
        [self.view refreshFinished];
        [self.viewModel refreshFinished];
    }
    [self.view beginUpdate];
}

- (void)endUpdate {
    [self.view endUpdate];
    [self.view updateNumberOfRecords:[self.model totalCount]];
}

- (void)dataUpdated:(NSArray *)paths {
    [self.view updateRows:paths];
}

- (void)dataInserted:(NSArray *)paths {
    [self.view insertRows:paths];
}

- (void)dataRemoved:(NSArray *)paths {
    [self.view removeRows:paths];
}

-(void)insertSections:(NSIndexSet *)sections {
    [self.view insertSections:sections];
}

- (void)removeSections:(NSIndexSet *)sections {
    [self.view removeSections:sections];
}

- (void)updateSections:(NSIndexSet *)sections {
    [self.view updateSections:sections];
}

@end
