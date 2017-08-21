//
//  BaseTableViewController.h
//  SCA
//
//  Created by kyTang on 22/04/2016.
//  Copyright © 2016 ADS. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>


- (void)distanceBetweenCell:(UITableViewCell *) cell;
@end
