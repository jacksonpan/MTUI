//
//  MTTableView.m
//  MicroTransfer
//
//  Created by jacksonpan on 13-1-19.
//  Copyright (c) 2013年 weichuan. All rights reserved.
//

#import "MTTableView.h"
#import "MTTableView+Transform.h"
#import <QuartzCore/QuartzCore.h>

@interface MTTableView () <UITableViewDataSource, UITableViewDelegate>
{
    CGPoint _lastScrollPosition;
    CGPoint _currentScrollPosition;
    NSIndexPath* lastIndexPath;
}
@end

@implementation MTTableView
@synthesize blockNumberOfRows = _blockNumberOfRows;
@synthesize blockCellForRowAtIndexPath = _blockCellForRowAtIndexPath;
@synthesize blockNumberOfSections = _blockNumberOfSections;
@synthesize blockTitleForHeaderInSection = _blockTitleForHeaderInSection;
@synthesize blockTitleForFooterInSection;
@synthesize blockCanEditRowAtIndexPath;
@synthesize blockCanMoveRowAtIndexPath;
@synthesize blockSectionIndexTitles;
@synthesize blockSectionForSectionIndexTitle = _blockSectionForSectionIndexTitle;
@synthesize blockCommitEditingStyle;
@synthesize blockMoveRowAtIndexPath;
@synthesize blockwWllDisplayCell;
@synthesize blockHeightForRowAtIndexPath = _blockHeightForRowAtIndexPath;
@synthesize blockHeightForHeaderInSection = _blockHeightForHeaderInSection;
@synthesize blockHeightForFooterInSection;
@synthesize blockViewForHeaderInSection = _blockViewForHeaderInSection;
@synthesize blockViewForFooterInSection;
@synthesize blockAccessoryButtonTappedForRowWithIndexPath;
@synthesize blockWillSelectRowAtIndexPath;
@synthesize blockWillDeselectRowAtIndexPath;
@synthesize blockDidSelectRowAtIndexPath = _blockDidSelectRowAtIndexPath;
@synthesize blockDidDeselectRowAtIndexPath = _blockDidDeselectRowAtIndexPath;
@synthesize blockEditingStyleForRowAtIndexPath = _blockEditingStyleForRowAtIndexPath;
@synthesize blockTitleForDeleteConfirmationButtonForRowAtIndexPath;
@synthesize blockShouldIndentWhileEditingRowAtIndexPath;
@synthesize blockWillBeginEditingRowAtIndexPath;
@synthesize blockDidEndEditingRowAtIndexPath;
@synthesize blockTargetIndexPathForMoveFromRowAtIndexPath;
@synthesize blockIndentationLevelForRowAtIndexPath;
@synthesize blockShouldShowMenuForRowAtIndexPath;
@synthesize blockCanPerformAction;
@synthesize blockPerformAction;
@synthesize blockMTTableViewReloadStart;
@synthesize blockMTTableViewReloadEnd;
@synthesize blockMTTableViewReloadAndDisplayEnd;

/* block above */

@synthesize enableTransform = _enableTransform;
@synthesize blockTransform = _blockTransform;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initBlock];
        [self initFunction];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        [self initBlock];
        [self initFunction];
    }
    return self;
}

- (void)initBlock
{
    self.delegate = self;
    self.dataSource = self;
}


- (void)initFunction
{
    _enableTransform = NO;
    if(_blockTransform == nil)
    {
        _blockTransform = MTTableViewCellTransformCurl;
    }
}

#pragma mark - DataSource @required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger ret = 0;
    if(_blockNumberOfRows)
    {
        ret = _blockNumberOfRows(self, section);
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    lastIndexPath = indexPath;
    UITableViewCell* ret = nil;
    if(_blockCellForRowAtIndexPath)
    {
        ret = _blockCellForRowAtIndexPath(self, indexPath);
    }
    return ret;
}

