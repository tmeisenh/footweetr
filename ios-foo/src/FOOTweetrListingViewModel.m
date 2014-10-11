#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewModel() < FOOTweetrListingModelDelegate>

@property (nonatomic) FOOTweetrListingModel * tweetrListingModel;

@end

@implementation FOOTweetrListingViewModel

- (instancetype)initWithTweetrListingModel:(FOOTweetrListingModel *)tweetrListingModel {
    
    if (self = [super init]) {
        self.tweetrListingModel = tweetrListingModel;
        self.tweetrListingModel.delegate = self;
    }
    return self;
}

-(NSArray *)fetchAllTweetrRecords {
    
    NSArray * records = [self.tweetrListingModel fetchAllTweetrRecords];
    return records;
}

-(void)dateUpdated {
    [self.delegate dataChanged];
}

@end
