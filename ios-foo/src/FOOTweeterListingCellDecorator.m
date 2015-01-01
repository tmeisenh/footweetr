#import "FOOTweeterListingCellDecorator.h"

#import "FOOTweetrListingViewCellTableViewCell.h"
#import "FOOCoreDataTweetrRecord.h"
#import "FOOCoreDataUserRecord.h"

@implementation FOOTweeterListingCellDecorator

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (UITableViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
                  dataSourceEntityAtIndexPath:(NSObject *)dataSourceEntityAtIndexPath
                                  tableView:(UITableView *)tableView {
    
    FOOCoreDataTweetrRecord *data = (FOOCoreDataTweetrRecord *)dataSourceEntityAtIndexPath;
    
    NSString *cellId = NSStringFromClass([data class]);
    FOOTweetrListingViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    [cell setTitle:data.title user:data.user.name content:data.content];
    
    return cell;
}

@end
