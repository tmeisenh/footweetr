#import "FOONSDocumentsDirectoryLocator.h"

@interface FOONSDocumentsDirectoryLocator()

@property (nonatomic) NSFileManager *fileManager;

@end

@implementation FOONSDocumentsDirectoryLocator

- (instancetype)init {
    return [self initWithFileManager:[NSFileManager defaultManager]];
}

- (instancetype)initWithFileManager:(NSFileManager *)fileManager {
    if (self = [super init]) {
        self.fileManager = fileManager;
    }
    return self;
}

- (NSURL *)applicationDocumentsDirectory {
    NSArray *urls = [self.fileManager URLsForDirectory:NSDocumentDirectory
                                             inDomains:NSUserDomainMask];
    return [urls lastObject];
}

@end
