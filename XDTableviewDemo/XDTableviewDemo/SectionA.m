//
//  SectionA.m
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import "SectionA.h"
#import "XDBaseCellModel.h"
#import "ModelA.h"
#import "ACell.h"
@interface SectionA()<ACellClickDelegate>

@end
@implementation SectionA
+ (NSDictionary<NSString *,NSString *> *)CellClassWithCellModel{
    return @{@"ACell":@"ModelA"};
}

-(id)objectForSelectRowIndex:(NSInteger)rowIndex{
    XDBaseCellModel *viewModel = self.viewModels[rowIndex];
    return @(viewModel.cellHeight);

}

-(void)bindCell:(XDTableBaseCell *)cell indexPath:(NSIndexPath *)indexPath{
    ACell * acell = (ACell*)cell;
    acell.clickDelegate = self;
}

-(void)btnClick:(ACell *)cell{
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshCell)]) {
        [self.delegate refreshCell];
    }
}

@end
