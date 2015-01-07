#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IOBTableViewDataSourceDelegate <NSObject>

@optional
- (void)addSection:(NSInteger)section;
- (void)removeSection:(NSInteger)section;
//- (void)reloadSection:(NSInteger)section;
//- (void)moveSectionFromOldIndex:(NSInteger)index
//                     toNewIndex:(NSInteger)newIndex;

- (void)addRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)moveRowFromOldIndexPath:(NSIndexPath *)oldIndexPath
                 toNewIndexPath:(NSIndexPath *)newIndexPath;

/// called before/after updates are about to occur
- (void)beginUpdates;
- (void)endUpdates;

@end

@protocol IOBTableViewDataSource <NSObject>

@required
- (void)loadData;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSObject *)objectAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSObject *)objectAtSection:(NSInteger)section;
- (NSInteger)numberOfTotalRows;
- (void)setDelegate:(id <IOBTableViewDataSourceDelegate>)delegate;

@end
