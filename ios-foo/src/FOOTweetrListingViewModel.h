#import "FOOTweetrListingModel.h"

@protocol FOOTweetrListingViewModelDelegate <NSObject>

- (void)dataChanged;

@end

@interface FOOTweetrListingViewModel : NSObject

@property (nonatomic, weak) id <FOOTweetrListingViewModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithTweetrListingModel:(FOOTweetrListingModel *)tweetrListingModel;

- (NSArray *)fetchAllTweetrRecords;

@end
