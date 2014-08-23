//
//  GSCitiesTableViewController.m
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import "GSCitiesTableViewController.h"

@interface GSCitiesTableViewController ()

@property (strong, nonatomic) NSArray *cityNames;
@property (strong, nonatomic) NSArray *otherCityNames;
@property (strong, nonatomic) NSString *selectedCity;

@end

@implementation GSCitiesTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Cities", @"Cities title");
    
    self.cityNames = @[@"Cupertino", @"Mountain View", @"Palo Alto", @"San Francisco", @"San Jose"];
    
//    self.selectedCity = [self.delegate citiesTableViewControllerGetCurrentCity:self];
//    self.otherCityNames = [self.cityNames objectsAtIndexes:[self.cityNames indexesOfObjectsPassingTest:^BOOL(NSString *city, NSUInteger idx, BOOL *stop) {
//        return ![city isEqualToString:self.selectedCity];
//    }]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateSelectedCity:(NSString *)city{
    self.selectedCity = city;
    self.otherCityNames = [self.cityNames objectsAtIndexes:[self.cityNames indexesOfObjectsPassingTest:^BOOL(NSString *city, NSUInteger idx, BOOL *stop) {
        return ![city isEqualToString:self.selectedCity];
    }]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(self.selectedCity){
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.selectedCity && section == 0){
        return 1;
    }else{
        return [self.otherCityNames count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(self.selectedCity){
        switch (section) {
            case 0:
                return @"Current";
            case 1:
                return @"Other";
            default:
                return nil;
        }
    }else{
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GSCitiesTableViewCell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GSCitiesTableViewCell"];
    }
    
    if(self.selectedCity && indexPath.section == 0){
        cell.textLabel.text = self.selectedCity;
    }else{
        cell.textLabel.text = self.otherCityNames[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *selectedCity = nil;
    if(self.selectedCity && indexPath.section == 0){
        selectedCity =  self.selectedCity;
    }else{
        selectedCity = self.otherCityNames[indexPath.row];
    }
    [self.delegate citiesTableViewController:self didSelectCity:selectedCity];
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
