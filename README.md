# DLAutolayoutAnimationTest
滚动隐藏工具条实例

##1.关键代码
~~~
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
~~~
