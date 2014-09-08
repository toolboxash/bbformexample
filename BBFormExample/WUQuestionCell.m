//
//  WUQuestionCell.m
//  whatsup
//
//  Created by Ashley Thwaites on 23/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "WUQuestionCell.h"
#import "WUQuestion.h"
#import "BBStyleSettings.h"

@interface WUQuestionCell ()

@property (nonatomic, readwrite) WUQuestion *question;

@end



@implementation WUQuestionCell

-(void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.questionLabel.font = [[BBStyleSettings sharedInstance] h1Font];
    self.questionLabel.textColor = [[BBStyleSettings sharedInstance] selectedColor];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)updateWithModel:(id)model
{
    if ([model isKindOfClass:[WUQuestion class]])
    {
        self.question = (WUQuestion*)model;
        
        self.questionLabel.text = self.question.question;
        
        
        NSArray *answers = nil;
        if (self.question.answers.count !=0)
        {
            answers = self.question.answers;
        }
        else
        {
            answers = @[@"Yes",@"No",@"Maybe"];
        }
            
        if (answers.count == self.answerLabels.count)
        {
            for (int i=0; i<answers.count;i++)
            {
                NSString *title = answers[i];
                if ([title isKindOfClass:[NSString class]])
                {
                    UILabel *label = self.answerLabels[i];
                    label.text = title;
                }
            }
        }
    }
}

-(id)model
{
    return self.question;
}

@end
