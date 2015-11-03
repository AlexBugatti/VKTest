//
//  Users.m
//  VKTest
//
//  Created by Александр on 02.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "Users.h"
#import <EasyMapping.h>
#import "MappingProvider.h"

@implementation Users

- (instancetype)initWithProperties:(NSDictionary *)properties {
    if (self = [super init]) {
        [EKMapper fillObject:self fromExternalRepresentation:properties
                 withMapping:[MappingProvider userMapping]];
    }
    return self;
}


@end