#pragma mark - DataSource @optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger ret = 1;
    if(_blockNumberOfSections)
    {
        ret = _blockNumberOfSections(self);
    }
    return ret;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* ret = nil;
    if(_blockTitleForHeaderInSection)
    {
        ret = _blockTitleForHeaderInSection(self, section);
    }
    return ret;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString* ret = nil;
    if(blockTitleForFooterInSection)
    {
        ret = blockTitleForFooterInSection(self, section);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL ret = YES;
    if(blockCanEditRowAtIndexPath)
    {
        ret = blockCanEditRowAtIndexPath(self, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL ret = NO;
    if(blockCanMoveRowAtIndexPath)
    {
        ret = blockCanMoveRowAtIndexPath(self, indexPath);
    }
    return ret;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray* ret = nil;
    if(blockSectionIndexTitles)
    {
        ret = blockSectionIndexTitles(self);
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger ret = 0;
    if (_blockSectionForSectionIndexTitle)
    {
        ret = _blockSectionForSectionIndexTitle(self, title, index);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blockCommitEditingStyle)
    {
        blockCommitEditingStyle(self, editingStyle, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if(blockMoveRowAtIndexPath)
    {
        blockMoveRowAtIndexPath(self, sourceIndexPath, destinationIndexPath);
    }
}

#pragma mark - Delegate @optional

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blockwWllDisplayCell)
    {
        blockwWllDisplayCell(self, cell, indexPath);
    }
    
    if(_enableTransform)
    {
        float speed = self.scrollSpeed.y;
        float normalizedSpeed = MAX(-1.0f, MIN(1.0f, speed/20.0f));
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSTimeInterval animationDuration = _blockTransform(cell.layer, normalizedSpeed);
            [UIView animateWithDuration:animationDuration animations:^{
                cell.layer.transform = CATransform3DIdentity;
                cell.layer.opacity = 1.0f;
            } completion:^(BOOL finished) {
                
            }];
        });
    }
    
    if(1)
    {
        if(lastIndexPath == indexPath)
        {
            [self performSelector:@selector(postMessageForReloadAndDisplayEnd) withObject:nil afterDelay:0.3];
        }
    }
}

- (void)postMessageForReloadAndDisplayEnd
{
    if(blockMTTableViewReloadAndDisplayEnd)
    {
        blockMTTableViewReloadAndDisplayEnd(self);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.0f;
    if(_blockHeightForRowAtIndexPath)
    {
        height = _blockHeightForRowAtIndexPath(self, indexPath);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0.0f;
    if(_blockHeightForHeaderInSection)
    {
        height = _blockHeightForHeaderInSection(self, section);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0.0f;
    if(blockHeightForFooterInSection)
    {
        height = blockHeightForFooterInSection(self, section);
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = nil;
    if(_blockViewForHeaderInSection)
    {
        view = _blockViewForHeaderInSection(self, section);
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view = nil;
    if(blockViewForFooterInSection)
    {
        view = blockViewForFooterInSection(self, section);
    }
    return view;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(blockAccessoryButtonTappedForRowWithIndexPath)
    {
        blockAccessoryButtonTappedForRowWithIndexPath(self, indexPath);
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* ret = indexPath;
    if(blockWillSelectRowAtIndexPath)
    {
        ret = blockWillSelectRowAtIndexPath(self, indexPath);
    }
    return ret;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    NSIndexPath* ret = indexPath;
    if(blockWillDeselectRowAtIndexPath)
    {
        ret = blockWillDeselectRowAtIndexPath(self, indexPath);
    }
    return ret;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_blockDidSelectRowAtIndexPath)
    {
        _blockDidSelectRowAtIndexPath(self, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    if(_blockDidDeselectRowAtIndexPath)
    {
        _blockDidDeselectRowAtIndexPath(self, indexPath);
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCellEditingStyle ret = UITableViewCellEditingStyleNone;
    if(_blockEditingStyleForRowAtIndexPath)
    {
        ret = _blockEditingStyleForRowAtIndexPath(self, indexPath);
    }
    return ret;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    NSString* ret = nil;
    if(blockTitleForDeleteConfirmationButtonForRowAtIndexPath)
    {
        ret = blockTitleForDeleteConfirmationButtonForRowAtIndexPath(self, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL ret = YES;
    if(blockShouldIndentWhileEditingRowAtIndexPath)
    {
        ret = blockShouldIndentWhileEditingRowAtIndexPath(self, indexPath);
    }
    return ret;
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blockWillBeginEditingRowAtIndexPath)
    {
        blockWillBeginEditingRowAtIndexPath(self, indexPath);
    }
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(blockDidEndEditingRowAtIndexPath)
    {
        blockDidEndEditingRowAtIndexPath(self, indexPath);
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSIndexPath* ret = sourceIndexPath;
    if(blockTargetIndexPathForMoveFromRowAtIndexPath)
    {
        ret = blockTargetIndexPathForMoveFromRowAtIndexPath(self, sourceIndexPath, proposedDestinationIndexPath);
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger ret = 0;
    if(blockIndentationLevelForRowAtIndexPath)
    {
        ret = blockIndentationLevelForRowAtIndexPath(self, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0)
{
    BOOL ret = NO;
    if(blockShouldShowMenuForRowAtIndexPath)
    {
        ret = blockShouldShowMenuForRowAtIndexPath(self, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0)
{
    BOOL ret = NO;
    if(blockCanPerformAction)
    {
        ret = blockCanPerformAction(self, action, indexPath, sender);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0)
{
    if(blockPerformAction)
    {
        blockPerformAction(self, action, indexPath, sender);
    }
}

- (void)reloadData
{
    if(blockMTTableViewReloadStart)
    {
        blockMTTableViewReloadStart(self);
    }
    [super reloadData];
    if(blockMTTableViewReloadEnd)
    {
        blockMTTableViewReloadEnd(self);
    }
}

/* block above */

- (CGPoint)scrollSpeed {
    return CGPointMake(_lastScrollPosition.x - _currentScrollPosition.x,
                       _lastScrollPosition.y - _currentScrollPosition.y);
}

- (void)setBlockTransform:(MTTableViewCellTransform)blockTransform
{
    _blockTransform = blockTransform;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _lastScrollPosition = _currentScrollPosition;
    _currentScrollPosition = [scrollView contentOffset];
}
@end
