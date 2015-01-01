#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "IOBTableViewCellDecorator.h"
#import "IOBTableViewSectionDecorator.h"
#import "IOBTableViewDataSource.h"

@protocol IOBTableViewAdapter <NSObject, UITableViewDataSource, UITableViewDelegate>

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithCellDecorator:(id <IOBTableViewCellDecorator>)cellDecorator
                     sectionDecorator:(id <IOBTableViewSectionDecorator>)sectionDecorator
                           dataSource:(id <IOBTableViewDataSource>)dataSource;

@end
