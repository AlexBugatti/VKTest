//
//  News.m
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "News.h"
#import <EasyMapping.h>
#import "MappingProvider.h"

@implementation News

- (id)initWithProperties:(NSDictionary *)properties {
    if (self = [super init]) {
        [EKMapper fillObject:self fromExternalRepresentation:properties
                 withMapping:[MappingProvider newsMapping]];
    }
    return self;
}

@end
