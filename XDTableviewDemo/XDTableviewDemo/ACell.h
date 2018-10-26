//
//  ACell.h
//  TestTable
//
//  Created by CumminsTY on 2018/10/24.
//  Copyright © 2018 CumminsTY. All rights reserved.
//

#import "XDTableBaseCell.h"
@class ACell;
@protocol ACellClickDelegate <NSObject>
-(void)btnClick:(ACell*)cell;
@end



@interface ACell : XDTableBaseCell
@property(nonatomic, weak) id<ACellClickDelegate> clickDelegate;

@end
