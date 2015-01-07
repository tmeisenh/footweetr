#import "FOOCoreDataTweetrRecord.h"
#import "FOOCoreDataUserRecord.h"

#import "IOBTableViewDataSource.h"

@protocol FOOTweetrListingViewDelegate <NSObject>

- (void)selectedRecord:(FOOCoreDataTweetrRecord *)record;
- (void)updateRequested;
- (void)deletePressed;
- (void)swipeToDelete:(NSIndexPath *)index;

@end

@interface FOOTweetrListingView : UIView

@property (nonatomic, weak) id <FOOTweetrListingViewDelegate>delegate;

- (void)reloadTableView;

- (void)setDataSource:(id <IOBTableViewDataSource>)dataSource;

- (void)refreshFinished;
- (void)updateNumberOfRecords:(NSInteger)numberOfRecords;
@end
