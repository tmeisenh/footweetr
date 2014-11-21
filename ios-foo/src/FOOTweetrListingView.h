#import "FOOTweetrRecord.h"

@protocol FOOTweetrListingViewDelegate <NSObject>

- (void)selectedRecord:(FOOTweetrRecord *)record;
- (void)updateRequested;
- (void)deletePressed;

- (FOOTweetrRecord *)dataForIndex:(NSInteger)index;
- (NSInteger)dataCount;
- (void)swipeToDelete:(NSIndexPath *)index;

@end

@interface FOOTweetrListingView : UIView

@property (nonatomic, weak) id <FOOTweetrListingViewDelegate>delegate;

- (void)reloadTableView;

- (void)updateRows:(NSArray *)paths;
- (void)insertRows:(NSArray *)paths;
- (void)removeRows:(NSArray *)paths;
- (void)beginUpdate;
- (void)endUpdate;
- (void)refreshFinished;
- (void)updateNumberOfRecords:(NSInteger)numberOfRecords;
@end
