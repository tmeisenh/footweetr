#import "FOOTweetrRequestor.h"

@interface FOOTweetrListingViewModel : NSObject

- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor;

- (NSArray *)fetchAllTweetrRecords;

@end
