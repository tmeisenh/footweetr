#import "FOOTweetrSyncer.h"

@protocol FOOTweetrModelDelegate <NSObject>

- (void)dataInserted:(NSArray *)paths;
- (void)dataRemoved:(NSArray *)paths;
- (void)dataUpdated:(NSArray *)paths;

- (void)dataMoved:(NSIndexPath *)src dest:(NSIndexPath *)dest;

- (void)insertSections:(NSIndexSet *)sections;
- (void)removeSections:(NSIndexSet *)sections;
- (void)updateSections:(NSIndexSet *)sections;

- (void)beginUpdate;
- (void)endUpdate;

@end

@interface FOOTweetrModel : NSObject

@property (nonatomic, weak) id <FOOTweetrModelDelegate> delegate;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context
                                      syncer:(FOOTweetrSyncer *)syncer;

- (void)deleteAll;
- (void)deleteRecordAtIndex:(NSIndexPath *)index;
- (NSArray *)fetchAllTweetrRecords;
- (FOOCoreDataTweetrRecord *)dataForIndex:(NSIndexPath *)index;
- (FOOCoreDataUserRecord *)dataForSection:(NSInteger)section;
- (NSInteger)totalCount;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (void)requestSync;

@end
