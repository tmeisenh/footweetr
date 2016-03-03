#import "FOOTweetrListingTableViewAdapter.h"

@interface FOOTweetrListingTableViewAdapter()

@property (nonatomic) id <IOBTableViewCellDecorator>cellDecorator;
@property (nonatomic) id <IOBTableViewSectionDecorator>sectionDecorator;
@property (nonatomic) id <IOBTableViewDataSource>dataSource;

@end

@implementation FOOTweetrListingTableViewAdapter

- (instancetype)initWithCellDecorator:(id<IOBTableViewCellDecorator>)cellDecorator
                     sectionDecorator:(id<IOBTableViewSectionDecorator>)sectionDecorator
                           dataSource:(id<IOBTableViewDataSource>)dataSource {
    
    if (self = [super init]) {
        _cellDecorator = cellDecorator;
        _sectionDecorator = sectionDecorator;
        _dataSource = dataSource;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.cellDecorator heightForItemAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    
    return [self.sectionDecorator heightForSectiontIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {

    return [self.sectionDecorator sectionViewAtIndex:section dataSourceEntityAtSection:[self.dataSource objectAtSection:section]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [self.cellDecorator cellForItemAtIndexPath:indexPath dataSourceEntityAtIndexPath:[self.dataSource objectAtIndexPath:indexPath] tableView:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataSource numberOfSections];
}

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [self.dataSource rem:indexPath];
    }
}


@end
