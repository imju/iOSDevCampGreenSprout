//
//  GSBizTableViewCell.h
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import <UIKit/UIKit.h>

@interface GSBizTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIView *textGradientView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;

@end
