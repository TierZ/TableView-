//
//  ModelA.h
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import "XDBaseCellModel.h"

@interface ModelA : XDBaseCellModel
@property (nonatomic,copy) NSString * title;
- (instancetype)initWithTitle:(NSString*)title;
@end
