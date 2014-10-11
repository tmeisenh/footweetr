#import "FOOUnixTimeStampNow.h"

@implementation FOOUnixTimeStampNow

+ (NSString *)createTimestampForNow {
    NSTimeInterval unix = [[[NSDate alloc] init] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f", unix];
}

@end
