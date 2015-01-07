#import "FOOTweetrSyncer.h"
#import "IOBTableViewDataSource.h"

@protocol FOOTweetrModelDelegate <NSObject>

- (void)setViewDataSource:(id <IOBTableViewDataSource>)dataSource;
- (void)syncFinished;

@end

@interface FOOTweetrModel : NSObject

@property (nonatomic, weak) id <FOOTweetrModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context
                                      syncer:(FOOTweetrSyncer *)syncer;

- (void)viewNeedsData;
- (void)deleteAll;
- (void)deleteRecordAtIndex:(NSIndexPath *)index;
- (void)requestSync;

@end
