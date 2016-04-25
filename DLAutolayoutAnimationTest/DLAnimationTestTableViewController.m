//
//  DLAnimationTestTableViewController.m
//  DLAutolayoutAnimationTest
//
//  Created by denglong on 16/4/22.
//  Copyright © 2016年 denglong. All rights reserved.
//

#import "DLAnimationTestTableViewController.h"



@interface DLAnimationTestTableViewController ()
@property (strong, nonatomic) IBOutlet UIView *toolBar;
@property (nonatomic,strong) NSLayoutConstraint *toolYCon;/**< <#commentOut#> */

@property (nonatomic,assign) BOOL isExpand;/**< 是否展开 */
@end

@implementation DLAnimationTestTableViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.toolYCon.constant = self.view.frame.size.height;
    [self.tableView layoutIfNeeded];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.toolBar];
    [self.view bringSubviewToFront:self.toolBar];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *toolXCon = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0];
    NSLayoutConstraint *toolYCon = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
    
    NSLayoutConstraint *toolWCon = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:self.view.frame.size.width];
    NSLayoutConstraint *toolHCon = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
    
    [self.tableView addConstraint:toolXCon];
    [self.tableView addConstraint:toolYCon];
    [self.toolBar addConstraint:toolHCon];
    [self.toolBar addConstraint:toolWCon];
    
    toolXCon.active = YES;
    toolYCon.active = YES;
    toolHCon.active = YES;
    toolWCon.active = YES;
    
    for (NSLayoutConstraint *con in self.tableView.constraints) {
        if (con.firstItem == self.toolBar && con.firstAttribute == NSLayoutAttributeTop) {
            self.toolYCon = con;
        }
    }
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < - 1) {
        if (offsetY > - 200) {
            if (self.isExpand) {//收起
                self.isExpand = NO;
                [UIView animateWithDuration:1.25 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                    self.toolYCon.constant = self.view.frame.size.height;
                    [self.tableView layoutIfNeeded];
                } completion:^(BOOL finished) {
                    
                }];
            }
        }
    }
    
    if (offsetY >  1) {
        if (offsetY <  200) {//展开
            self.isExpand = YES;
            [UIView animateWithDuration:1.25 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:10.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                self.toolYCon.constant = self.view.frame.size.height - 44.0f;
                [self.tableView layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

@end
