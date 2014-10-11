#import "FOOTweetrListingModel.h"
#import "FOOTweetrRecord.h"
#import "FOOCoreDataTweetrRecord.h"

@interface FOOTweetrListingModel() <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSFetchedResultsController *frc;
@end

@implementation FOOTweetrListingModel

-(instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context {
    if (self = [super init]) {
        self.context = context;
        [self createFetchesResultsControllersWithManagedObjectContext:self.context];
    }
    return self;
}

- (void)createFetchesResultsControllersWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"FOOCoreDataTweetrRecord"];
    NSSortDescriptor *filenameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [fetchRequest setSortDescriptors:@[filenameDescriptor]];
    self.frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                   managedObjectContext:managedObjectContext sectionNameKeyPath:nil
                                                              cacheName:@"metaDataCache"];
    self.frc.delegate = self;
    
}

-(NSArray *)fetchAllTweetrRecords {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([FOOCoreDataTweetrRecord class])];
    NSArray *unsorted = [self.context executeFetchRequest:request error:nil];
    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES selector:@selector(caseInsensitiveCompare:)];

    return [unsorted sortedArrayUsingDescriptors:@[sorter]];
}

- (NSString *)text:(NSString *)text number:(int)number {
    return [NSString stringWithFormat:@"%@_%i", text, number];
}

@end
