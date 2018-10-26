//
//  ACell.m
//  TestTable
//
//  Created by CumminsTY on 2018/10/24.
//  Copyright © 2018 CumminsTY. All rights reserved.
//

#import "ACell.h"
#import "ModelA.h"

@interface ACell()
@property (nonatomic,strong)UIButton * btn;
@property (nonatomic,strong)UILabel * title;
@end

@implementation ACell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.numberOfLines = 0;
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.btn];
        self.title.frame = CGRectMake(10, 10, 200, 0);
        self.btn.frame = CGRectMake(250, 10, 50, 50);
    }
    return self;
}

-(void)setCellData:(id)cellData{
    ModelA * a = (ModelA*)cellData;
    self.title.text = a.title;
    NSDictionary *dic=@{
                        
                        NSFontAttributeName:[UIFont systemFontOfSize:15]
                        
                        };
    CGSize size=[a.title boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.title.frame = CGRectMake(0, 10, 200, size.height);
    
}
+(CGFloat)cellHeightWithCellData:(id)cellData{
    ModelA * a = (ModelA*)cellData;
    if (a.cellHeight>0) {
        return a.cellHeight;
    }
    NSString * str = a.title;
    NSDictionary *dic=@{
                        
                        NSFontAttributeName:[UIFont systemFontOfSize:15]
                        
                        };
    CGSize size=[str boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    CGFloat height = size.height>50? (size.height+10+10):70;
    a.cellHeight = height;

    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)click:(UIButton*)sender{
    if (self.clickDelegate&&[self.clickDelegate respondsToSelector:@selector(btnClick:)]) {
        [self.clickDelegate btnClick:self];
    }
}

#pragma mark
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = [UIColor lightGrayColor];
        _title.numberOfLines = 0;
    }
    return _title;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.backgroundColor = [UIColor redColor];
        [_btn setTitle:@"点击" forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _btn;
}

@end
