//
//  FOOCoreDataUserRecord.h
//  ios-foo
//
//  Created by Travis Meisenheimer on 12/30/14.
//  Copyright (c) 2014 asynchrony.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FOOCoreDataTweetrRecord;

@interface FOOCoreDataUserRecord : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *tweetrs;
@end

@interface FOOCoreDataUserRecord (CoreDataGeneratedAccessors)

- (void)addTweetrsObject:(FOOCoreDataTweetrRecord *)value;
- (void)removeTweetrsObject:(FOOCoreDataTweetrRecord *)value;
- (void)addTweetrs:(NSSet *)values;
- (void)removeTweetrs:(NSSet *)values;

@end
