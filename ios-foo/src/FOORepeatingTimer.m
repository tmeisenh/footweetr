#import "FOORepeatingTimer.h"

@interface FOORepeatingTimer()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSTimeInterval timeInterval;

@end

@implementation FOORepeatingTimer

- (instancetype)initWithTimerInterval:(NSTimeInterval)timerInterval {
    if (self = [super init]) {
        self.timeInterval = timerInterval;
    }
    return self;
}

- (void)dealloc {
    [self stopTimer];
}

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval
                                                  target:self
                                                selector:@selector(timerFired)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer
                              forMode:NSDefaultRunLoopMode];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerFired {
    [self.delegate timerFired];
}

@end
