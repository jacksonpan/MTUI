//
//  MTTableView_Define.h
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-28.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTTableView.h"

@class MTTableView;

//DataSource
typedef NSInteger(^numberOfRows)(MTTableView *tableView, NSInteger section);
typedef UITableViewCell*(^cellForRowAtIndexPath)(MTTableView *tableView, NSIndexPath *indexPath);
typedef NSInteger(^numberOfSections)(MTTableView *tableView);
typedef NSString*(^titleForHeaderInSection)(MTTableView *tableView, NSInteger section);
typedef NSString*(^titleForFooterInSection)(MTTableView *tableView, NSInteger section);
typedef BOOL(^canEditRowAtIndexPath)(MTTableView *tableView, NSIndexPath *indexPath);
typedef BOOL(^canMoveRowAtIndexPath)(MTTableView *tableView, NSIndexPath *indexPath);
typedef NSArray*(^sectionIndexTitles)(MTTableView* tableView);
typedef NSInteger(^sectionForSectionIndexTitle)(MTTableView *tableView, NSString *title, NSInteger index);
typedef void(^commitEditingStyle)(MTTableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);
typedef void(^moveRowAtIndexPath)(MTTableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
//Delegate
typedef void(^willDisplayCell)(MTTableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);
typedef CGFloat(^heightForRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef CGFloat(^heightForHeaderInSection)(MTTableView* tableView, NSInteger section);
typedef CGFloat(^heightForFooterInSection)(MTTableView* tableView, NSInteger section);
typedef UIView*(^viewForHeaderInSection)(MTTableView* tableView, NSInteger section);
typedef UIView*(^viewForFooterInSection)(MTTableView* tableView, NSInteger section);
typedef void(^accessoryButtonTappedForRowWithIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^willSelectRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^willDeselectRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef void(^didSelectRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef void(^didDeselectRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef UITableViewCellEditingStyle(^editingStyleForRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef NSString*(^titleForDeleteConfirmationButtonForRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^shouldIndentWhileEditingRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef void(^willBeginEditingRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef void(^didEndEditingRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^targetIndexPathForMoveFromRowAtIndexPath)(MTTableView* tableView, NSIndexPath* sourceIndexPath, NSIndexPath* proposedDestinationIndexPath);
typedef NSInteger(^indentationLevelForRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^shouldShowMenuForRowAtIndexPath)(MTTableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^canPerformAction)(MTTableView* tableView, SEL canPerformAction, NSIndexPath* forRowAtIndexPath, id withSender);
typedef void(^performAction)(MTTableView* tableView, SEL performAction, NSIndexPath* forRowAtIndexPath, id withSender);

/* block above */
typedef NSTimeInterval (^MTTableViewCellTransform)(CALayer * layer, float speed);

/* block msg */
typedef void (^MTTableViewReloadStart)(MTTableView* tableView);
typedef void (^MTTableViewReloadEnd)(MTTableView* tableView);
typedef void (^MTTableViewReloadAndDisplayEnd)(MTTableView* tableView);