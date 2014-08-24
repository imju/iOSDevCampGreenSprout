//
//  GSHomeViewCategoryTableViewCell.m
//  GreenSprout
//
//  Created by Dominic Tham on 8/23/14.
//
//

#import "GSHomeViewCategoryTableViewCell.h"

@interface GSHomeViewCategoryTableViewCell () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *categories;

@end

@implementation GSHomeViewCategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 320, 44*5+16);
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.categories = @[@"Sports", @"Music", @"Arts", @"Academics", @"More..."];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(8, 8, 304, 44*5) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView.layer.cornerRadius = 6;
        
        [self addSubview:tableView];
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewStylePlain reuseIdentifier:@"CellIdentifier"];
    }
    cell.textLabel.text = self.categories[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor darkGrayColor];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate homeViewCategoryTableViewCell:self didSelectCategory:self.categories[indexPath.row]];
}


@end
