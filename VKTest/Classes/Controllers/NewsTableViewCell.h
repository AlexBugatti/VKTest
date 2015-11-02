//
//  NewsTableViewCell.h
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NewsTableViewCell : UITableViewCell

- (void)configureCell:(Note *)note;

@end
