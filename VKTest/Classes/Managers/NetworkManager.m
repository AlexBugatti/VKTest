//
//  NetworkManager.m
//  VKTest
//
//  Created by Александр on 30.10.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking.h>

static NSString * kVkApiURL = @"https://api.vk.com/method";
static NSString * kVkAuthorizationURL = @"https://oauth.vk.com/authorize";

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
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
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

#pragma mark - methods

- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)clearToken {
    self.token = nil;
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"AuthorizeUser"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - requests

- (void)getNews:(void(^)(NSArray * news))completion offset:(NSInteger)offset onError:(void(^)(NSString *errorString))failure {
    
    NSLog(@"connected %d", [self connected]);
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
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

- (void)getUsers:(void(^)(NSArray *user))completion uids:(NSString *)uids onError:(void(^)(NSString *errorString))failure {
    
    NSDictionary *parameters = @{@"user_ids":      uids,
                                 @"fields":         @"photo_100",
                                 @"v":              kCurrentApiVersion};
    
    [self.requestManager GET:@"users.get" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //
        if ([responseObject objectForKey:@"response"]) {
            if (completion) {
                completion([responseObject objectForKey:@"response"]);
            }
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}

@end
