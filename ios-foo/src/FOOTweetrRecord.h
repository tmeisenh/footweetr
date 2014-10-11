@interface FOOTweetrRecord : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *user;
@property (nonatomic, readonly) NSString *content;

- (instancetype)initWithTitle:(NSString *)title user:(NSString *)user content:(NSString *)content;

@end
