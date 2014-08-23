//
//  GSCitiesTableViewController.h
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import <UIKit/UIKit.h>

@protocol GSCitiesTableViewControllerDelegate;

@interface GSCitiesTableViewController : UITableViewController

@property (weak, nonatomic) id<GSCitiesTableViewControllerDelegate> delegate;

- (void)updateSelectedCity:(NSString *)city;

@end

@protocol GSCitiesTableViewControllerDelegate <NSObject>

- (NSString *)citiesTableViewControllerGetCurrentCity:(GSCitiesTableViewController *)controller;
- (void)citiesTableViewController:(GSCitiesTableViewController *)controller didSelectCity:(NSString *)city;

@end