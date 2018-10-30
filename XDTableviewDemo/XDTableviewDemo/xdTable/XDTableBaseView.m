//
//  XDTableBaseView.m
//  TestTable
//
//  Created by CumminsTY on 2018/10/22.
//  Copyright © 2018年 CumminsTY. All rights reserved.
//

#import "XDTableBaseView.h"
#import "XDBaseCellModel.h"
#import "XDTableBaseCell.h"
@interface XDTableBaseView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray<XDTableBaseSection*> * sections;
@property (nonatomic,strong)NSMutableDictionary <Class,Class>* cellClassMap;
@property (nonatomic,assign)NSInteger row;
@end
@implementation XDTableBaseView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    return [self initWithFrame:frame style:style showRefresh:YES];
//    self = [super initWithFrame:frame style:style];
//    if (self) {
//        [self setup];
//    }
//    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style showRefresh:(BOOL)showRefresh{
    self =  [super initWithFrame:frame style:style];
    if (self) {
        [self setup];
        if (showRefresh) {
            [self setupRefresh];
        }
    }
    return self;
}



-(void)setup{
    self.delegate = self;
    self.dataSource = self;
    self.row = 1;
    [self adaptIos11];
}


-(void)adaptIos11{
    if (@available(iOS 11.0, *)) {
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    self.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [self.mj_header beginRefreshing];
        
        self.row = 1;
        if (self.block) {
            self.block(XDTableRefreshTypeNew);
        }
    }];
    
    self.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [self.mj_footer beginRefreshing];
        self.row++;
        if (self.block) {
            self.block(XDTableRefreshTypeMore);
        }
    }];
}

#pragma mark tableDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.sections.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.sections.count>0) {
        return (NSUInteger)self.sections[section].viewModels.count;
    }return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XDTableBaseSection * section = self.sections[indexPath.section];
    id viewModel = section.viewModels[indexPath.row];
    XDTableBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:[self identifierWithViewModel:viewModel] forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    [cell setCellData:viewModel];
    [section bindCell:cell indexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  XDBaseCellModel *model =  self.sections[indexPath.section].viewModels[indexPath.row];
    Class cellClass =  self.cellClassMap[[model class] ];
    if ([cellClass isSubclassOfClass:[XDTableBaseCell class]]) {
        return [cellClass cellHeightWithCellData:model];
    }
    return [XDTableBaseCell cellHeightWithCellData:model];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    XDTableBaseSection * xdSection = self.sections[section];
    if (self.xdDelegate&&[self.xdDelegate respondsToSelector:@selector(xd_tableView:viewForHeaderInSection:)] ) {
      return  [self.xdDelegate xd_tableView:self viewForHeaderInSection:xdSection];
    }return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    XDTableBaseSection * xdSection = self.sections[section];
    if (self.xdDelegate&&[self.xdDelegate respondsToSelector:@selector(xd_tableView:viewForFooterInSection:)] ) {
        return  [self.xdDelegate xd_tableView:self viewForFooterInSection:xdSection];
    }return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    XDTableBaseSection * xdSection = self.sections[section];
    if (self.xdDelegate&&[self.xdDelegate respondsToSelector:@selector(xd_tableView:heightForHeaderInSection:)] ) {
        return  [self.xdDelegate xd_tableView:self heightForHeaderInSection:xdSection];
    }
    return 0.0001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    XDTableBaseSection * xdSection = self.sections[section];
    if (self.xdDelegate&&[self.xdDelegate respondsToSelector:@selector(xd_tableView:heightForFooterInSection:)] ) {
        return  [self.xdDelegate xd_tableView:self heightForFooterInSection:xdSection];
    }
    return 0.0001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XDTableBaseSection * xdSection = self.sections[indexPath.section];

    if (self.xdDelegate&&[self.xdDelegate respondsToSelector:@selector(xd_tableView:didSelectRowAtIndexPath:section:withObject:)]) {
        id obj = [xdSection objectForSelectRowIndex:indexPath.row];
        [self.xdDelegate xd_tableView:self didSelectRowAtIndexPath:indexPath section:xdSection withObject:obj];
    }
}


#pragma mark public
-(void)registSection:(XDTableBaseSection *)section{
    if (section == nil) {
        NSLog(@"注册失败,section为nil");
        return;
    }
    
    NSDictionary<NSString *, NSString *> *dict = [[section class] CellClassWithCellModel];
    
    __weak __typeof(self) weakSelf = self;
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        Class cellClass = NSClassFromString(key);
        Class viewModelClass = NSClassFromString(obj);
        [strongSelf bindCellClass:cellClass withViewModelClass:viewModelClass];
    }];
    [self.sections addObject:section];
}

#pragma mark private

-(void)bindCellClass:(Class)cellClass withViewModelClass:(Class)viewModelClass{
    [self registerCellWithClass:cellClass];
    self.cellClassMap[(id<NSCopying>)viewModelClass] = cellClass;
}

- (void)registerCellWithClass:(Class)clazz {
    
    NSLog(@"register %@",NSStringFromClass(clazz));
    NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clazz) ofType:@"nib"];
    if (path != nil) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(clazz) bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:[self identifierWithCellClass:clazz]];
    } else {
        [self registerClass:clazz forCellReuseIdentifier:[self identifierWithCellClass:clazz]];
    }
}


-(NSString*)identifierWithViewModel:(id)viewModel{
    return [self identifierWithCellClass:self.cellClassMap[[viewModel class]]];
}

-(NSString*)identifierWithCellClass:(Class)cellClass{
    return NSStringFromClass(cellClass);
}



#pragma mark getter

- (NSMutableArray<XDTableBaseSection *> *)sections {
    if (_sections == nil) {
        _sections = [NSMutableArray new];
    }
    return _sections;
}

//- (NSMutableArray<YLTableViewSection *> *)visibleSections {
//    if (_visibleSections == nil) {
//        _visibleSections = [NSMutableArray new];
//    }
//    return _visibleSections;
//}

- (NSMutableDictionary<Class,Class> *)cellClassMap {
    if (_cellClassMap == nil) {
        _cellClassMap = [NSMutableDictionary dictionary];
    }
    return _cellClassMap;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
