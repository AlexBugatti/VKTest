//
//  Photo.m
//  VKTest
//
//  Created by Александр on 03.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "Photo.h"
#import "MappingProvider.h"
#include <EasyMapping.h>

@implementation Photo

+ (EKObjectMapping*)objectMapping
{
    return [EKObjectMapping mappingForClass:self withBlock:^(EKObjectMapping *mapping) {
        [mapping mapPropertiesFromArray:@[@"height", @"width", @"date"]];
        [mapping mapPropertiesFromDictionary:@{@"photo_604" : @"photoURL"}];
    }];
}

@end
