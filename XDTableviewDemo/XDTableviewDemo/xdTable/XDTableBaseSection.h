//
//  XDTableBaseSection.h
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XDBaseCellModel,XDTableBaseView;
@interface XDTableBaseSection :  NSObject
@property (nonatomic,strong)NSMutableArray <XDBaseCellModel*>* viewModels;
+(NSDictionary<NSString*,NSString*>*)CellClassWithCellModel;
- (id)objectForSelectRowIndex:(NSInteger)rowIndex;

@end
