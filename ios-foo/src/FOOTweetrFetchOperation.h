#import "FOOTweetrRequestor.h"

@interface FOOTweetrFetchOperation : NSOperation

- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor;

@end
