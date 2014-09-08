//
//  WUClientCache.m
//  whatsup
//
//  Created by Ashley Thwaites on 13/08/2014.
//  Copyright (c) 2014 Toolbox. All rights reserved.
//

#import "WUDataCache.h"

@interface WUDataCache ()

@end

@implementation WUDataCache

+ (BMFileFormat)saveFormat;
{
    return BMFileFormatHRCodedXML;
}

-(void)setUp
{
    self.questions = [NSMutableArray arrayWithCapacity:10];
}

#pragma mark - mapping methods for retrieving contacts

-(void)clearCache
{
    self.questions = [NSMutableArray arrayWithCapacity:10];
    [self save];
}

@end
