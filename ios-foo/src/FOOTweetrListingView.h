#import "FOOTweetrRecord.h"

@protocol FOOTweetrListingViewDelegate <NSObject>

- (void)selectedRecord:(FOOTweetrRecord *)record;
- (void)updateRequested;
- (void)deletePressed;

- (FOOTweetrRecord *)dataForIndex:(NSInteger)index;
- (NSInteger)dataCount;

@end

@interface FOOTweetrListingView : UIView

@property (nonatomic, weak) id <FOOTweetrListingViewDelegate>delegate;

- (void)updateViewWithTweetrRecords:(NSArray *)tweetrRecords;

- (void)updateRows:(NSArray *)paths;
- (void)insertRows:(NSArray *)paths;
- (void)removeRows:(NSArray *)paths;
- (void)beginUpdate;
- (void)endUpdate;
- (void)refreshFinished;
@end
