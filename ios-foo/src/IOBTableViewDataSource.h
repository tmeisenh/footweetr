#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IOBTableViewDataSourceDelegate <NSObject>

@optional
- (void)removeSection:(NSInteger)section;
- (void)addSection:(NSInteger)section;

- (void)removeRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)reloadRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)insertRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)moveRowFromOldIndexPath:(NSIndexPath *)oldIndexPath toNewIndexPath:(NSIndexPath *)newIndexPath;

@end

@protocol IOBTableViewDataSource <NSObject>

@required
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSObject *)objectAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSObject *)objectAtSection:(NSInteger)section;

@end
