//
//  GSBizDetailsTableViewController.m
//  GreenSprout
//
//  Created by Imju Byon on 8/23/14.
//
//

#import "GSBizDetailsTableViewController.h"
#import "GSParseHelper.h"

@interface GSBizDetailsTableViewController ()
@property (strong, nonatomic) PFObject *object;
@property (strong, nonatomic) UIImage *mainImage;
@property (strong, nonatomic) NSArray *classes;
@property (strong, nonatomic) NSArray *pictures;

@end

@implementation GSBizDetailsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UINib *detailsCell = [UINib nibWithNibName:@"GSBizDetailsCell" bundle:nil];
    [self.tableView registerNib:detailsCell forCellReuseIdentifier:@"detailsCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [GSParseHelper queryBizWithObjectId:@"2LzD8bIVjs" andBlock:^(PFObject *object, UIImage *mainImage, NSArray *classes, NSArray *pictures, NSError *error) {
        if(!error && object!=nil){
            self.object = object;
            self.mainImage = mainImage;
            self.classes = classes;
            self.pictures = pictures;
            [self.tableView reloadData];
        }
    }];

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
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
//    NSLog(@"indexPath.row:%d",indexPath.row);
    switch (indexPath.row)
    {
        case 0:{
            cell = [[UITableViewCell alloc]
                      initWithStyle:UITableViewCellStyleDefault
                      reuseIdentifier:@"mainImageCell"];
            UIImageView *scaledImgV = [[UIImageView alloc] init];
            // scaledImgV.image = [self imageWithImage:self.mainImage  scaledToSize:CGSizeMake(320,120)];
           scaledImgV.image = self.mainImage;
           scaledImgV.frame = CGRectMake(0, 0, 310, 120);
           scaledImgV.contentMode = UIViewContentModeScaleAspectFill;
           cell.clipsToBounds = YES;
           [cell.contentView addSubview:scaledImgV];
           break;
        }
        case 1:{
           cell = [tableView dequeueReusableCellWithIdentifier:@"detailsCell" forIndexPath:indexPath];
           NSString *contentText = nil;
           contentText = self.object[@"location"];
           ((GSBizDetailsCell *)cell).content.text = contentText;
           [((GSBizDetailsCell *)cell).content sizeToFit]; //added
           [((GSBizDetailsCell *)cell).content layoutIfNeeded]; //added
           break;
        }
        case 2:{
           cell = [[UITableViewCell alloc]
                  initWithStyle:UITableViewCellStyleDefault
                  reuseIdentifier:@"imageScrollCell"];
           UILabel *label = [[UILabel alloc] init];
           label.adjustsFontSizeToFitWidth = YES;
           label.text = @"Pictures";
           label.frame = CGRectMake(0,0,40, 12);
           [cell addSubview:label];
           UIScrollView *scrollView = [[UIScrollView alloc] init];
            
            scrollView.frame = CGRectMake(0,15,310,120);
           int scrollVWidth = 0;
           for (int i = 0; i < 4; i++) {
              UIImageView *imgView = [[UIImageView alloc]init];
              imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"soccer%d.jpg",i+1]];
              imgView.contentMode = UIViewContentModeScaleAspectFit;
              CGRect frame;
              frame.origin.x = scrollVWidth;
              frame.origin.y = 0;
              frame.size = imgView.image.size;
              imgView.frame = frame;
              scrollVWidth += imgView.frame.size.width;
              [scrollView addSubview:imgView];
            }
            
            scrollView.contentSize = CGSizeMake(scrollVWidth,
                                            scrollView.frame.size.height);
           [cell addSubview:scrollView];
            break;
        }
        default:
           cell = [tableView dequeueReusableCellWithIdentifier:@"detailsCell" forIndexPath:indexPath];
      }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row){
        case 0:
           return 120;
        case 1:
           return 50;
        default:
            return 60;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    GSBizDetailsHeaderView *bizHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"GSBizDetailsHeaderView" owner:self options:nil] objectAtIndex:0];
    if (self.object!=nil){
        bizHeaderView.bizName.text = self.object[@"name"];
        bizHeaderView.followerNum.text = [NSString stringWithFormat:@"%@ followers",self.object[@"follower"]];
        bizHeaderView.reviewNum.text = [NSString stringWithFormat:@"%@ reviews",self.object[@"reviewNum"]];
        bizHeaderView.moreInfo.text = self.object[@"website"];
        bizHeaderView.moreInfo.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    bizHeaderView.frame = CGRectMake(0,0,320,110);
    
    return bizHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 105.0;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(newSize, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(newSize);
        }
    } else {
        UIGraphicsBeginImageContext(newSize);
    }
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
