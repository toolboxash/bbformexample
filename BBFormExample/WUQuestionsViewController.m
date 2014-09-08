//
//  WUQuestionsViewController.m
//  whatsup
//
//  Created by Ashley Thwaites on 23/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "WUQuestionsViewController.h"
#import "WUQuestionCell.h"
#import "WUQuestion.h"
#import "WUDataCache.h"
#import "DTMemoryStorage+UpdateWithoutAnimations.h"

@interface WUQuestionsViewController ()
{
    
}
@end

@implementation WUQuestionsViewController


-(void)setup
{
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self registerCellClass:[WUQuestionCell class] forModelClass:[WUQuestion class]];
    [self rebuildModel];
}

- (void)rebuildModel
{
    [self.memoryStorage updateWithoutAnimations:^{
        if (self.memoryStorage.sections.count)
        {
            [self.memoryStorage deleteSections: [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.memoryStorage.sections.count)]];
        }
        [self.memoryStorage addItems:[WUDataCache sharedInstance].questions];
        [self.tableView reloadData];
    }];
}


- (IBAction)editPressed:(id)sender {
    // set the table into edit mode
    if (self.tableView.editing == NO)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                              target:self
                                                                                              action:@selector(editPressed:)];
        [self.tableView setEditing:YES animated:YES];
    }else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                              target:self
                                                                                              action:@selector(editPressed:)];
        [self.tableView setEditing:NO animated:YES];
    }

}

- (IBAction)unwindToQuestionsController:(UIStoryboardSegue *)unwindSegue
{
    // the contact has changed (rating, or image etc) so we need to refresh
    [self rebuildModel];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{

}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        WUQuestion *question = (WUQuestion*)[self.memoryStorage objectAtIndexPath:indexPath];
        if (question)
        {
            // we need to replace the parse functionalty to post an object change back to server
            [[WUDataCache sharedInstance].questions removeObject:question];
            [[WUDataCache sharedInstance] save];
            [self.memoryStorage removeItem:question];
        }
    }
}

@end
