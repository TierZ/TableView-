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


@interface ViewController ()<XDTableBaseViewDelegate>
@property (nonatomic,strong)SectionA * aSection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    XDTableBaseView * table = [[XDTableBaseView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight-100) style:UITableViewStylePlain showRefresh:YES];
    table.xdDelegate = self;
    table.tag = 100;
    UIView * foot = [UIView new];
    table.tableFooterView = foot;
    
    
    
  
    
    __weak typeof(table)weakTable = table;
    __weak typeof(self)weakSelf = self;
    table.block = ^(XDTableRefreshType refreshStyle) {
            if (!refreshStyle) {
                [weakSelf.aSection.viewModels removeAllObjects];
                [weakSelf lodaData];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakTable.mj_header endRefreshing];
                    
                });
                
            }else{
                [weakSelf lodaData];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakTable.mj_footer endRefreshing];

                });
            }
    };
    
    
  
    [self lodaData];
    [table registSection: self.aSection];
    [self.view addSubview:table];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)lodaData{
    ModelA *viewModel1 = [[ModelA alloc] initWithTitle:@"modelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelAmodelA"];
    ModelA *viewModel2 = [[ModelA alloc] initWithTitle:@"ModelA: Test 2  ModelA: Test 2  ModelA: Test 2"];
    ModelA *viewModel3 = [[ModelA alloc] initWithTitle:@"ModelA: Test 3"];
    ModelA *viewModel4 = [[ModelA alloc] initWithTitle:@"ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 ModelA: Test 4 "];
    [self.aSection.viewModels addObjectsFromArray:@[viewModel1,viewModel2,viewModel3,viewModel4]];
    UITableView * table = [self.view viewWithTag:100];
    [table reloadData];
}


-(void)xd_tableView:(XDTableBaseView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath section:(XDTableBaseSection *)section withObject:(id)obj{
    NSLog(@"obj = %@",obj);
}

-(SectionA *)aSection{
    if (!_aSection) {
        _aSection = [[SectionA alloc]init];
    }
    return _aSection;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
