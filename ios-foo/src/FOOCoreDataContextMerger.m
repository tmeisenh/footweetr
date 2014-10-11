#import "FOOCoreDataContextMerger.h"
#import "FOODispatcher.h"

@interface FOOCoreDataContextMerger()

@property (nonatomic) FOODispatcher *dispatcher;

@end

@implementation FOOCoreDataContextMerger

-(instancetype)init {
    
    if (self = [super init]) {
        self.dispatcher = [[FOODispatcher alloc] init];
    }
    return self;
}

-(void)setChildContext:(NSManagedObjectContext *)childContext {
    _childContext = childContext;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mergeCoreData:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:childContext];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)mergeCoreData:(NSNotification *)notification {
    /* notification occurs on background thread, merge it on main thread. */
    [self.dispatcher dispatchOnMainThreadBlock:^{
        [self.mainContext mergeChangesFromContextDidSaveNotification:notification];
    }];
}

@end
