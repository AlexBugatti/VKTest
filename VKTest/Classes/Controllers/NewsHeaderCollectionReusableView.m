//
//  NewsHeaderCollectionReusableView.m
//  VKTest
//
//  Created by Александр on 02.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "NewsHeaderCollectionReusableView.h"
#import <DateTools.h>
#import <UIImageView+AFNetworking.h>

@interface NewsHeaderCollectionReusableView ()

@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation NewsHeaderCollectionReusableView

- (void)configureView:(Note *)note {
    [self.photoView setImageWithURL:[NSURL URLWithString:note.user.photoURL]];
    
    NSString *timeAgo = [NSDate timeAgoSinceDate:[NSDate dateWithTimeIntervalSince1970:note.date.integerValue]];
    self.dateLabel.text = timeAgo;
    self.usernameLabel.text = [NSString stringWithFormat:@"%@ %@", note.user.firstName, note.user.lastName];
}

//- (void)configureUser:(User *)note {
//    NSString *timeAgo = [NSDate timeAgoSinceDate:[NSDate dateWithTimeIntervalSince1970:note.date.integerValue]];
//    self.dateLabel.text = timeAgo;
//}

- (void)awakeFromNib {
    self.photoView.layer.cornerRadius = self.photoView.frame.size.width / 2;
    // Initialization code
}

@end
