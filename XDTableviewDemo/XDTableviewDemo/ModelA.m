//
//  ModelA.m
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import "ModelA.h"

@implementation ModelA
- (instancetype)initWithTitle:(NSString*)title
{
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}
@end
