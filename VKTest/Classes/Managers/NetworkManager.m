//
//  NetworkManager.m
//  VKTest
//
//  Created by Александр on 30.10.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking.h>
#import "User.h"

static NSString * kVkApiURL = @"https://api.vk.com/method";
static NSString * kVkAuthorizationURL = @"https://oauth.vk.com/authorize";

static NSInteger kClientID = 5127395;
static NSString * kRedirectURI = @"https://vk.com";
static NSString * kCurrentApiVersion = @"5.37";

@interface NetworkManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end

@implementation NetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary * dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"AuthorizeUser"];
        if (dict) self.token = [[AccessToken alloc] initWithDictionary:dict];

        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kVkApiURL]];
    }
    return self;
}

+ (NetworkManager *)sharedInstance {
    
    static NetworkManager *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[NetworkManager alloc] init];
    });
    
    return sharedManager;
}

#pragma mark - get methods

- (void)getNews:(void(^)(NSArray * news))completion offset:(NSInteger)offset onError:(void(^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"filters":        @"post",
                                 @"count":          @"15",
                                 @"v":              kCurrentApiVersion,
                                 @"offset":         @(offset),
                                 @"access_token":   self.token.token};
    
    [self.requestManager GET:@"wall.get" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //
        if ([responseObject objectForKey:@"response"]) {
            if (completion) {
                completion([[responseObject objectForKey:@"response"] objectForKey:@"items"]);
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        //
    }];
}

- (void)getUsers:(void(^)(NSArray *user))completion uids:(NSString *)uids onError:(void(^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"user_ids":      uids,
                                 @"fields":         @"photo_200",
                                 @"v":              kCurrentApiVersion};
    
    [self.requestManager GET:@"users.get" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //
        if ([responseObject objectForKey:@"response"]) {
            if (completion) {
                completion([responseObject objectForKey:@"response"]);
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        //
    }];
}

@end
