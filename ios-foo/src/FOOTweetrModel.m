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
                                                              cacheName:@"metaDataCache"];
    self.frc.delegate = self;
}

-(NSArray *)fetchAllTweetrRecords {
    
    [self.frc performFetch:nil];
    return self.frc.fetchedObjects;
}

- (NSString *)text:(NSString *)text number:(int)number {
    return [NSString stringWithFormat:@"%@_%i", text, number];
}

-(void)requestSync {
    [self.syncer sync];
}

-(void)controller:(NSFetchedResultsController *)controller
  didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
    forChangeType:(NSFetchedResultsChangeType)type
     newIndexPath:(NSIndexPath *)newIndexPath {
    
    [self.delegate dateUpdated];
}

@end
