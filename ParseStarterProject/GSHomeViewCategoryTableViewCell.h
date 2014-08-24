//
//  GSHomeViewCategoryTableViewCell.h
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import <UIKit/UIKit.h>

@protocol GSHomeViewCategoryTableViewCellDelegate;

@interface GSHomeViewCategoryTableViewCell : UITableViewCell

@property (weak, nonatomic) id<GSHomeViewCategoryTableViewCellDelegate> delegate;

@end

@protocol GSHomeViewCategoryTableViewCellDelegate <NSObject>

- (void)homeViewCategoryTableViewCell:(GSHomeViewCategoryTableViewCell *)cell didSelectCategory:(NSString *)category;

@end