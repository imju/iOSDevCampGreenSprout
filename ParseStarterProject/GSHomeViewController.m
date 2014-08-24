//
//  GSHomeViewController.m
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import <Parse/Parse.h>
#import "GSHomeViewController.h"
#import "GSHomeViewCategoryTableViewCell.h"
#import "GSBizTableViewCell.h"
#import "GSParseHelper.h"
#import "GSBizTableViewController.h"
#import "GSBizDetailsTableViewController.h"

@interface GSHomeViewController () <GSHomeViewCategoryTableViewCellDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) UITableViewCell *searchCell;
@property (strong, nonatomic) UITableViewCell *cateogoriesCell;
@property (strong, nonatomic) UITableViewCell *upcomingEventsTitleCell;

@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) NSDictionary *imageDictionary;

@end

@implementation GSHomeViewController

- (instancetype)initWithCity:(NSString *)city{
    self = [super init];
    if(self){
        self.city = city;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"GreenSprout", @"App title");

    [self.tableView registerNib:[UINib nibWithNibName:@"GSBizTableViewCell" bundle:nil] forCellReuseIdentifier:@"GSBizTableViewCellIdentifier"];
    self.tableView.rowHeight = 140;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [GSParseHelper queryBizWithCity:self.city category:nil searchString:nil andBlock:^(NSArray *objects, NSDictionary *images, NSError *error) {
        if(!error && [objects count] > 0){
            self.objects = objects;
            self.imageDictionary = images;
            [self.tableView reloadData];
        }
    }];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.objects count] == 0){
        return 0;
    }else{
        return 3 + [self.objects count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 44;
        case 1:
            return self.cateogoriesCell.frame.size.height;
        case 2:
            return 44;
        default:
            return 140;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
            return self.searchCell;
        case 1:
            return self.cateogoriesCell;
        case 2:
            return self.upcomingEventsTitleCell;
        default:{
            GSBizTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GSBizTableViewCellIdentifier" forIndexPath:indexPath];
            
            PFObject *object = self.objects[indexPath.row-3];
            cell.titleLabel.text = object[@"name"];
            cell.mainImageView.image = self.imageDictionary[object.objectId];
            
            return cell;
        }
    }
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
}

- (UITableViewCell *)searchCell{
    if(_searchCell == nil){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchCell"];
        cell.frame = CGRectMake(0, 0, 320, 44);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:cell.bounds];
        searchBar.delegate = self;
        searchBar.barTintColor = [UIColor colorWithRed:0.44 green:0.66 blue:0.28 alpha:1];
        [cell.contentView addSubview:searchBar];
        _searchCell = cell;
    }
    return _searchCell;
}

- (UITableViewCell *)cateogoriesCell{
    if(_cateogoriesCell == nil){
        GSHomeViewCategoryTableViewCell *cell = [[GSHomeViewCategoryTableViewCell alloc] init];
        cell.delegate = self;
        _cateogoriesCell = cell;
    }
    return _cateogoriesCell;
}

- (void)homeViewCategoryTableViewCell:(GSHomeViewCategoryTableViewCell *)cell didSelectCategory:(NSString *)category{
    GSBizTableViewController *controller = [[GSBizTableViewController alloc] initWithCity:self.city andCategory:category];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UITableViewCell *)upcomingEventsTitleCell{
    if(_upcomingEventsTitleCell == nil){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleCell"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = NSLocalizedString(@"Upcoming Events", @"Upcoming events title");
        cell.backgroundColor = [UIColor colorWithWhite:0.25 alpha:.8];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.textColor = [UIColor whiteColor];
        _upcomingEventsTitleCell = cell;
    }
    return _upcomingEventsTitleCell;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    searchBar.text = nil;
    [searchBar endEditing:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    GSBizTableViewController *controller = [[GSBizTableViewController alloc] initWithCity:self.city andSearchString:searchBar.text];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row >= 3){
        GSBizDetailsTableViewController *controller = [[GSBizDetailsTableViewController alloc] initWithBizObjectId:((PFObject*)self.objects[indexPath.row-3]).objectId];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
