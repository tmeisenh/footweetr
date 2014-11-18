#import <Foundation/Foundation.h>

#import "FOOTweetrListingView.h"
#import "FOOTweetrModel.h"
#import "FOOTweetrViewModel.h"

@interface FOOTweetrListingPresenter : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithModel:(FOOTweetrModel *)model
                         view:(FOOTweetrListingView *)view
                    viewModel:(FOOTweetrViewModel *)viewModel;

/* To keep ViewController's thin I usually just delegate the lifecycle things into the presenter with methods. */

- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

@end
