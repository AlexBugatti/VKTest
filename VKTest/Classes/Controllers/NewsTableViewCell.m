//
//  NewsTableViewCell.m
//  VKTest
//
//  Created by Александр on 01.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *text;

@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureCell:(Note *)note {
    self.text.text = note.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
