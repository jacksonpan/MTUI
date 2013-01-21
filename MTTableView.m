//
//  MTTableView.m
//  WeiChuanV3
//
//  Created by jacksonpan on 13-1-19.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTTableView.h"

@interface MTTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MTTableView
@synthesize blockNumberOfRows = _blockNumberOfRows;
@synthesize blockCellForRowAtIndexPath = _blockCellForRowAtIndexPath;
@synthesize blockNumberOfSections;
@synthesize blockTitleForHeaderInSection;
@synthesize blockTitleForFooterInSection;
@synthesize blockCanEditRowAtIndexPath;
@synthesize blockCanMoveRowAtIndexPath;
@synthesize blockSectionIndexTitles;
@synthesize blockSectionForSectionIndexTitle;
@synthesize blockCommitEditingStyle;
@synthesize blockMoveRowAtIndexPath;
@synthesize blockwWllDisplayCell;
@synthesize blockHeightForRowAtIndexPath = _blockHeightForRowAtIndexPath;
@synthesize blockHeightForHeaderInSection;
@synthesize blockHeightForFooterInSection;
@synthesize blockViewForHeaderInSection;
@synthesize blockViewForFooterInSection;
@synthesize blockAccessoryButtonTappedForRowWithIndexPath;
@synthesize blockWillSelectRowAtIndexPath;
@synthesize blockWillDeselectRowAtIndexPath;
@synthesize blockDidSelectRowAtIndexPath = _blockDidSelectRowAtIndexPath;
@synthesize blockDidDeselectRowAtIndexPath;
@synthesize blockEditingStyleForRowAtIndexPath;
@synthesize blockTitleForDeleteConfirmationButtonForRowAtIndexPath;
@synthesize blockShouldIndentWhileEditingRowAtIndexPath;
@synthesize blockWillBeginEditingRowAtIndexPath;
@synthesize blockDidEndEditingRowAtIndexPath;
@synthesize blockTargetIndexPathForMoveFromRowAtIndexPath;
@synthesize blockIndentationLevelForRowAtIndexPath;
@synthesize blockShouldShowMenuForRowAtIndexPath;
@synthesize blockCanPerformAction;
@synthesize blockPerformAction;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBlock];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initBlock];
    }
    return self;
}

- (void)initBlock
{
    self.delegate = self;
    self.dataSource = self;
}

- (void)setBlockNumberOfRows:(numberOfRows)blockNumberOfRows
{
    _blockNumberOfRows = blockNumberOfRows;
}

- (void)setBlockCellForRowAtIndexPath:(cellForRowAtIndexPath)blockCellForRowAtIndexPath
{
    _blockCellForRowAtIndexPath = blockCellForRowAtIndexPath;
}

- (void)setBlockHeightForRowAtIndexPath:(heightForRowAtIndexPath)blockHeightForRowAtIndexPath
{
    _blockHeightForRowAtIndexPath = blockHeightForRowAtIndexPath;
}

- (void)setBlockDidSelectRowAtIndexPath:(didSelectRowAtIndexPath)blockDidSelectRowAtIndexPath
{
    _blockDidSelectRowAtIndexPath = blockDidSelectRowAtIndexPath;
}

