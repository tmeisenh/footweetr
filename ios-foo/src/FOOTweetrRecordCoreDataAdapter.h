#import "FOOTweetrRecord.h"
#import "FOOCoreDataTweetrRecord.h"
#import "FOOCoreDataUserRecord.h"

@interface FOOTweetrRecordCoreDataAdapter : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (FOOCoreDataTweetrRecord *)convertTweetrRecordToCoreDataType:(FOOTweetrRecord *)tweetrRecord user:(FOOCoreDataUserRecord *)user;

@end
