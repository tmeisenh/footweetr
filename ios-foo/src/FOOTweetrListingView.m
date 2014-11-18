#import "FOOTweetrListingView.h"
#import "FOOTweetrListingViewCellTableViewCell.h"

#define FOOTweetrListingViewCellReuseIdentifier @"FOOTweetrListingViewCellReuseIdentifier"


@interface FOOTweetrListingView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *listing;
@property (nonatomic) UIRefreshControl *refreshControl;
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
        
        
        
        self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
        [self.refreshControl addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
        
        self.listing = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.listing.dataSource = self;
        self.listing.delegate = self;
        self.listing.backgroundColor = [UIColor clearColor];
        self.listing.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.listing.allowsMultipleSelection = NO;
        self.listing.allowsSelectionDuringEditing = NO;
        [self.listing registerClass:[FOOTweetrListingViewCellTableViewCell class] forCellReuseIdentifier:FOOTweetrListingViewCellReuseIdentifier];
        [self.listing addSubview:self.refreshControl];
        
        [self addSubview:self.listing];
        
        CGFloat twoThird = 2.0 / 3;

        
        [self.listing makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(deleteButton.bottom).offset(45);
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
    [self.listing insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)removeRows:(NSArray *)paths {
    [self.listing deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationFade];
}

- (void)updateRows:(NSArray *)paths {
    
}

- (void)deletePressed {
    [self.delegate deletePressed];
}

#pragma mark UITableViewDelegate

-(void)updateViewWithTweetrRecords:(NSArray *)tweetrRecords {
    [self.listing reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    FOOTweetrRecord *record = [self.delegate dataForIndex:indexPath.row];
    /* This could just as easily pass the index. */
    [self.delegate selectedRecord:record];
}

#pragma mark UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FOOTweetrListingViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FOOTweetrListingViewCellReuseIdentifier];
    FOOTweetrRecord *record = [self.delegate dataForIndex:indexPath.row];
    [cell setTitle:record.title user:record.user content:record.content];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate dataCount];
}

- (void)pullToRefresh {
    [self.delegate updateRequested];
}

@end
