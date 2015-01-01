#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IOBTableViewSectionDecorator <NSObject>

- (CGFloat)heightForSectiontIndex:(NSInteger)section;

- (UIView *)sectionViewAtIndex:(NSInteger)index
     dataSourceEntityAtSection:(NSObject *)dataSourceEntityAtSection;

@end
