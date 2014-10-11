@protocol FOOTweetrRequestor <NSObject>

/// Returns NSArray of FooTweetrRecord objects.
- (NSArray *)fetchAllTweetrRecords;

@end
