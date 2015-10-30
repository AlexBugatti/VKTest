//
//  AuthorizeViewController.h
//  VKTest
//
//  Created by Александр on 30.10.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccessToken.h"

@interface AuthorizeViewController : UIViewController

typedef void(^completionBlock)(AccessToken *token);
- (instancetype)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle onComplete:(completionBlock)completion;

@end
