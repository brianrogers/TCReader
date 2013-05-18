//
//  TCRTableViewCell.m
//  TinCanReader
//
//  Created by Brian Rogers on 5/11/13.
//  Copyright (c) 2013 Brian Rogers. All rights reserved.
//

#import "TCRTableViewCell.h"

@implementation TCRTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
