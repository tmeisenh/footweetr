#import "FOOCoreDataTweetrRecord.h"
#import "FOOCoreDataUserRecord.h"

@protocol FOOTweetrListingViewDelegate <NSObject>

- (void)selectedRecord:(FOOCoreDataTweetrRecord *)record;
- (void)updateRequested;
- (void)deletePressed;
- (NSInteger)dataCount;

- (FOOCoreDataTweetrRecord *)dataForIndex:(NSIndexPath *)index;
- (NSString *)sectionValue:(NSInteger)section;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;
- (void)swipeToDelete:(NSIndexPath *)index;

@end

@interface FOOTweetrListingView : UIView

@property (nonatomic, weak) id <FOOTweetrListingViewDelegate>delegate;

- (void)reloadTableView;

- (void)updateRows:(NSArray *)paths;
- (void)insertRows:(NSArray *)paths;
- (void)removeRows:(NSArray *)paths;

- (void)beginUpdate;
- (void)endUpdate;
- (void)insertSections:(NSIndexSet *)sections;
- (void)removeSections:(NSIndexSet *)sections;
- (void)updateSections:(NSIndexSet *)sections;


- (void)refreshFinished;
- (void)updateNumberOfRecords:(NSInteger)numberOfRecords;
@end
