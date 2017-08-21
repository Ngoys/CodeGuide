//
//  BaseTableViewController.m
//  SCA
//
//  Created by kyTang on 22/04/2016.
//  Copyright © 2016 ADS. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)distanceBetweenCell:(UITableViewCell *) cell {
//    UIView * cellOutlineV;
//    
//    cellOutlineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, cell.frame.size.height)];
//    cellOutlineV.layer.cornerRadius = 6;
//    [cellOutlineV.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
//    cellOutlineV.layer.masksToBounds = false;
//    cellOutlineV.layer.shadowOffset = CGSizeMake(0, 0);
//    cellOutlineV.layer.shadowOpacity = 0.2;
//    [cellOutlineV.layer setShadowRadius:4.0];
//    
//    [cell.contentView addSubview: cellOutlineV];
//    [cell.contentView sendSubviewToBack: cellOutlineV];
//    
//    cellOutlineV = nil;
    
    
    [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
//    cell.contentView.layer.cornerRadius = 2;
    [cell.contentView.layer setBorderWidth:2.0f];
}


@end
