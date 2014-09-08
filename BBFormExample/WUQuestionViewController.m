//
//  WUQuestionViewController.m
//  whatsup
//
//  Created by Ashley Thwaites on 24/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "WUQuestionViewController.h"
#import "WUQuestion.h"
#import "WUDataCache.h"
#import "BBFloatingLabelTextField.h"
#import "BBFloatingLabelSelectField.h"
#import "BBFormValidator.h"

@interface WUQuestionViewController () <BBFormElementDelegate>
{
    NSMutableArray *model;
}

@property (strong, nonatomic) IBOutlet BBFloatingLabelTextField *questionFloatingTextField;
@property (strong, nonatomic) IBOutlet BBFloatingLabelTextField *answer1FloatingTextField;
@property (strong, nonatomic) IBOutlet BBFloatingLabelTextField *answer2FloatingTextField;
@property (strong, nonatomic) IBOutlet BBFloatingLabelTextField *answer3FloatingTextField;
@property (strong, nonatomic) IBOutlet BBFloatingLabelSelectField *durationFloatingSelectField;

@end

@implementation WUQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    // create a basic validation condition
    BBConditionPresent *present = [[BBConditionPresent alloc] initWithLocalizedViolationString:NSLocalizedString(@"Please complete all fields", @"Please complete all fields")];
    
    
    // build the model for the form
    model = [NSMutableArray arrayWithCapacity:10];
    [model addObject:[BBFormTextFieldElement textInputElementWithID:0 placeholderText:@"Question" value:nil delegate:self]];
    ((BBFormTextFieldElement*)model.lastObject).validator = [[BBValidator alloc] initWithCondition:present,nil ];
    for (int i=0; i<3 ;i++)
    {
        NSString *placeholder =  [NSString stringWithFormat:@"Answer %d",(int)i];
        [model addObject:[BBFormTextFieldElement textInputElementWithID:i+1 placeholderText:placeholder value:nil delegate:self]];
        ((BBFormTextFieldElement*)model.lastObject).validator =  [[BBValidator alloc] initWithCondition:present,nil ];
    }
    
    [model addObject:[BBFormSelectFieldElement selectElementWithID:4 labelText:@"Expire after" values:@[@"1 minute",@"5 minutes",@"15 minutes",@"1 hour"] delegate:self]];
    ((BBFormSelectFieldElement*)model.lastObject).validator = [[BBValidator alloc] initWithCondition:present,nil ];

    
    // normally we would be putting each field in a table, but this is an explicitly built form in interface builder
    // so we need to configure the components
    [self.questionFloatingTextField updateWithElement:model[0]];
    [self.answer1FloatingTextField updateWithElement:model[1]];
    [self.answer2FloatingTextField updateWithElement:model[2]];
    [self.answer3FloatingTextField updateWithElement:model[3]];
    [self.durationFloatingSelectField updateWithElement:model[4]];
}


- (IBAction)donePressed:(id)sender {
    
    // run the validations and display any validations as an alert
    for (BBFormElement *element in model)
    {
        BBValidator *validator = (BBValidator*)element.validator;
        BBConditionCollection *failedConditions = [validator checkConditions:element];
        
        if (failedConditions.count != 0)
        {
            BBCondition *cond = [failedConditions conditionAtIndex:0];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: nil
                                                            message: cond.localizedViolationString
                                                           delegate: nil
                                                  cancelButtonTitle: NSLocalizedString(@"OK", @"OK")
                                                  otherButtonTitles: nil];
            [alert show];
            return;
        }
    }

    // create an item to persist what weve just entered
    WUQuestion *question = [WUQuestion new];
    question.question = ((BBFormTextFieldElement*)model[0]).value;
    question.answers = @[((BBFormTextFieldElement*)model[1]).value,
                         ((BBFormTextFieldElement*)model[2]).value,
                         ((BBFormTextFieldElement*)model[3]).value];
    
    // we need to
    NSArray *expireOptions = @[@60,@300,@900,@3600];
    question.expireAfter = [expireOptions[((BBFormSelectFieldElement*)model[4]).index] integerValue];

    [[WUDataCache sharedInstance].questions addObject:question];
    [[WUDataCache sharedInstance] save];
    
    [self performSegueWithIdentifier:@"unwindToQuestionsController" sender:self];
}



@end
