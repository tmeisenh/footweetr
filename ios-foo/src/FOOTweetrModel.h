#import "FOOTweetrSyncer.h"

@protocol FOOTweetrModelDelegate <NSObject>

- (void)dateUpdated;

@end

@interface FOOTweetrModel : NSObject

@property (nonatomic, weak) id <FOOTweetrModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context
                                      syncer:(FOOTweetrSyncer *)syncer;

- (NSArray *)fetchAllTweetrRecords;
- (void)requestSync;

@end
