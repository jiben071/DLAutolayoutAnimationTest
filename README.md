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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > kScrollDistance  && currentPostion > 0) {        //这个地方加上 currentPostion > 0 即可）
        NSLog(@"ScrollUp now");
        if (self.isExpand) {
            self.isExpand = NO;
        }
    }else if ((_lastPosition - currentPostion > kScrollDistance) && (currentPostion  <= scrollView.contentSize.height-scrollView.bounds.size.height-kScrollDistance) ){//这个地方加上后边那个即可，也不知道为什么，再减20才行   展现
        NSLog(@"ScrollDown now");
        if (!self.isExpand) {
            self.isExpand = YES;
        }
    }
    _lastPosition = currentPostion;
}
~~~
