//
//  NewsProvider.m
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "MappingProvider.h"
#import "Users.h"
#import "Photo.h"
#import "Attachment.h"
#import "Note.h"

@implementation MappingProvider

+ (EKObjectMapping*)noteMapping
{
    return [EKObjectMapping mappingForClass:[Note class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapPropertiesFromArray:@[@"text", @"date"]];
        [mapping mapPropertiesFromDictionary:@{@"likes": @"likes",
                                               @"from_id": @"fromID"}];
        [mapping hasMany:[Attachment class] forKeyPath:@"attachments"];
    }];
}

+ (EKObjectMapping*)userMapping
{
    return [EKObjectMapping mappingForClass:[Users class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapPropertiesFromDictionary:@{
                                               @"id" : @"userID",
                                               @"first_name" : @"firstName",
                                               @"last_name": @"lastName",
                                               @"photo_100": @"photoURL"
                                               }];
    }];
}

+ (EKObjectMapping*)photoMapping
{
    return [EKObjectMapping mappingForClass:[Photo class] withBlock:^(EKObjectMapping *mapping) {
        [mapping mapPropertiesFromArray:@[@"height", @"weight", @"type"]];
        [mapping mapPropertiesFromDictionary:@{@"photo_604" : @"photoURL"}];
    }];
}

@end
