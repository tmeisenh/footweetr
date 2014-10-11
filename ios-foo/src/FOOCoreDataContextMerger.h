@interface FOOCoreDataContextMerger : NSObject

@property (nonatomic) NSManagedObjectContext *mainContext;
@property (nonatomic) NSManagedObjectContext *childContext;

- (instancetype)init;

@end
