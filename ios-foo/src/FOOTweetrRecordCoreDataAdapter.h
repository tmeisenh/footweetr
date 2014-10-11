#import "FOOTweetrRecord.h"
#import "FOOCoreDataTweetrRecord.h"

@interface FOOTweetrRecordCoreDataAdapter : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (FOOCoreDataTweetrRecord *)convertTweetrRecordToCoreDataType:(FOOTweetrRecord *)tweetrRecord;

@end
