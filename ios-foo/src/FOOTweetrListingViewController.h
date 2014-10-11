#import <UIKit/UIKit.h>
#import "FOOTweetrRequestor.h"

@interface FOOTweetrListingViewController : UIViewController

- (instancetype)initWithTweetrRequestor:(id <FOOTweetrRequestor>)tweetrRequestor;

@end
