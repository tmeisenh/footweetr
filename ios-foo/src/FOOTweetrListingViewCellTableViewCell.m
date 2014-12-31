#import "FOOTweetrListingViewCellTableViewCell.h"

@interface FOOTweetrListingViewCellTableViewCell()

@property (nonatomic) UILabel *title;
@property (nonatomic) UILabel *user;
@property (nonatomic) UILabel *content;

@end

@implementation FOOTweetrListingViewCellTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor yellowColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.title = [self createUILabel];
        self.user = [self createUILabel];
        self.content = [self createUILabel];
        
        CGFloat half = 1.0 / 2.0;
        [self.contentView addSubview:self.title];
        self.title.textAlignment = NSTextAlignmentLeft;
        [self.title makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top);
            make.height.equalTo(@44);
            make.left.equalTo(self.left).offset(10);
            make.width.equalTo(self.width).multipliedBy(half);
        }];
        
        [self.contentView addSubview:self.user];
        self.user.textAlignment = NSTextAlignmentRight;
        [self.user makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.top);
            make.height.equalTo(@44);
            make.left.equalTo(self.title.right);
            make.right.equalTo(self.right);
        }];
        
        [self.contentView addSubview:self.content];
        self.content.textAlignment = NSTextAlignmentCenter;
        [self.content makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.title.bottom);
            make.left.equalTo(self.left);
            make.right.equalTo(self.right);
            make.bottom.equalTo(self.bottom);
        }];

    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setTitle:(NSString *)title
           user:(NSString *)user
        content:(NSString *)content {
    
    self.title.text = [NSString stringWithFormat:@"title: %@", title];
    self.user.text = [NSString stringWithFormat:@"user: %@", user];
    self.content.text = [NSString stringWithFormat:@"content: %@", content];
}

- (UILabel *)createUILabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 1;
    label.textColor = [UIColor blackColor];
    
    return label;
}

@end
