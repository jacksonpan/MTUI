MTUI
====

wrapper for iOS UI

MTTableView wrapper is not all complete, you can add block function like code (you can see).

example:

- (void)initTable
{
    [myTableView setBlockNumberOfRows:^NSInteger(UITableView *tableView, NSInteger section) {
        WeiChuanCore* core = [WeiChuanCore current];
        return core.userInfo.wcCodeList.count;
    }];
    [myTableView setBlockHeightForRowAtIndexPath:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 50.0f;
    }];
    [myTableView setBlockCellForRowAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        WeiChuanCore* core = [WeiChuanCore current];
        wcUserInfoWcCode* userInfoCode = [core.userInfo.wcCodeList objectAtIndex:indexPath.row];
        userInfoViewCell* cell = [userInfoViewCell newObject:tableView];
        [cell setRow:indexPath.row];
        [cell setData:userInfoCode];
        cell.blockDetailIndex = ^(NSInteger row){
            UserInfoDetailViewController* detail = [UserInfoDetailViewController newObject];
            detail.lastViewController = self;
            self.nextViewController = detail;
            [detail setCurUserInfoWcCode:userInfoCode];
            [self gotoNextView];
        };
        return cell;
    }];
    
    UserInfoViewController* _self = self;
    [myTableView setBlockDidSelectRowAtIndexPath:^(UITableView *tableView, NSIndexPath *indexPath) {
        WeiChuanCore* core = [WeiChuanCore current];
        wcUserInfoWcCode* userInfoCode = [core.userInfo.wcCodeList objectAtIndex:indexPath.row];
        [_self performSelectorOnMainThread:@selector(setCurUserSelectedWcCode:) withObject:userInfoCode waitUntilDone:NO];
    }];
}



my email: ac861219@gmail.com
thanks.
