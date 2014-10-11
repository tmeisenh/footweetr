#import "FOOFOOTweetrListingView.h"
#import "FOOTweetrListingViewCellTableViewCell.h"

#define FOOFOOTweetrListingViewCellReuseIdentifier @"FOOFOOTweetrListingViewCellReuseIdentifier"


@interface FOOFOOTweetrListingView() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSArray *data;

@end

@implementation FOOFOOTweetrListingView

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
        
        UITableView *listing = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        listing.dataSource = self;
        listing.delegate = self;
        listing.backgroundColor = [UIColor clearColor];
        listing.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        listing.allowsMultipleSelection = NO;
        listing.allowsSelectionDuringEditing = NO;
        [listing registerClass:[FOOTweetrListingViewCellTableViewCell class] forCellReuseIdentifier:FOOFOOTweetrListingViewCellReuseIdentifier];
        
        [self addSubview:listing];
        
        CGFloat twoThird = 2.0 / 3;

        
        [listing makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.bottom).offset(45);
            make.centerX.equalTo(self.centerX);
            make.width.equalTo(self.width).multipliedBy(twoThird);
            make.bottom.equalTo(self.bottom).offset(-100);
        }];

        
    }
    return self;
}

#pragma mark UITableViewDelegate

-(void)updateViewWithTweetrRecords:(NSArray *)tweetrRecords {
    self.data = tweetrRecords;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    FOOTweetrRecord *record = self.data[indexPath.row];
    [self.delegate selectedRecord:record];
}

#pragma mark UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FOOTweetrListingViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FOOFOOTweetrListingViewCellReuseIdentifier];
    FOOTweetrRecord *record = self.data[indexPath.row];
    [cell setTitle:record.title user:record.user content:record.content];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

@end
