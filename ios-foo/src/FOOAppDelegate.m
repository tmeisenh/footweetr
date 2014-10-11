#import "FOOAppDelegate.h"

#import "FOOTweetrListingViewController.h"
#import "FOOTweetrRequestor.h"

#import "FOOTweetrListingModel.h"

@implementation FOOAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    FOOTweetrListingModel *listingModel = [[FOOTweetrListingModel alloc] init];
    
    FOOTweetrListingViewController *viewController = [[FOOTweetrListingViewController alloc] initWithTweetrListingModel:listingModel];
    self.window.rootViewController = viewController;
    
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
