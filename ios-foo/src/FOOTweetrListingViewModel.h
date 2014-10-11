#import "FOOTweetrListingModel.h"

@interface FOOTweetrListingViewModel : NSObject

- (instancetype)initWithTweetrListingModel:(FOOTweetrListingModel *)tweetrListingModel;

- (NSArray *)fetchAllTweetrRecords;

@end
