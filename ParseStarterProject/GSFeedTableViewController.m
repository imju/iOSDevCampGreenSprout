//
//  GSFeedTableViewController.m
//  GreenSprout
//
//  Created by Dominic Tham on 8/24/14.
//
//

#import "GSFeedTableViewController.h"

@interface GSFeedTableViewController ()

@property (strong, nonatomic) NSArray *items;

@end

@implementation GSFeedTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"Feed";
    
    NSDictionary *item1 = @{@"title":@"Palo Alto YMCA",
                           @"time":@"3 days ago",
                           @"desc":@"Tadpole Swim Class Registration Deadline 8/27! 4 days from now"};

    NSDictionary *item2 = @{@"title":@"Shoreline Lake",
                            @"time":@"1 day ago",
                            @"desc":@"Kayak Class Starts Today 8/23"};

    NSDictionary *item3 = @{@"title":@"Palo Alto AYSO",
                            @"time":@"1 week ago",
                            @"desc":@"Please review your experience with the intermediate boys league team!"};
    
    self.items = @[item1, item2, item3];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 110, 25)];
        timeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        timeLabel.tag = 102;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.textColor = [UIColor colorWithRed:0.44 green:0.66 blue:0.28 alpha:1];
        [cell.contentView addSubview:timeLabel];
    }

    cell.textLabel.textColor = [UIColor colorWithRed:0.44 green:0.66 blue:0.28 alpha:1];
    
    NSDictionary *item = self.items[indexPath.row];
    
    cell.textLabel.text = item[@"title"];
    cell.detailTextLabel.text = item[@"desc"];
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:102];
    timeLabel.text = item[@"time"];

    return cell;
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
