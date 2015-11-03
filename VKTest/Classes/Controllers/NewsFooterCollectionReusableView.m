//
//  NewsFooterCollectionReusableView.m
//  VKTest
//
//  Created by Александр on 02.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "NewsFooterCollectionReusableView.h"

@interface NewsFooterCollectionReusableView ()

@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UILabel *repostLabel;

@end

@implementation NewsFooterCollectionReusableView

- (void)configureView:(Note *)note {
    NSString *likes = note.likes[@"count"];
    NSString *reposts = note.reposts[@"count"];

    self.likeLabel.text = [NSString stringWithFormat:@"%d", likes.intValue];
    self.repostLabel.text = [NSString stringWithFormat:@"%d", reposts.intValue];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
