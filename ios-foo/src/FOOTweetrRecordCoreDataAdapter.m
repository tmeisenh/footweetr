#import "FOOTweetrRecordCoreDataAdapter.h"

@interface FOOTweetrRecordCoreDataAdapter()

@property (nonatomic) NSManagedObjectContext *context;

@end

@implementation FOOTweetrRecordCoreDataAdapter

-(instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    if (self = [super init]) {
        self.context = context;
    }
    return self;
}

-(FOOCoreDataTweetrRecord *)convertTweetrRecordToCoreDataType:(FOOTweetrRecord *)tweetrRecord user:(FOOCoreDataUserRecord *)user {
    FOOCoreDataTweetrRecord *coreDataRecord =  [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([FOOCoreDataTweetrRecord class])
                                                                             inManagedObjectContext:self.context];
    
    coreDataRecord.title = tweetrRecord.title;
    coreDataRecord.user = user;
    coreDataRecord.content = tweetrRecord.content;
    
    return coreDataRecord;
}

@end
