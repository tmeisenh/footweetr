typedef void (^FOODispatcherMainthreadBlock)(void);

@interface FOODispatcher : NSObject

- (void)dispatchOnMainThreadBlock:(FOODispatcherMainthreadBlock)block;

@end
