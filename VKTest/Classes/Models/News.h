//
//  News.h
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface News : NSManagedObject

- (id)initWithProperties:(NSDictionary *)properties;

@end

NS_ASSUME_NONNULL_END

#import "News+CoreDataProperties.h"
