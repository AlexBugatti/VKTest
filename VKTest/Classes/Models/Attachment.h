//
//  Attachment.h
//  VKTest
//
//  Created by Александр on 03.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyMapping.h>
#import "Photo.h"

@interface Attachment : NSObject <EKMappingProtocol>

@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) Photo *photo;

@end
