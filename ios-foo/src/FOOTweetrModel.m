#import "FOOTweetrModel.h"
#import "FOOTweetrRecord.h"
#import "FOOCoreDataTweetrRecord.h"

@interface FOOTweetrModel() <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSFetchedResultsController *frc;
@property (nonatomic) FOOTweetrSyncer *syncer;
@end

@implementation FOOTweetrModel

-(instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context
                                     syncer:(FOOTweetrSyncer *)syncer {
    
    if (self = [super init]) {
        self.context = context;
        self.syncer = syncer;
        [self createFetchesResultsControllersWithManagedObjectContext:self.context];
    }
    return self;
}

- (void)createFetchesResultsControllersWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([FOOCoreDataTweetrRecord class])];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [request setSortDescriptors:@[sorter]];
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                   managedObjectContext:managedObjectContext
                                                     sectionNameKeyPath:nil
                                                              cacheName:nil];
    self.frc.delegate = self;
}

-(NSArray *)fetchAllTweetrRecords {
    
    [self.frc performFetch:nil];
    return self.frc.fetchedObjects;
}

- (NSString *)text:(NSString *)text number:(int)number {
    return [NSString stringWithFormat:@"%@_%i", text, number];
}

-(void)deleteAll {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([FOOCoreDataTweetrRecord class])];

    NSError *error;
    NSArray *fetchedObjects = [self.context executeFetchRequest:request error:&error];
    for (NSManagedObject *object in fetchedObjects)     {
        [self.context deleteObject:object];
    }
    [self.context save:&error];
}

- (void)deleteRecordAtIndex:(NSIndexPath *)index {
    FOOCoreDataTweetrRecord *record = [self.frc objectAtIndexPath:index];
    [self.context deleteObject:record];
    [self.context save:nil];
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
