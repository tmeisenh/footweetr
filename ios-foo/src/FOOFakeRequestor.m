#import "FOOFakeRequestor.h"
#import "FOOTweetrRecord.h"
#import "FOOUnixTimeStampNow.h"

@implementation FOOFakeRequestor

-(NSArray *)fetchAllTweetrRecords {
    NSMutableArray *records = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        FOOTweetrRecord *record = [[FOOTweetrRecord alloc] initWithTitle:[FOOUnixTimeStampNow createTimestampForNow]
                                                                    user:[self text:@"someone" number:i]
                                                                 content:[self text:@"something happened" number:i]];
        [records addObject:record];
    }
    
    return records;
}

- (NSString *)text:(NSString *)text number:(int)number {
    return [NSString stringWithFormat:@"%@_%i", text, number];
}

@end
