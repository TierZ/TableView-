//
//  XDTableBaseView.h
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDTableBaseSection.h"
#import "MJRefresh.h"

typedef NS_ENUM(NSInteger, XDTableRefreshType) {
    XDTableRefreshTypeNew = 0,
    XDTableRefreshTypeMore,
};



@protocol XDTableBaseViewDelegate <NSObject, UIScrollViewDelegate>
- (void)xd_tableView:(XDTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath section:(XDTableBaseSection *)section withObject:(id)obj;

@optional
- (CGFloat)xd_tableView:(XDTableBaseView *)tableView heightForHeaderInSection:(XDTableBaseSection *)section;
- (CGFloat)xd_tableView:(XDTableBaseView *)tableView heightForFooterInSection:(XDTableBaseSection *)section;
- (UIView *)xd_tableView:(XDTableBaseView *)tableView viewForHeaderInSection:(XDTableBaseSection *)section;
- (UIView *)xd_tableView:(XDTableBaseView *)tableView viewForFooterInSection:(XDTableBaseSection *)section;
@end


typedef void(^RefreshListBlock)(XDTableRefreshType refreshStyle);

@interface XDTableBaseView : UITableView
@property (nonatomic,weak)id<XDTableBaseViewDelegate>xdDelegate;
@property (nonatomic,copy)RefreshListBlock block;
-(void)registSection:(XDTableBaseSection*)section;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style showRefresh:(BOOL)showRefresh;

@end
