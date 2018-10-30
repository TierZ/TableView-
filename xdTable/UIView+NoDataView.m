//
//  UIView+NoDataView.m
//  XDTableviewDemo
//
//  Created by CumminsTY on 2018/10/29.
//  Copyright © 2018 --. All rights reserved.
//

#import "UIView+NoDataView.h"
#import <objc/runtime.h>
#import "Masonry.h"

@implementation UIView (NoDataView)

#pragma mark - 动态创建属性

static char kAssociatedObjectKey_noDataView;
static char kAssociatedObjectKey_reloadBlock;

- (void)setNoDataView:(UIView *)noDataView {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_noDataView, noDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)noDataView {
    return (objc_getAssociatedObject(self, &kAssociatedObjectKey_noDataView));
}

- (void)setReloadBlock:(ReloadClickBlock)reloadBlock {
    objc_setAssociatedObject(self, &kAssociatedObjectKey_reloadBlock, reloadBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ReloadClickBlock)reloadBlock {
    return objc_getAssociatedObject(self, &kAssociatedObjectKey_reloadBlock);
}

#pragma mark - 展示界面

-(void) showNoDataWithType:(NoDataType)type  btnBlock:(ReloadClickBlock)clickReload{
    self.reloadBlock = clickReload;
    if (self.noDataView) {
        [self.noDataView removeFromSuperview];
        self.noDataView = nil;
    }
    
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = NO;
    }
    
    self.noDataView = [[UIView alloc] init];
    [self addSubview:self.noDataView];
    self.noDataView.backgroundColor = [UIColor whiteColor];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(self);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.noDataView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageView.superview);
        make.centerY.mas_equalTo(imageView.superview).mas_offset(-80);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    [self.noDataView addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(descLabel.superview);
        make.top.mas_equalTo(imageView.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *reloadButton = [[UIButton alloc] init];
    [self.noDataView addSubview:reloadButton];
    [reloadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
    reloadButton.layer.borderWidth = 0.5;
    reloadButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [reloadButton addTarget:self action:@selector(reloadClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(reloadButton.superview);
        make.top.mas_equalTo(descLabel.mas_bottom).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    switch (type) {
        case NoDataTypeNoNet: // 网络不好
        {
            imageView.image = [UIImage imageNamed:@"noData"];
            descLabel.text = @"网络异常";
        }
            break;
            
        case NoDataTypeDefalut:
        {
            imageView.image = [UIImage imageNamed:@"noData"];
            descLabel.text = @"无数据";
        }
            break;
            
        default:
            break;
    }
}


-(void)reloadClick:(UIButton*)sender{
    if (self.reloadBlock) {
        self.reloadBlock();
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.noDataView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.noDataView removeFromSuperview];
        self.noDataView = nil;
    }];
    
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        scrollView.scrollEnabled = YES;
    }
}

-(void)hideNoDataView{
    if (self.noDataView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.noDataView.alpha = 0;
        } completion:^(BOOL finished) {
            [self.noDataView removeFromSuperview];
            self.noDataView = nil;
        }];
    }
}



@end
