//
//  XDTableBaseSection.m
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import "XDTableBaseSection.h"

@implementation XDTableBaseSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(NSDictionary *)CellClassWithCellModel{
    return nil;
}
- (id)objectForSelectRowIndex:(NSInteger)rowIndex{
    return nil;
}


#pragma mark getter
-(NSMutableArray<XDBaseCellModel *> *)viewModels{
    if (!_viewModels) {
        _viewModels = [NSMutableArray array];
    }
    return _viewModels;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
