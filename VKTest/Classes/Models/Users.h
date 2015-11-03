//
//  Users.h
//  VKTest
//
//  Created by Александр on 02.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject

@property (nonatomic, retain) NSNumber *userID;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *photoURL;

- (instancetype)initWithProperties:(NSDictionary *)properties;


@end
