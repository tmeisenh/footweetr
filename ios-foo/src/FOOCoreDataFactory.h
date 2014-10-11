#import "FOONSDocumentsDirectoryLocator.h"

@interface FOOCoreDataFactory : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDocumentsDirectoryLocator:(FOONSDocumentsDirectoryLocator *)documentsDirectoryLocator;

- (NSManagedObjectContext *)createManagedObjectContext;
- (NSManagedObjectContext *)createInMemoryManagedObjectContext;

@end
