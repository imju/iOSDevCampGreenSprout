//
//  GSBizTableViewController.m
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import <Parse/Parse.h>
#import "GSBizTableViewController.h"
#import "GSBizTableViewCell.h"
#import "GSParseHelper.h"

@interface GSBizTableViewController ()

@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *category;

@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) NSDictionary *imageDictionary;

@end

@implementation GSBizTableViewController

- (instancetype)initWithCity:(NSString *)city andCategory:(NSString *)category{
    self = [super init];
    if(self){
        self.city = city;
        self.category = category;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GSBizTableViewCell" bundle:nil] forCellReuseIdentifier:@"GSBizTableViewCellIdentifier"];
    self.tableView.rowHeight = 140;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [GSParseHelper queryBizWithCity:self.city category:self.category andBlock:^(NSArray *objects, NSDictionary *images, NSError *error) {
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
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GSBizTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GSBizTableViewCellIdentifier" forIndexPath:indexPath];
    
    PFObject *object = self.objects[indexPath.row];
    cell.titleLabel.text = object[@"name"];
    cell.mainImageView.image = self.imageDictionary[object.objectId];
    
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
