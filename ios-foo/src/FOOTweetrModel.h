#import "FOOTweetrRequestor.h"

@protocol FOOTweetrModelDelegate <NSObject>

- (void)dateUpdated;

@end

@interface FOOTweetrModel : NSObject <FOOTweetrRequestor>

@property (nonatomic, weak) id <FOOTweetrModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context;

- (NSArray *)fetchAllTweetrRecords;


@end
