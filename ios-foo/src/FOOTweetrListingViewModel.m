#import "FOOTweetrListingViewModel.h"

@interface FOOTweetrListingViewModel() < FOOTweetrModelDelegate>

@property (nonatomic) FOOTweetrModel * tweetrModel;

@end

@implementation FOOTweetrListingViewModel

- (instancetype)initWithTweetrModel:(FOOTweetrModel *)tweetrModel {
    
    if (self = [super init]) {
        self.tweetrModel = tweetrModel;
        self.tweetrModel.delegate = self;
    }
    return self;
}

-(NSArray *)fetchAllTweetrRecords {
    
    NSArray * records = [self.tweetrModel fetchAllTweetrRecords];
    return records;
}

-(void)requestSync {
    [self.tweetrModel requestSync];
}

-(void)dateUpdated {
    [self.delegate dataChanged];
}

@end
