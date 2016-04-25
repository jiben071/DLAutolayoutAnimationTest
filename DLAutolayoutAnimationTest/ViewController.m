//
//  ViewController.m
//  DLAutolayoutAnimationTest
//
//  Created by denglong on 16/4/22.
//  Copyright © 2016年 denglong. All rights reserved.
//

#import "ViewController.h"

#define kIdentiferString @"cell"
#define kScrollDistance 10

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCon;

@property (nonatomic,assign) BOOL isExpand;/**< 是否展开 */
@property (nonatomic,strong) NSMutableArray *dataList; /**< 数据源 */
@property (nonatomic,assign) CGFloat lastPosition;
@property (nonatomic,assign) float lastContentOffset;
@end

@implementation ViewController
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _bottomCon.constant = 44;
    self.isExpand = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.view layoutIfNeeded];
    
    //tableview部分被导航栏遮盖解决
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - 关键代码：动画设置
- (void)setIsExpand:(BOOL)isExpand{
    [UIView animateWithDuration:0.25 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.bottomCon.constant = isExpand?44.0f:0.0f;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        _isExpand = isExpand;
    }];
    [self.navigationController setNavigationBarHidden:!isExpand animated:YES];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarHidden:!isExpand withAnimation:NO];
#pragma clang diagnostic pop
}


#pragma mark - 关键代码：滚动方向判断
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self.lastContentOffset < scrollView.contentOffset.y) {
        NSLog(@"向上滚动");
        if (self.isExpand) {
            self.isExpand = NO;
        }
    }else{
        NSLog(@"向下滚动");
        if (!self.isExpand) {
            self.isExpand = YES;
        }
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentiferString];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kIdentiferString];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"行%@",@(indexPath.row)];
    return cell;
}

@end
