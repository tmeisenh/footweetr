#import "FOODispatcher.h"

@implementation FOODispatcher

-(void)dispatchOnMainThreadBlock:(FOODispatcherMainthreadBlock)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

@end
