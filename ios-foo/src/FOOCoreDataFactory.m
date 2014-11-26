#import "FOOCoreDataFactory.h"

@interface FOOCoreDataFactory ()

@property (nonatomic, strong) FOONSDocumentsDirectoryLocator *documentsDirectoryLocator;

@end

@implementation FOOCoreDataFactory

-(instancetype)initWithDocumentsDirectoryLocator:(FOONSDocumentsDirectoryLocator *)documentsDirectoryLocator {
    if (self = [super init]) {
        self.documentsDirectoryLocator = documentsDirectoryLocator;
    }
    return self;
}

- (NSManagedObjectContext *)createManagedObjectContextWithFileName:(NSString *)fileName {
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinatorWithName:fileName];
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return managedObjectContext;
}

- (NSManagedObjectContext *)createInMemoryManagedObjectContextWithName:(NSString *)name {
    
    NSPersistentStoreCoordinator *coordinator = [self inMemoryPersistentStoreCoordinatorWithName:name];
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModelWithName:(NSString *)name {
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:name withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithName:(NSString *)name {
    
    NSURL *storeURL = [[self.documentsDirectoryLocator applicationDocumentsDirectory] URLByAppendingPathComponent:[name stringByAppendingString:@".sqlite"]];
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModelWithName:name]];
    
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:storeURL
                                                   options:nil
                                                     error:nil];
    
    return persistentStoreCoordinator;
}

- (NSPersistentStoreCoordinator *)inMemoryPersistentStoreCoordinatorWithName:(NSString *)name {
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModelWithName:name]];
    
    [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                             configuration:nil
                                                       URL:nil
                                                   options:nil
                                                     error:nil];
    
    return persistentStoreCoordinator;
}

@end
