#import "FOOTweetrModel.h"

@protocol FOOTweetrListingViewModelDelegate <NSObject>

- (void)dataChanged;

@end

@interface FOOTweetrListingViewModel : NSObject

@property (nonatomic, weak) id <FOOTweetrListingViewModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithTweetrModel:(FOOTweetrModel *)tweetrModel;

- (NSArray *)fetchAllTweetrRecords;

@end
