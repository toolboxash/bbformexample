//
//  WUQuestion.h
//  whatsup
//
//  Created by Ashley Thwaites on 23/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WUQuestion : NSObject

@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, assign) NSInteger expireAfter;

@end
