//
//  AccessToken.m
//  VKTest
//
//  Created by Александр on 30.10.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "AccessToken.h"

@implementation AccessToken

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.token = dictionary[@"token"];
        self.expireTime = dictionary[@"expireTime"];
        self.userID = dictionary[@"userID"];
    }
    return self;
}

- (NSDictionary *)dictionary {
    NSDictionary * dict = @{@"token":       self.token,
                            @"expireTime":  self.expireTime,
                            @"userID":      self.userID};
    return dict;
}

@end
