#import "FOOTweetrRecord.h"

@protocol FOOFOOTweetrListingViewDelegate <NSObject>

- (void)selectedRecord:(FOOTweetrRecord *)record;

@end

@interface FOOFOOTweetrListingView : UIView

@property (nonatomic, weak) id <FOOFOOTweetrListingViewDelegate>delegate;

- (void)updateViewWithTweetrRecords:(NSArray *)tweetrRecords;

@end
