#import "FOOTweetrModel.h"
#import "FOOTweetrRecord.h"
#import "FOOCoreDataTweetrRecord.h"

#define  FOOTweetrModel_Cache @"TweetrCache"

@interface FOOTweetrModel() <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSFetchedResultsController *frc;
@property (nonatomic) FOOTweetrSyncer *syncer;
@end

@implementation FOOTweetrModel

-(instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context
                                     syncer:(FOOTweetrSyncer *)syncer {
    
    if (self = [super init]) {
        self.syncer = syncer;
        [self createFetchesResultsControllersWithManagedObjectContext:context];
    }
    return self;
}

- (void)createFetchesResultsControllersWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([FOOCoreDataTweetrRecord class])];
    [request setFetchBatchSize:20];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [request setSortDescriptors:@[sorter]];
    
    /**
     Having a cache seems buggy as hell when it comes to deleting either a single row
     or all the records.  See README.md
     */
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                   managedObjectContext:managedObjectContext
                                                     sectionNameKeyPath:nil
                                                              cacheName:nil];
    self.frc.delegate = self;
    [self.frc performFetch:nil];
}

-(NSArray *)fetchAllTweetrRecords {
    return self.frc.fetchedObjects;
}

- (NSString *)text:(NSString *)text number:(int)number {
    return [NSString stringWithFormat:@"%@_%i", text, number];
}

-(void)deleteAll {

    NSArray *fetchedObjects = [self fetchAllTweetrRecords];
    for (NSManagedObject *object in fetchedObjects)     {
        [self.frc.managedObjectContext deleteObject:object];
    }
    [self.frc.managedObjectContext save:nil];
}

- (void)deleteRecordAtIndex:(NSIndexPath *)index {
    FOOCoreDataTweetrRecord *record = [self.frc objectAtIndexPath:index];
    [self.frc.managedObjectContext deleteObject:record];
    [self.frc.managedObjectContext save:nil];
}

-(void)requestSync {
    [self.syncer scheduleNewSyncJobs];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.delegate beginUpdate];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.delegate endUpdate];
}


-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject
      atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeInsert: {
            [self.delegate dataInserted:@[newIndexPath]];
            break;
        }
        case NSFetchedResultsChangeDelete: {
            [self.delegate dataRemoved:@[indexPath]];
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [self.delegate dataUpdated:@[newIndexPath]];
            break;
        }
        default:
            break;
    }
}

@end
