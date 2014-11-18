#import "FOOTweetrSyncer.h"

@protocol FOOTweetrModelDelegate <NSObject>

- (void)dataInserted:(NSArray *)paths;
- (void)dataRemoved:(NSArray *)paths;
- (void)dataUpdated:(NSArray *)paths;

- (void)beginUpdate;
- (void)endUpdate;

@end

@interface FOOTweetrModel : NSObject

@property (nonatomic, weak) id <FOOTweetrModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context
                                      syncer:(FOOTweetrSyncer *)syncer;

- (void)deleteAll;
- (void)deleteRecordAtIndex:(NSUInteger)index;
- (NSArray *)fetchAllTweetrRecords;
- (void)requestSync;

@end
