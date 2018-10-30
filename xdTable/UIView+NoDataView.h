//
//  UIView+NoDataView.h
//  XDTableviewDemo
//
//  Created by CumminsTY on 2018/10/29.
//  Copyright © 2018 --. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NoDataType) {//无数据类型 ，可根据业务逻辑自行添加
    NoDataTypeDefalut = 100,
    NoDataTypeNoNet,
};

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReloadClickBlock)();   // 点击按钮

@interface UIView (NoDataView)
@property (nonatomic,strong,nullable)UIView * noDataView;
@property (nonatomic, copy) ReloadClickBlock reloadBlock;

-(void) showNoDataWithType:(NoDataType)type  btnBlock:(ReloadClickBlock)clickReload;
-(void)hideNoDataView;
@end

NS_ASSUME_NONNULL_END


