#import "FOOTweetrRecord.h"

@interface FOOTweetrRecord()

@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *user;
@property (nonatomic, readwrite) NSString *content;

@end

@implementation FOOTweetrRecord

-(instancetype)initWithTitle:(NSString *)title user:(NSString *)user content:(NSString *)content {
    if (self = [super init]) {
        self.title = title;
        self.user = user;
        self.content = content;
    }
    return self;
}

@end
