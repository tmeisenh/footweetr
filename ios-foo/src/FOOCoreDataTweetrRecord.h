//
//  FOOCoreDataTweetrRecord.h
//  ios-foo
//
//  Created by dev1 on 10/11/14.
//  Copyright (c) 2014 asynchrony.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FOOCoreDataTweetrRecord : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * user;
@property (nonatomic, retain) NSString * content;

@end
