//
//  XDTableBaseCell.h
//  TestTable
//
//  Created by CumminsTY on 2018/10/23.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XDBaseCellType) {
    XDBaseCellNone,       //上下线都隐藏
    XDBaseCellAtFirst,    //下线隐藏,按照group样式即第一个cell,originx=0
    XDBaseCellAtMiddle,   //下线隐藏,按照group样式即中间cell,originx=separateLineOffset
    XDBaseCellAtLast,     //上下线都显示,按照group样式即最后一个cell,上线originx=separateLineOffset 下线originx=0
    XDBaseCellNormal,     //下线隐藏,按照plain样式,originx=separateLineOffset
    XDBaseCellSingle,     //上下线都显示，originx=0
    XDBaseCellDoubleOffset,     //下线显示，按照plain样式，并且 左右都偏移separateLineOffset
    
};


/**
 tableviewcell 基类
 */
@interface XDTableBaseCell : UITableViewCell
/**
 *  分隔线的颜色值,默认为(208,208,208)
 */
@property (nonatomic,strong) UIColor *lineColor;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) id xdCellData;

/**
 *  分割线了偏移量,默认是0
 */
@property(nonatomic, assign) NSInteger separateLineOffset;

/**
 *  分隔线是上,还是下,还是中间的
 */
@property(nonatomic, assign) XDBaseCellType cellType;

/**
 *  上横线
 */
@property (strong, nonatomic)  UIView *topLineView;

/**
 *  下横线,都是用来分隔cell的
 */
@property (strong, nonatomic)  UIView *bottomLineView;


+ (CGFloat)cellHeightWithCellData:(id)cellData;

+ (CGFloat)cellHeightWithCellData:(id)cellData boundWidth:(CGFloat)width;


- (void)setCellData:(id)cellData;


- (void)setSeperatorLine:(NSIndexPath *)indexPath numberOfRowsInSection: (NSInteger)numberOfRowsInSection;

@end
