//
//  GSBizDetailsTableViewController.h
//  GreenSprout
//
//  Created by Imju Byon on 8/23/14.
//
//

#import <UIKit/UIKit.h>
#import "GSBizDetailsHeaderView.h"
#import "GSBizDetailsCell.h"

@interface GSBizDetailsTableViewController : UITableViewController

- (instancetype)initWithBizObjectId:(NSString *)objectId;

@end