#pragma mark - DataSource @required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger ret = 0;
    if(_blockNumberOfRows)
    {
        ret = _blockNumberOfRows(tableView, section);
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* ret = nil;
    if(_blockCellForRowAtIndexPath)
    {
        ret = _blockCellForRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

#pragma mark - DataSource @optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger ret = 1;
    if(blockNumberOfSections)
    {
        ret = blockNumberOfSections(tableView);
    }
    return ret;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* ret = nil;
    if(blockTitleForHeaderInSection)
    {
        ret = blockTitleForHeaderInSection(tableView, section);
    }
    return ret;
}


- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString* ret = nil;
    if(blockTitleForFooterInSection)
    {
        ret = blockTitleForFooterInSection(tableView, section);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL ret = YES;
    if(blockCanEditRowAtIndexPath)
    {
        ret = blockCanEditRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL ret = NO;
    if(blockCanMoveRowAtIndexPath)
    {
        ret = blockCanMoveRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray* ret = nil;
    if(blockSectionIndexTitles)
    {
        ret = blockSectionIndexTitles(tableView);
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger ret = 0;
    if (blockSectionForSectionIndexTitle)
    {
        ret = blockSectionForSectionIndexTitle(tableView, title, index);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blockCommitEditingStyle)
    {
        blockCommitEditingStyle(tableView, editingStyle, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if(blockMoveRowAtIndexPath)
    {
        blockMoveRowAtIndexPath(tableView, sourceIndexPath, destinationIndexPath);
    }
}

#pragma mark - Delegate @optional

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blockwWllDisplayCell)
    {
        blockwWllDisplayCell(tableView, cell, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.0f;
    if(_blockHeightForRowAtIndexPath)
    {
        height = _blockHeightForRowAtIndexPath(tableView, indexPath);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0.0f;
    if(blockHeightForHeaderInSection)
    {
        height = blockHeightForHeaderInSection(tableView, section);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.0f;
    if(blockHeightForFooterInSection)
    {
        height = blockHeightForFooterInSection(tableView, section);
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = nil;
    if(blockViewForHeaderInSection)
    {
        view = blockViewForHeaderInSection(tableView, section);
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = nil;
    if(blockViewForFooterInSection)
    {
        view = blockViewForFooterInSection(tableView, section);
    }
    return view;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(blockAccessoryButtonTappedForRowWithIndexPath)
    {
        blockAccessoryButtonTappedForRowWithIndexPath(tableView, indexPath);
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* ret = indexPath;
    if(blockWillSelectRowAtIndexPath)
    {
        ret = blockWillSelectRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    NSIndexPath* ret = indexPath;
    if(blockWillDeselectRowAtIndexPath)
    {
        ret = blockWillDeselectRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_blockDidSelectRowAtIndexPath)
    {
        _blockDidSelectRowAtIndexPath(tableView, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    if(blockDidDeselectRowAtIndexPath)
    {
        blockDidDeselectRowAtIndexPath(tableView, indexPath);
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle ret = UITableViewCellEditingStyleNone;
    if(blockEditingStyleForRowAtIndexPath)
    {
        ret = blockEditingStyleForRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    NSString* ret = nil;
    if(blockTitleForDeleteConfirmationButtonForRowAtIndexPath)
    {
        ret = blockTitleForDeleteConfirmationButtonForRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL ret = YES;
    if(blockShouldIndentWhileEditingRowAtIndexPath)
    {
        ret = blockShouldIndentWhileEditingRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blockWillBeginEditingRowAtIndexPath)
    {
        blockWillBeginEditingRowAtIndexPath(tableView, indexPath);
    }
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blockDidEndEditingRowAtIndexPath)
    {
        blockDidEndEditingRowAtIndexPath(tableView, indexPath);
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSIndexPath* ret = sourceIndexPath;
    if(blockTargetIndexPathForMoveFromRowAtIndexPath)
    {
        ret = blockTargetIndexPathForMoveFromRowAtIndexPath(tableView, sourceIndexPath, proposedDestinationIndexPath);
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ret = 0;
    if(blockIndentationLevelForRowAtIndexPath)
    {
        ret = blockIndentationLevelForRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0)
{
    BOOL ret = NO;
    if(blockShouldShowMenuForRowAtIndexPath)
    {
        ret = blockShouldShowMenuForRowAtIndexPath(tableView, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0)
{
    BOOL ret = NO;
    if(blockCanPerformAction)
    {
        ret = blockCanPerformAction(tableView, action, indexPath, sender);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0)
{
    if(blockPerformAction)
    {
        blockPerformAction(tableView, action, indexPath, sender);
    }
}


@end
