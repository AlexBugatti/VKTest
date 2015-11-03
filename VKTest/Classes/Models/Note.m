//
//  Note.m
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "Note.h"
#import <EasyMapping.h>
#import "MappingProvider.h"
#import "Attachment.h"

@implementation Note

- (instancetype)initWithProperties:(NSDictionary *)properties {
    if (self = [super init]) {
        [EKMapper fillObject:self fromExternalRepresentation:properties
                 withMapping:[MappingProvider noteMapping]];
    }
    return self;
}

- (NSInteger)numberOfAttachImages {
    NSInteger numberImage = 0;
    for (Attachment *attach in self.attachments) {
        if ([attach.type isEqualToString:@"photo"]) {
            numberImage++;
        }
    }
    return numberImage;
}

- (NSArray *)urlImages {
    NSMutableArray * paths = [NSMutableArray array];
    for (Attachment *attach in self.attachments) {
        if ([attach.type isEqualToString:@"photo"]) {
            [paths addObject:attach.photo];
        }
    }
    return paths;
}

@end
