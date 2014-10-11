#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewModel()

@property (nonatomic) FOOTweetrListingModel * tweetrListingModel;

@end

@implementation FOOTweetrListingViewModel

- (instancetype)initWithTweetrListingModel:(FOOTweetrListingModel *)tweetrListingModel {
    
    if (self = [super init]) {
        self.tweetrListingModel = tweetrListingModel;
    }
    return self;
}

-(NSArray *)fetchAllTweetrRecords {
    
    return [self.tweetrListingModel fetchAllTweetrRecords];
}

@end
