//
//  ViewController.m
//  SRCollectionView
//
//  Created by 颖 on 2017/7/2.
//  Copyright © 2017年 SUIRUI. All rights reserved.
//
#define MAS_SHORTHAND

#define kWidth [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"
#import "SRCollectionView.h"
#import "Masonry.h"

@interface ViewController () <UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) SRCollectionView *leftView;

@property (nonatomic, strong) SRCollectionView *currentView;

@property (nonatomic, strong) SRCollectionView *rightView;

@property (nonatomic, assign) int currentViewIndex;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加scrollView
    [self.view addSubview:self.scrollView];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self generateContent];
}

// 添加滑动视图
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        [_scrollView setContentOffset:CGPointMake(kWidth, 0)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (void)generateContent {
    UIView* contentView = UIView.new;
    [self.scrollView addSubview:contentView];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    UIView *lastView;
    
    int padding = 0;
    for (int i = 0; i < 3; i++) {
        SRCollectionView *view = SRCollectionView.new;
        [contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.top).offset(padding);
            make.left.equalTo(lastView ? lastView.right:@0);
            make.width.equalTo(self.view.width);
            make.height.equalTo(contentView.height);
        }];
        lastView = view;
        switch (i) {
            case 0:
                _leftView = view;
                break;
            case 1:
                _currentView = view;
                break;
            case 2:
                _rightView = view;
                break;
            default:
                break;
        }
    }
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.right);
    }];
}
#pragma mark ---- 滚动将要停止的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadData];
    [_scrollView setContentOffset:CGPointMake(kWidth*_currentViewIndex, 0)];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)loadData
{
    if (_scrollView.contentOffset.x > kWidth) {
        NSLog(@"右滑动");
        _currentViewIndex = (_currentViewIndex + 1) % 5;
        
    } else if (_scrollView.contentOffset.x < kWidth) {
        NSLog(@"左滑动");
        _currentViewIndex = (_currentViewIndex + 4 ) % 5;
    }  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
