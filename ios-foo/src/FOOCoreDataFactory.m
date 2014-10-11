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

- (NSManagedObjectContext *)createManagedObjectContext {

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return managedObjectContext;
}

- (NSManagedObjectContext *)createInMemoryManagedObjectContext {
    
    NSPersistentStoreCoordinator *coordinator = [self inMemoryPersistentStoreCoordinator];
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ios_foo" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    NSURL *storeURL = [[self.documentsDirectoryLocator applicationDocumentsDirectory] URLByAppendingPathComponent:@"ios_foo.sqlite"];
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:storeURL
                                                     options:nil
                                                       error:nil];
    
    return persistentStoreCoordinator;
}

- (NSPersistentStoreCoordinator *)inMemoryPersistentStoreCoordinator {
    
        NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    [persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType
                                             configuration:nil
                                                       URL:nil
                                                   options:nil
                                                     error:nil];
    
    return persistentStoreCoordinator;
}


@end
