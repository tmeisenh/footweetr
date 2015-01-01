#import "FOOTweeterListingSectionDecorator.h"
#import "FOOTweeterListingSectionHeaderView.h"

@implementation FOOTweeterListingSectionDecorator

- (CGFloat)heightForSectiontIndex:(NSInteger)section {
    return 50.0;
}

- (UIView *)sectionViewAtIndex:(NSInteger)index
     dataSourceEntityAtSection:(NSObject *)dataSourceEntityAtSection {
    
    NSString *name = (NSString *)dataSourceEntityAtSection;
    FOOTweeterListingSectionHeaderView *sectionView = [[FOOTweeterListingSectionHeaderView alloc] initWithName:name];
    return sectionView;
}

@end
