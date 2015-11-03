//
//  Attachment.m
//  VKTest
//
//  Created by Александр on 03.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "Attachment.h"
#import "Photo.h"

@implementation Attachment

+ (EKObjectMapping*)objectMapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping mapPropertiesFromArray:@[@"type"]];
        [mapping hasOne:[Photo class] forKeyPath:@"photo"];
        //[mapping hasMany:[Photo class] forKeyPath:@"photos"];
    }];
}

@end
