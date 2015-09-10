//
//  MenuTableViewCell.m
//  sead40_hw6
//
//  Created by Joao Paulo Galvao Alves on 9/10/15.
//  Copyright (c) 2015 jalvestech. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  
  if (self) {
    
    self.titleLabel = [[UILabel alloc]init];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.titleLabel setNumberOfLines:1];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.titleLabel];
    
  }
  
  return self;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
