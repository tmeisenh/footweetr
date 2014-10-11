#import "FOOTweetrRecord.h"
#import "FOOCoreDataTweetrRecord.h"

@interface FOOTweetrRecordCoreDataAdapter : NSObject

- (FOOCoreDataTweetrRecord *)convertTweetrRecordToCoreDataType:(FOOTweetrRecord *)tweetrRecord;

@end
