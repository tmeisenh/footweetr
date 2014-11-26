#import "FOONSDocumentsDirectoryLocator.h"

@interface FOOCoreDataFactory : NSObject

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithDocumentsDirectoryLocator:(FOONSDocumentsDirectoryLocator *)documentsDirectoryLocator;

- (NSManagedObjectContext *)createManagedObjectContextWithFileName:(NSString *)fileName;
- (NSManagedObjectContext *)createInMemoryManagedObjectContextWithName:(NSString *)name;

@end
