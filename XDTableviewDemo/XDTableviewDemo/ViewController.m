//
//  ViewController.m
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import "ViewController.h"
#import "XDTableBaseView.h"
#import "SectionA.h"
#import "ModelA.h"

#define kScreenWidth     [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<XDTableBaseViewDelegate,refreshCellDelegate>
@property (nonatomic,strong)SectionA * aSection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    self.view.backgroundColor = [UIColor whiteColor];
    XDTableBaseView * table = [[XDTableBaseView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100) style:UITableViewStylePlain showRefresh:YES];
    table.xdDelegate = self;
    table.backgroundColor = [UIColor whiteColor];
    table.tag = 100;
    UIView * foot = [UIView new];
    table.tableFooterView = foot;
    
    
    
    
    __weak typeof(table)weakTable = table;
    __weak typeof(self)weakSelf = self;
    table.block = ^(XDTableRefreshType refreshStyle) {
        if (!refreshStyle) {
            [weakSelf.aSection.viewModels removeAllObjects];
            [weakSelf lodaData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakTable.mj_header endRefreshing];
                
            });
            
        }else{
            [weakSelf lodaData];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakTable.mj_footer endRefreshing];
                
            });
        }
    };
    
    
    [table registSection: self.aSection];
    [self.view addSubview:table];
    
    [self lodaData];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)test{
    NSString * tmpstr = @"截止前3小时";
    NSArray *dataArray = @[@[@"不提醒"],
                           @[@"截止前15分钟",
                             @"截止前1小时",
                             @"截止前3小时",
                             @"截止前1天"]
                           ];
    
    for (int i = 0; i<dataArray.count; i++) {
        //        NSArray * arr = dataArray[i];
        for (int j = 0; j<[dataArray[i]count]; j++) {
            NSString * str = dataArray[i][j];
            if ([str isEqualToString:tmpstr]) {
                NSLog(@"i = %d,j = %d",i,j);
                break;
            }
        }
    }
}


-(void)lodaData{
    
    UITableView * table = [self.view viewWithTag:100];
    [table reloadData];
    
    if (self.aSection.viewModels.count<=0) {
        [table showNoDataWithType:NoDataTypeDefalut btnBlock:^{
            NSLog(@"点击重新加载");
            ModelA *viewModel1 = [[ModelA alloc] initWithTitle:@"modelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelA"];
            ModelA *viewModel2 = [[ModelA alloc] initWithTitle:@"ModelA: Test 2  ModelA: Test 2  ModelA: Test 2"];
            ModelA *viewModel3 = [[ModelA alloc] initWithTitle:@"ModelA: Test 3"];
            ModelA *viewModel4 = [[ModelA alloc] initWithTitle:@"ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 "];
            [self.aSection.viewModels addObjectsFromArray:@[viewModel1,viewModel2,viewModel3,viewModel4]];
            [table reloadData];
        }];
        
    }else{
        [table hideNoDataView];
    }
}


-(void)xd_tableView:(XDTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath section:(XDTableBaseSection *)section withObject:(id)obj{
    NSLog(@"obj = %@",obj);
}
-(void)refreshCell{
    NSLog(@"刷新cell");
}
-(SectionA *)aSection{
    if (!_aSection) {
        _aSection = [[SectionA alloc]init];
        _aSection.delegate = self;
    }
    return _aSection;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
