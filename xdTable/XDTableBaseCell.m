//
//  XDTableBaseCell.m
//  TestTable
//
//  Created by CumminsTY on 2018/10/23.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import "XDTableBaseCell.h"

@implementation XDTableBaseCell{
    CGFloat sizeOnePx;
}

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)cellHeightWithCellData:(id)cellData{
    return [self cellHeightWithCellData:cellData boundWidth:[UIScreen mainScreen].bounds.size.width];
}

+ (CGFloat)cellHeightWithCellData:(id)cellData boundWidth:(CGFloat)width{
    return 44.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self internalInit];
        
        _separateLineOffset = 0;
        sizeOnePx = 1.0 / [UIScreen mainScreen].scale;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInit];
    }
    return self;
}

-(void)internalInit{
    
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    
    _lineColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0];
    
    _topLineView = [[UIView alloc] init];
    _topLineView.backgroundColor = _lineColor;
    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = _lineColor;
    
    [self.contentView addSubview:_topLineView];
    [self.contentView addSubview:_bottomLineView];
    
    //初始化的时候隐藏线
    _topLineView.hidden = YES;
    _bottomLineView.hidden = YES;
}


-(void)setCellType:(XDBaseCellType)type{
    _cellType = type;
    
    switch (_cellType) {
            
        case XDBaseCellNone:
            _topLineView.hidden = YES;
            _bottomLineView.hidden = YES;
            break;
            
        case XDBaseCellAtFirst:
        case XDBaseCellNormal:
        case XDBaseCellAtMiddle:
            _topLineView.hidden = NO;
            _bottomLineView.hidden = YES;
            break;
            
        case XDBaseCellAtLast:
        case XDBaseCellSingle:
            _topLineView.hidden = NO;
            _bottomLineView.hidden = NO;
            break;
        case XDBaseCellDoubleOffset:
            _topLineView.hidden = YES;
            _bottomLineView.hidden = NO;
            break;
            
        default:
            break;
    }
    
    [self setNeedsLayout];
}

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _topLineView.backgroundColor = _lineColor;
    _bottomLineView.backgroundColor = _lineColor;
}



- (void)setCellData:(id)cellData {
    _xdCellData = cellData;
    self.textLabel.text = @"indexpath";
}

- (void)setSeperatorLine:(NSIndexPath *)indexPath numberOfRowsInSection:(NSInteger)numberOfRowsInSection{
    if (numberOfRowsInSection == 1) {
        self.cellType = XDBaseCellSingle;
    }
    else {
        if (indexPath.row == 0) {
            self.cellType = XDBaseCellAtFirst;
        }
        else if (indexPath.row == numberOfRowsInSection - 1) {
            self.cellType = XDBaseCellAtLast;
        }
        else {
            self.cellType = XDBaseCellAtMiddle;
        }
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    switch (_cellType) {
        case XDBaseCellNone:
            _topLineView.frame = CGRectMake(_separateLineOffset, 0.0, self.frame.size.width - _separateLineOffset, sizeOnePx);
            _bottomLineView.frame = CGRectMake(_separateLineOffset, self.bounds.size.height - sizeOnePx, self.frame.size.width - _separateLineOffset, sizeOnePx);
            break;
            
        case XDBaseCellAtFirst:
            _topLineView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, sizeOnePx);
            _bottomLineView.frame = CGRectMake(_separateLineOffset, self.bounds.size.height - sizeOnePx, self.frame.size.width - _separateLineOffset, sizeOnePx);
            break;
            
        case XDBaseCellAtMiddle:
        case XDBaseCellNormal:
            _topLineView.frame = CGRectMake(_separateLineOffset, 0.0, self.frame.size.width - _separateLineOffset, sizeOnePx);
            _bottomLineView.frame = CGRectMake(_separateLineOffset, self.bounds.size.height - sizeOnePx, self.frame.size.width - _separateLineOffset, sizeOnePx);
            break;
            
        case XDBaseCellAtLast:
            _topLineView.frame = CGRectMake(_separateLineOffset, 0.0, self.frame.size.width - _separateLineOffset, sizeOnePx);
            _bottomLineView.frame = CGRectMake(0.0, self.bounds.size.height - sizeOnePx, self.frame.size.width, sizeOnePx);
            break;
            
        case XDBaseCellSingle:
            _topLineView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, sizeOnePx);
            _bottomLineView.frame = CGRectMake(0.0, self.bounds.size.height - sizeOnePx, self.frame.size.width, sizeOnePx);
            break;
        case XDBaseCellDoubleOffset:
            _topLineView.frame = CGRectMake(_separateLineOffset, 0.0, self.frame.size.width-_separateLineOffset*2, sizeOnePx);
            _bottomLineView.frame = CGRectMake(_separateLineOffset, self.bounds.size.height - sizeOnePx, self.frame.size.width-_separateLineOffset*2, sizeOnePx);
            break;
        default:
            break;
    }
}

@end
