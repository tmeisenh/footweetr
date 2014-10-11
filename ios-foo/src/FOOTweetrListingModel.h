#import "FOOTweetrRequestor.h"

@interface FOOTweetrListingModel : NSObject <FOOTweetrRequestor>

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (NSArray *)fetchAllTweetrRecords;


@end
