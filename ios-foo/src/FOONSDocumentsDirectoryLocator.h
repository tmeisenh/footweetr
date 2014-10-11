@interface FOONSDocumentsDirectoryLocator : NSObject

- (instancetype)init;
- (instancetype)initWithFileManager:(NSFileManager *)fileManager;

- (NSURL *)applicationDocumentsDirectory;


@end
