//
//  GSBizTableViewCell.m
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import "GSBizTableViewCell.h"

@interface GSBizTableViewCell ()

@end

@implementation GSBizTableViewCell

- (void)awakeFromNib
{
    UIView *view = self.textGradientView;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.textGradientView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.25 alpha:.8] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
