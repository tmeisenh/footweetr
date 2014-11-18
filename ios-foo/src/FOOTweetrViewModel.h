#import <Foundation/Foundation.h>

@interface FOOTweetrViewModel : NSObject

- (void)refreshRequested;
- (void)refreshFinished;
- (BOOL)isRefreshOngoing;

@end
