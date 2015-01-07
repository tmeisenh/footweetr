#import "FOOTweetrModel.h"
#import "FOOTweetrRecord.h"
#import "FOOCoreDataTweetrRecord.h"
#import "FOOTweetrListingTableViewDataSource.h"

#define  FOOTweetrModel_Cache @"TweetrCache"

@interface FOOTweetrModel()

@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic) FOOTweetrSyncer *syncer;
@property (nonatomic) id <IOBTableViewDataSourceDelegate> viewDS;

@end

@implementation FOOTweetrModel

-(instancetype)initWithManagedObjectContext:(NSManagedObjectContext *)context
                                     syncer:(FOOTweetrSyncer *)syncer {
    
    if (self = [super init]) {
        _syncer = syncer;
        _context = context;
        
        id <IOBTableViewDataSource> tableViewData = [[FOOTweetrListingTableViewDataSource alloc] initWithManagedObjectContext:context];
        _viewDS = tableViewData;
        
    }
    return self;
}


-(NSArray *)fetchAllTweetrRecords {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"FOOTweetrRecord"];
    return [self.context executeFetchRequest:request error:nil];
}

- (NSString *)text:(NSString *)text number:(int)number {
    return [NSString stringWithFormat:@"%@_%i", text, number];
}

-(void)deleteAll {
    NSArray *fetchedObjects = [self fetchAllTweetrRecords];
    for (NSManagedObject *object in fetchedObjects)     {
        [self.context deleteObject:object];
    }
    [self.context save:nil];
}

- (void)deleteRecordAtIndex:(NSIndexPath *)index {

}

- (void)viewNeedsData {
    [self.delegate setViewDataSource:self.viewDS];
}


-(void)requestSync {
    [self.syncer scheduleNewSyncJobs];
    [self.delegate syncFinished]; // lazy!
}


@end
