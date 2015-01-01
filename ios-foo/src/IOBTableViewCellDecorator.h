#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@protocol IOBTableViewCellDecorator <NSObject>

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
                dataSourceEntityAtIndexPath:(NSObject *)dataSourceEntityAtIndexPath
                                  tableView:(UITableView *)tableView;

@end
