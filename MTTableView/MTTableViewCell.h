//
//  MTTableViewCell.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-15.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTableViewCell : UITableViewCell
+ (id)newObject:(UITableView*)tableView;
+ (id)newObjectNoNib:(UITableView*)tableView;
+ (id)loadReuseableNib:(UITableView*)tableView;
+ (id)loadReuseableNoNib:(UITableView*)tableView style:(UITableViewCellStyle)style;
@end
