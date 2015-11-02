//
//  AccessToken.h
//  VKTest
//
//  Created by Александр on 30.10.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessToken : NSObject

@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * expireTime;
@property (nonatomic, assign) NSString * userID;

- (NSDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
