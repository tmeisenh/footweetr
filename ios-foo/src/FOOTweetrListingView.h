#import "FOOTweetrRecord.h"

@protocol FOOTweetrListingViewDelegate <NSObject>

- (void)selectedRecord:(FOOTweetrRecord *)record;
- (void)updateRequested;
@end

@interface FOOTweetrListingView : UIView

@property (nonatomic, weak) id <FOOTweetrListingViewDelegate>delegate;

- (void)updateViewWithTweetrRecords:(NSArray *)tweetrRecords;

@end
