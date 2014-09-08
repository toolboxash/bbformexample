//
//  WUQuestion.h
//  whatsup
//
//  Created by Ashley Thwaites on 23/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "BaseModel.h"

@interface WUQuestion : BaseModel

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, assign) NSInteger expireAfter;

@end
