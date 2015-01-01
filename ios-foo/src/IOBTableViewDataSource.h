#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IOBTableViewDataSource <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSObject *)objectAtSection:(NSInteger)section;
- (NSObject *)objectAtIndexPath:(NSIndexPath *)indexPath;

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

@end
