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
@property (weak, nonatomic) IBOutlet UILabel *moreInfo;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;

@end
