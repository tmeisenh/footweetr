#import "FOOTweetrRequestor.h"

@protocol FOOTweetrListingModelDelegate <NSObject>

- (void)dateUpdated;

@end

@interface FOOTweetrListingModel : NSObject <FOOTweetrRequestor>

@property (nonatomic, weak) id <FOOTweetrListingModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (NSArray *)fetchAllTweetrRecords;


@end
