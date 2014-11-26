#import "FOOAppDelegate.h"

#import "FOOTweetrListingViewController.h"
#import "FOOTweetrRequestor.h"

#import "FOONSDocumentsDirectoryLocator.h"
#import "FOOCoreDataFactory.h"
#import "FOOTweetrSyncer.h"
#import "FOODispatcher.h"
#import "FOOTweetrFetchOperationFactory.h"
#import "FOOBackgroundCoreDataFactory.h"
#import "FOOTweetrRecordCoreDataAdapter.h"
#import "FOOFakeRequestor.h"
#import "FOOTweetrModel.h"

@interface FOOAppDelegate()

@property (nonatomic) FOONSDocumentsDirectoryLocator *documentsLocator;
@property (nonatomic) FOOCoreDataFactory *coredataFactory;
@property (nonatomic) NSManagedObjectContext *mainContext;
@property (nonatomic) FOODispatcher *dispatcher;
@property (nonatomic) FOOBackgroundCoreDataFactory *backgroundCoreDataFactory;
@property (nonatomic) id <FOOTweetrRequestor> requestor;
@property (nonatomic) FOOTweetrFetchOperationFactory *operationFactory;
@property (nonatomic) FOOTweetrSyncer *syncer;
@property (nonatomic) FOORepeatingTimer *timer;
@end

@implementation FOOAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    self.documentsLocator = [[FOONSDocumentsDirectoryLocator alloc] init];
    self.coredataFactory = [[FOOCoreDataFactory alloc] initWithDocumentsDirectoryLocator:self.documentsLocator];
    self.mainContext = [self.coredataFactory createManagedObjectContextWithFileName:@"ios_foo"];
    self.dispatcher = [[FOODispatcher alloc] init];
    self.backgroundCoreDataFactory = [[FOOBackgroundCoreDataFactory alloc] init];
    self.requestor = [[FOOFakeRequestor alloc] init];
    self.operationFactory = [[FOOTweetrFetchOperationFactory alloc] initWithTweetrRequestor:self.requestor
                                                                  backgroundCoreDataFactory:self.backgroundCoreDataFactory];
    
    
    self.timer = [[FOORepeatingTimer alloc] initWithTimerInterval:5];
    self.syncer = [[FOOTweetrSyncer alloc] initWithManagedObjectContext:self.mainContext
                                                             dispatcher:self.dispatcher
                                                       operationFactory:self.operationFactory repeatingTimer:self.timer];
    
    FOOTweetrModel *listingModel = [[FOOTweetrModel alloc] initWithManagedObjectContext:self.mainContext syncer:self.syncer];
    
    FOOTweetrListingViewController *viewController = [[FOOTweetrListingViewController alloc] initWithTweetrModel:listingModel];
    self.window.rootViewController = viewController;
    [self.syncer sync];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
}



@end
