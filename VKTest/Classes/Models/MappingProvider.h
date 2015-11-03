//
//  NewsProvider.h
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping.h>

@interface MappingProvider : NSObject

+ (EKObjectMapping *)noteMapping;
+ (EKObjectMapping*)userMapping;
+ (EKObjectMapping*)photoMapping;

@end
