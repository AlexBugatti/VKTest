//
//  NetworkManager.h
//  VKTest
//
//  Created by Александр on 30.10.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccessToken.h"

@interface NetworkManager : NSObject

@property (nonatomic, strong) AccessToken *token;

+ (NetworkManager*) sharedInstance;

- (void)getNews:(void(^)(NSArray * news))completion offset:(NSInteger)offset onError:(void(^)(NSError *error))failure;
- (void)getUsers:(void(^)(NSArray *user))completion uids:(NSString *)uids onError:(void(^)(NSError *error))failure;

@end
