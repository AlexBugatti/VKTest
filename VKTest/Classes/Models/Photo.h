//
//  Photo.h
//  VKTest
//
//  Created by Александр on 03.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping.h>

@interface Photo : NSObject <EKMappingProtocol>

@property (nullable, nonatomic, retain) NSString *photoURL;
@property (nullable, nonatomic, retain) NSString *width;
@property (nullable, nonatomic, retain) NSString *height;
@property (nullable, nonatomic, retain) NSString *date;

@end
