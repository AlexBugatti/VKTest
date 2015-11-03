//
//  Note.h
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Users.h"

@interface Note : NSObject

@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSNumber *date;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSString *fromID;
@property (nullable, nonatomic, retain) NSDictionary *likes;
@property (nullable, nonatomic, retain) NSDictionary *reposts;
@property (nullable, nonatomic, retain) NSArray *attachments;
@property (nullable, nonatomic, retain) Users *user;

- (instancetype)initWithProperties:(NSDictionary *)properties;
- (NSInteger)numberOfAttachImages;
- (NSArray *)urlImages;


@end
