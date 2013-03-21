//
//  MTTableViewCell.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-15.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTTableViewCell.h"
#import "UIBase+MTAdd.h"
#import "MTTableView.h"

@implementation MTTableViewCell
+ (NSString*)getSelfName
{
    return [NSString stringWithUTF8String:object_getClassName(self)];
}

+ (id)newObject:(UITableView*)tableView
{
    id cell = [tableView dequeueReusableCellWithIdentifier:[self getSelfName]];
    if(!cell)
    {
        UINib *nib = [UINib nibWithNibName:[self getSelfName] bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:[self getSelfName]];
        cell = [tableView dequeueReusableCellWithIdentifier:[self getSelfName]];
        NSLog(@"cell new:%@", [self getSelfName]);
    }
    return cell;
}

+ (id)newObjectNoNib:(UITableView*)tableView
{
    id cell = [tableView dequeueReusableCellWithIdentifier:[self getSelfName]];
    if(!cell)
    {
        cell = [[MTTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self getSelfName]];
    }
    return cell;
}

+ (id)loadReuseableNib:(UITableView*)tableView
{
    id cell = [tableView dequeueReusableCellWithIdentifier:[self getSelfName]];
    if(!cell)
    {
        UINib *nib = [UINib nibWithNibName:[self getSelfName] bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:[self getSelfName]];
        cell = [tableView dequeueReusableCellWithIdentifier:[self getSelfName]];
        NSLog(@"cell new:%@", [self getSelfName]);
    }
    return cell;
}

+ (id)loadReuseableNoNib:(UITableView*)tableView style:(UITableViewCellStyle)style
{
    id cell = [tableView dequeueReusableCellWithIdentifier:[self getSelfName]];
    if(!cell)
    {
        cell = [[MTTableViewCell alloc] initWithStyle:style reuseIdentifier:[self getSelfName]];
    }
    return cell;
}
@end
