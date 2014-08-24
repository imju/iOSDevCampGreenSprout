//
//  GSBizDetailsVIewController.h
//  GreenSprout
//
//  Created by Imju Byon on 8/23/14.
//
//

#import <UIKit/UIKit.h>

@interface GSBizDetailsHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *bizName;
@property (weak, nonatomic) IBOutlet UILabel *followerNum;
@property (weak, nonatomic) IBOutlet UILabel *reviewNum;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;
@property (weak, nonatomic) IBOutlet UITextView *moreInfo;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;


@end
