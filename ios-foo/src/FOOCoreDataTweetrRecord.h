//
//  FOOCoreDataTweetrRecord.h
//  ios-foo
//
//  Created by Travis Meisenheimer on 12/30/14.
//  Copyright (c) 2014 asynchrony.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FOOCoreDataUserRecord;

@interface FOOCoreDataTweetrRecord : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) FOOCoreDataUserRecord *user;

@end
