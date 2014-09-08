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
//        [self.memoryStorage addItems:[WUClientCache sharedInstance].questions];
        [self.tableView reloadData];
    }];
}

- (IBAction)unwindToQuestionsController:(UIStoryboardSegue *)unwindSegue
{
    // the contact has changed (rating, or image etc) so we need to refresh
    [self rebuildModel];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
/*
    // lets track selection state ourselvs
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    WUQuestion *question = (WUQuestion*)[self.memoryStorage objectAtIndexPath:indexPath];
    
    // send a whatsup for this question
    [SVProgressHUD showWithStatus:@"Sending..." maskType:SVProgressHUDMaskTypeClear];
    [[WUClient sharedClient] createWhatsUpWithQuestion:question forUserId:self.contactUserId success:^(id object)
     {
         [SVProgressHUD showSuccessWithStatus:@"Sent!"];
         [self.navigationController popToRootViewControllerAnimated:YES];
         [[NSNotificationCenter defaultCenter] postNotificationName:WUWhatsUpsOutChangedNotification object:nil];
     }failure:^(NSError *error){
         [SVProgressHUD dismiss];
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:[error localizedDescription]
                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alert show];
     }];
*/
}

@end
