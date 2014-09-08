//
//  WUQuestionCell.h
//  whatsup
//
//  Created by Ashley Thwaites on 23/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "DTTableViewCell.h"

@interface WUQuestionCell : DTTableViewCell

@property (strong, nonatomic) IBOutlet UILabel *questionLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *answerLabels;

@end
