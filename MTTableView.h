//
//  MTTableView.h
//  WeiChuanV3
//
//  Created by jacksonpan on 13-1-19.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import <UIKit/UIKit.h>

//DataSource
typedef NSInteger(^numberOfRows)(UITableView *tableView, NSInteger section);
typedef UITableViewCell*(^cellForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
typedef NSInteger(^numberOfSections)(UITableView *tableView);
typedef NSString*(^titleForHeaderInSection)(UITableView *tableView, NSInteger section);
typedef NSString*(^titleForFooterInSection)(UITableView *tableView, NSInteger section);
typedef BOOL(^canEditRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
typedef BOOL(^canMoveRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);
typedef NSArray*(^sectionIndexTitles)(UITableView* tableView);
typedef NSInteger(^sectionForSectionIndexTitle)(UITableView *tableView, NSString *title, NSInteger index);
typedef void(^commitEditingStyle)(UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath);
typedef void(^moveRowAtIndexPath)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
//Delegate
typedef void(^willDisplayCell)(UITableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);
typedef CGFloat(^heightForRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef CGFloat(^heightForHeaderInSection)(UITableView* tableView, NSInteger section);
typedef CGFloat(^heightForFooterInSection)(UITableView* tableView, NSInteger section);
typedef UIView*(^viewForHeaderInSection)(UITableView* tableView, NSInteger section);
typedef UIView*(^viewForFooterInSection)(UITableView* tableView, NSInteger section);
typedef void(^accessoryButtonTappedForRowWithIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^willSelectRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^willDeselectRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef void(^didSelectRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef void(^didDeselectRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef UITableViewCellEditingStyle(^editingStyleForRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef NSString*(^titleForDeleteConfirmationButtonForRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^shouldIndentWhileEditingRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef void(^willBeginEditingRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef void(^didEndEditingRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef NSIndexPath*(^targetIndexPathForMoveFromRowAtIndexPath)(UITableView* tableView, NSIndexPath* sourceIndexPath, NSIndexPath* proposedDestinationIndexPath);
typedef NSInteger(^indentationLevelForRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^shouldShowMenuForRowAtIndexPath)(UITableView* tableView, NSIndexPath* indexPath);
typedef BOOL(^canPerformAction)(UITableView* tableView, SEL canPerformAction, NSIndexPath* forRowAtIndexPath, id withSender);
typedef void(^performAction)(UITableView* tableView, SEL performAction, NSIndexPath* forRowAtIndexPath, id withSender);


@interface MTTableView : UITableView
#pragma mark - DataSource @required
@property (nonatomic, strong) numberOfRows blockNumberOfRows;
@property (nonatomic, strong) cellForRowAtIndexPath blockCellForRowAtIndexPath;
#pragma mark - DataSource @optional
@property (nonatomic, strong) numberOfSections blockNumberOfSections;
@property (nonatomic, strong) titleForHeaderInSection blockTitleForHeaderInSection;
@property (nonatomic, strong) titleForFooterInSection blockTitleForFooterInSection;
@property (nonatomic, strong) canEditRowAtIndexPath blockCanEditRowAtIndexPath;
@property (nonatomic, strong) canMoveRowAtIndexPath blockCanMoveRowAtIndexPath;
@property (nonatomic, strong) sectionIndexTitles blockSectionIndexTitles;
@property (nonatomic, strong) sectionForSectionIndexTitle blockSectionForSectionIndexTitle;
@property (nonatomic, strong) commitEditingStyle blockCommitEditingStyle;
@property (nonatomic, strong) moveRowAtIndexPath blockMoveRowAtIndexPath;

#pragma mark - Delegate @optional
@property (nonatomic, strong) willDisplayCell blockwWllDisplayCell;
@property (nonatomic, strong) heightForRowAtIndexPath blockHeightForRowAtIndexPath;
@property (nonatomic, strong) heightForHeaderInSection blockHeightForHeaderInSection;
@property (nonatomic, strong) heightForFooterInSection blockHeightForFooterInSection;
@property (nonatomic, strong) viewForHeaderInSection blockViewForHeaderInSection;
@property (nonatomic, strong) viewForFooterInSection blockViewForFooterInSection;
@property (nonatomic, strong) accessoryButtonTappedForRowWithIndexPath blockAccessoryButtonTappedForRowWithIndexPath;
@property (nonatomic, strong) willSelectRowAtIndexPath blockWillSelectRowAtIndexPath;
@property (nonatomic, strong) willDeselectRowAtIndexPath blockWillDeselectRowAtIndexPath;
@property (nonatomic, strong) didSelectRowAtIndexPath blockDidSelectRowAtIndexPath;
@property (nonatomic, strong) didDeselectRowAtIndexPath blockDidDeselectRowAtIndexPath;
@property (nonatomic, strong) editingStyleForRowAtIndexPath blockEditingStyleForRowAtIndexPath;
@property (nonatomic, strong) titleForDeleteConfirmationButtonForRowAtIndexPath blockTitleForDeleteConfirmationButtonForRowAtIndexPath;
@property (nonatomic, strong) shouldIndentWhileEditingRowAtIndexPath blockShouldIndentWhileEditingRowAtIndexPath;
@property (nonatomic, strong) willBeginEditingRowAtIndexPath blockWillBeginEditingRowAtIndexPath;
@property (nonatomic, strong) didEndEditingRowAtIndexPath blockDidEndEditingRowAtIndexPath;
@property (nonatomic, strong) targetIndexPathForMoveFromRowAtIndexPath blockTargetIndexPathForMoveFromRowAtIndexPath;
@property (nonatomic, strong) indentationLevelForRowAtIndexPath blockIndentationLevelForRowAtIndexPath;
@property (nonatomic, strong) shouldShowMenuForRowAtIndexPath blockShouldShowMenuForRowAtIndexPath;
@property (nonatomic, strong) canPerformAction blockCanPerformAction;
@property (nonatomic, strong) performAction blockPerformAction;

- (void)setBlockNumberOfRows:(numberOfRows)blockNumberOfRows;
- (void)setBlockCellForRowAtIndexPath:(cellForRowAtIndexPath)blockCellForRowAtIndexPath;
- (void)setBlockHeightForRowAtIndexPath:(heightForRowAtIndexPath)blockHeightForRowAtIndexPath;
- (void)setBlockDidSelectRowAtIndexPath:(didSelectRowAtIndexPath)blockDidSelectRowAtIndexPath;
@end
