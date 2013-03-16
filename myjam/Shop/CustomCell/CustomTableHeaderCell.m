//
//  CustomTableHeaderCell.m
//  myjam
//
//  Created by Azad Johari on 3/16/13.
//  Copyright (c) 2013 me-tech. All rights reserved.
//

#import "CustomTableHeaderCell.h"

@implementation CustomTableHeaderCell
@synthesize catTitle;
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

-(void)dealloc{
    [catTitle release];
    [_middleLine release];
    [super dealloc];
}
@end
