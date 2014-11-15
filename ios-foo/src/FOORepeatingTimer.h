#import <Foundation/Foundation.h>

@protocol FOORepeatingTimerDelegate <NSObject>

- (void)timerFired;

@end

@interface FOORepeatingTimer : NSObject

@property (nonatomic) id <FOORepeatingTimerDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithTimerInterval:(NSTimeInterval)timerInterval;

- (void)startTimer;
- (void)stopTimer;

@end
