#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewModel()

@property (nonatomic) id <FOOTweetrRequestor> tweetrRequestor;

@end

@implementation FOOTweetrListingViewModel

-(instancetype)initWithTweetrRequestor:(id<FOOTweetrRequestor>)tweetrRequestor {
    if (self = [super init]) {
        self.tweetrRequestor = tweetrRequestor;
    }
    return self;
}

-(NSArray *)fetchAllTweetrRecords {
    
    return [self.tweetrRequestor fetchAllTweetrRecords];
}

@end
