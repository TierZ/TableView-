//
//  SectionA.h
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import "XDTableBaseSection.h"
@protocol refreshCellDelegate <NSObject>
-(void)refreshCell;
@end
@interface SectionA : XDTableBaseSection
@property(nonatomic, weak) id<refreshCellDelegate> delegate;
@end
