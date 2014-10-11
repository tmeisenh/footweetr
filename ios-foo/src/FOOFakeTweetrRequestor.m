#import "FOOFakeTweetrRequestor.h"
#import "FOOTweetrRecord.h"

@implementation FOOFakeTweetrRequestor

-(NSArray *)fetchAllTweetrRecords {
    NSMutableArray *records = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 50; i++) {
        FOOTweetrRecord *record = [[FOOTweetrRecord alloc] initWithTitle:[self text:@"something" number:i]
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