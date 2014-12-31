#import "FOOTweeterListingSectionHeaderView.h"

@implementation FOOTweeterListingSectionHeaderView

- (instancetype)initWithName:(NSString *)name {
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.backgroundColor = [UIColor lightGrayColor];
        UILabel *nameLabel = [self createUILabel];
        nameLabel.text = name;
        
        [self addSubview:nameLabel];
        
        [nameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY);
        }];
        
    }
    return self;
}

- (UILabel *)createUILabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 1;
    label.textColor = [UIColor blackColor];
    
    return label;
}

@end
