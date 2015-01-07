#import <Foundation/Foundation.h>
#import "IOBTableViewDataSource.h"

@interface FOOTweetrListingTableViewDataSource : NSObject <IOBTableViewDataSource>

@property (nonatomic, weak) id <IOBTableViewDataSourceDelegate>delegate;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
