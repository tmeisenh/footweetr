#import "FOOTweetrViewModel.h"

@interface FOOTweetrViewModel()

@property (nonatomic) BOOL isRefreshing;

@end

@implementation FOOTweetrViewModel

- (BOOL)isRefreshOngoing {
    return self.isRefreshing;
}

- (void)refreshRequested {
    self.isRefreshing = YES;
}

- (void)refreshFinished {
    self.isRefreshing = NO;
}

@end
