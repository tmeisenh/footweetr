#import "FOOTweetrListingTableViewDataSource.h"

#import "FOOTweetrRecord.h"
#import "FOOCoreDataTweetrRecord.h"

@interface FOOTweetrListingTableViewDataSource() <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *fetchController;

@end

@implementation FOOTweetrListingTableViewDataSource

- (instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    if (self = [super init]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([FOOCoreDataTweetrRecord class])];
        [request setFetchBatchSize:20];
        NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"user.name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
        
        [request setSortDescriptors:@[nameSorter, sorter]];
        
        NSFetchedResultsController *fetchController  = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                                           managedObjectContext:context
                                                                                             sectionNameKeyPath:@"user.name"
                                                                                                      cacheName:nil];
        _fetchController = fetchController;
        _fetchController.delegate = self;
        
    }
    return self;
}

- (void)loadData {
    [self.fetchController performFetch:nil];
}

- (NSInteger)numberOfTotalRows {
    return [[self.fetchController fetchedObjects] count];
}

- (NSInteger)numberOfSections {
    return [[self.fetchController sections] count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSObject *)objectAtIndexPath:(NSIndexPath *)indexPath {
    return [self.fetchController objectAtIndexPath:indexPath];
}

- (NSObject *)objectAtSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchController sections] objectAtIndex:section];
    
    return [sectionInfo name];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.delegate beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.delegate endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller
 didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
          atIndex:(NSUInteger)sectionIndex
    forChangeType:(NSFetchedResultsChangeType)type {
    
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.delegate addSection:sectionIndex];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.delegate removeSection:sectionIndex];
            break;
        }

        default:
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject
      atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.delegate addRowAtIndexPath:newIndexPath];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.delegate removeRowAtIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self.delegate reloadRowAtIndexPath:indexPath];
            break;
        }
        case NSFetchedResultsChangeMove: {
            [self.delegate moveRowFromOldIndexPath:indexPath
                                    toNewIndexPath:newIndexPath];
            break;
        }
        default:
            break;
    }
}

@end
