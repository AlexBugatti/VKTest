//
//  NewsFooterCollectionReusableView.h
//  VKTest
//
//  Created by Александр on 02.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NewsFooterCollectionReusableView : UICollectionReusableView

- (void)configureView:(Note *)note;

@end
