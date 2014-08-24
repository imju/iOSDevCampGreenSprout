//
//  GSMainNavigationController.m
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import "GSMainNavigationController.h"
#import "GSCitiesTableViewController.h"
#import "GSHomeViewController.h"
#import "GSBizTableViewController.h"

@interface GSMainNavigationController () <GSCitiesTableViewControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) NSString *selectedCity;

@end

@implementation GSMainNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
        self.selectedCity = @"Palo Alto";
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:0.44 green:0.66 blue:0.28 alpha:1];
    
    GSCitiesTableViewController *cities = [[GSCitiesTableViewController alloc] init];
    cities.title = self.selectedCity;  // HACK: to make the back button the city name
    cities.delegate = self;
    GSHomeViewController *home = [[GSHomeViewController alloc] initWithCity:self.selectedCity];
    [self pushViewController:cities animated:NO];
    [self pushViewController:home animated:NO];
}

- (NSString *)citiesTableViewControllerGetCurrentCity:(GSCitiesTableViewController *)controller{
    return self.selectedCity;
}

- (void)citiesTableViewController:(GSCitiesTableViewController *)controller didSelectCity:(NSString *)city{
    self.selectedCity = city;
    GSHomeViewController *home = [[GSHomeViewController alloc] initWithCity:city];
    controller.title = city;  // HACK: to make the back button the city name
    [self pushViewController:home animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if([viewController isKindOfClass:[GSCitiesTableViewController class]]){
        viewController.title = @"Cities";  // HACK: to change the title back to "Cities"
        [(GSCitiesTableViewController *)viewController updateSelectedCity:self.selectedCity];
    }
}

@end
