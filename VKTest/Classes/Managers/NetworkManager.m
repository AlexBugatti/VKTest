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

@interface NetworkManager ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *requestManager;

@end

@implementation NetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
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

- (void)autorizationUser:(void(^)(User *user))completion {

}

@end
