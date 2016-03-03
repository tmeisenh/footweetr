#import "FOOTweetrListingView.h"
#import "FOOTweetrListingViewCellTableViewCell.h"
#import "FOOTweeterListingSectionHeaderView.h"

@interface FOOTweetrListingView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *listing;
@property (nonatomic) UIRefreshControl *refreshControl;
@property (nonatomic) UILabel *numberOfRecordsLabel;
@end

@implementation FOOTweetrListingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.numberOfLines = 1;
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor blackColor];
        title.text = @"*********** TWEETR!! ***********";
        
        
        [self addSubview:title];
        [title makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left);
            make.right.equalTo(self.right);
            make.top.equalTo(self.top);
            make.height.equalTo(@65);
        }];
        
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [deleteButton setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.2f]
                           forState:UIControlStateHighlighted];
        [deleteButton setTitle:@"Delete All Records" forState:UIControlStateNormal];
        [deleteButton addTarget:self
                         action:@selector(deletePressed)
               forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:deleteButton];
        [deleteButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.bottom).offset(25);
            make.centerX.equalTo(self.centerX);
            make.height.equalTo(@45);
        }];
        
        UILabel *numberOfRecordsLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        numberOfRecordsLabel.lineBreakMode = NSLineBreakByWordWrapping;
        numberOfRecordsLabel.numberOfLines = 1;
        numberOfRecordsLabel.textAlignment = NSTextAlignmentCenter;
        numberOfRecordsLabel.textColor = [UIColor blackColor];
        [self addSubview:numberOfRecordsLabel];
        self.numberOfRecordsLabel = numberOfRecordsLabel;
        
        [numberOfRecordsLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(deleteButton.bottom).offset(25);
            make.centerX.equalTo(self.centerX);
            make.height.equalTo(@45);
        }];
        
        self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
        [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
        
        self.listing = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.listing.dataSource = self;
        self.listing.delegate = self;
        self.listing.backgroundColor = [UIColor clearColor];
        self.listing.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.listing.allowsMultipleSelection = NO;
        self.listing.allowsSelectionDuringEditing = YES;
        [self.listing registerClass:[FOOTweetrListingViewCellTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FOOCoreDataTweetrRecord class])];
        [self.listing addSubview:self.refreshControl];
        [self.listing setPagingEnabled:NO];
        
        [self addSubview:self.listing];
        
        CGFloat twoThird = 2.0 / 3;

        
        [self.listing makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(numberOfRecordsLabel.bottom).offset(45);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(self.width).multipliedBy(twoThird);
            make.bottom.equalTo(self.bottom).offset(-100);
        }];

        
    }
    return self;
}

- (void)refreshFinished {
    [self.refreshControl endRefreshing];
}

- (void)beginUpdate {
    [self.listing beginUpdates];
}

- (void)endUpdate {
    [self.listing endUpdates];
}

-(void)insertRows:(NSArray *)paths {
    [self.listing insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)removeRows:(NSArray *)paths {
    [self.listing deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)updateRows:(NSArray *)paths {
    /* do what? */
}

- (void)dataMoved:(NSIndexPath *)src dest:(NSIndexPath *)dest {
    [self.listing moveRowAtIndexPath:src toIndexPath:dest];
}

- (void)insertSections:(NSIndexSet *)sections {
    [self.listing insertSections:sections withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removeSections:(NSIndexSet *)sections {
    [self.listing deleteSections:sections withRowAnimation:UITableViewRowAnimationNone];
}

- (void)updateSections:(NSIndexSet *)sections {
//    [self.listing u:sections withRowAnimation:UITableViewRowAnimationAutomatic];

}

-(void)updateNumberOfRecords:(NSInteger)numberOfRecords {
    self.numberOfRecordsLabel.text = [NSString stringWithFormat:@"Number of records %i", numberOfRecords];
}

- (void)deletePressed {
    [self.delegate deletePressed];
}

- (void)pullToRefresh {
    [self.delegate updateRequested];
}

#pragma mark UITableViewDelegate

-(void)reloadTableView {
    [self.listing reloadData];
    [self updateNumberOfRecords:[self.delegate dataCount]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    FOOCoreDataTweetrRecord *record = [self.delegate dataForIndex:indexPath];
    /* This could just as easily pass the index. */
    [self.delegate selectedRecord:record];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FOOTweeterListingSectionHeaderView *header = [[FOOTweeterListingSectionHeaderView alloc] initWithName:[self.delegate sectionValue:section]];
    return header;
}

#pragma mark UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FOOCoreDataTweetrRecord *record = [self.delegate dataForIndex:indexPath];
    FOOTweetrListingViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([record class])];
    [cell setTitle:record.title user:record.user.name content:record.content];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.delegate numberOfSections];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.delegate swipeToDelete:indexPath];
    }
}

@end
