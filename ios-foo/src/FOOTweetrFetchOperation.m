#import "FOOTweetrFetchOperation.h"

@interface FOOTweetrFetchOperation()

@property (nonatomic) id <FOOTweetrRequestor>tweetrRequestor;

@end

@implementation FOOTweetrFetchOperation

-(instancetype)initWithTweetrRequestor:(id<FOOTweetrRequestor>)tweetrRequestor {
    if (self = [super init]) {
        self.tweetrRequestor = tweetrRequestor;
    }
    return self;
}

-(BOOL)isConcurrent {
    return NO;
}

-(void)start {
    
}

@end
