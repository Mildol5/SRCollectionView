//
//  SRViewController.m
//  SRCollectionView
//
//  Created by ying on 2017/7/6.
//  Copyright © 2017年 SUIRUI. All rights reserved.
//

#import "SRViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeitht [UIScreen mainScreen].bounds.size.height

#define kRedColor [UIColor redColor]
#define kWhitColor [UIColor yellowColor]
#define kBlueColor [UIColor blueColor]
#define kGreenColor [UIColor greenColor]
#define kBrownColor [UIColor brownColor]



@interface SRViewController () <UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UIView *currentView;

@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, assign) int viewCount;

@property (nonatomic, assign) int currentViewIndex;

@property (nonatomic, copy) NSArray *viewColorArray;

@property (nonatomic, copy) NSTimer *timer;

@property (nonatomic, assign) BOOL isScroll;



@end

@implementation SRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewColorArray = @[kRedColor, kBlueColor, kBrownColor, kWhitColor, kGreenColor ];
    
    
    
    // 添加scrollView
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    
    [self loadImageView];
    
    // 创建定时器 实现轮播
    [self zidong];
    // Do any additional setup after loading the view, typically from a nib.
    
}

// 开启定时器
- (void)zidong
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:NULL repeats:YES];
}

// 定时器的方法
-(void)nextPage
{
    _isScroll = YES;
    int rightCout;
    
    [_scrollView setContentOffset:CGPointMake(kWidth * 2, 0)animated:YES];
    
    
    _currentViewIndex = (_currentViewIndex + 1) % 5;
    _currentView.backgroundColor = _viewColorArray[_currentViewIndex];
    
    rightCout = (_currentViewIndex + 1) % 5;
    
    
    _rightView.backgroundColor = _viewColorArray[rightCout];
    
    _pageControl.currentPage = _currentViewIndex;
    [_scrollView setContentOffset:CGPointMake(kWidth, 0) animated:NO];
    
    
    
    
    
}

// 添加滑动视图
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.frame = CGRectMake(0, 0, kWidth, kHeitht);
        
        _scrollView.contentSize = CGSizeMake(kWidth * 3, kHeitht);
        _scrollView.pagingEnabled = YES;
        
        _scrollView.delegate = self;
        [_scrollView setContentOffset:CGPointMake(kWidth, 0)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

// 添加按钮
-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, kHeitht - 100, kWidth, 30);
        _pageControl.currentPage = _currentViewIndex;
        _pageControl.numberOfPages = 5;
        _pageControl.pageIndicatorTintColor = kBlueColor;
        _pageControl.currentPageIndicatorTintColor = kWhitColor;
    }
    return _pageControl;
}

// 加载图片
- (void)loadImageView
{
    _leftView = [[UIView alloc] init];
    _leftView.backgroundColor = _viewColorArray[4];
    _leftView.frame = CGRectMake(0, 0, kWidth, kHeitht);
    [_scrollView addSubview:_leftView];
    
    _currentView = [[UIView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeitht)];
    _currentView.backgroundColor = _viewColorArray[0];
    [_scrollView addSubview:_currentView];
    
    
    _rightView = [[UIView alloc] initWithFrame:CGRectMake(2 * kWidth, 0, kWidth, kHeitht)];
    _rightView.backgroundColor = _viewColorArray[1];
    [_scrollView addSubview:_rightView];
    
    _currentViewIndex = 0;
    
}


#pragma mark ---- 滚动将要停止的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 滚动视图停止减速
    // contentOffset 偏移量
    // 开启定时器
    if (_isScroll == NO) {
        [self zidong];
        _isScroll = YES;
    }
    
    
    [self loadData];
    
    _pageControl.currentPage = _currentViewIndex;
    [_scrollView setContentOffset:CGPointMake(kWidth, 0)];
    
    
    // UIControl 响应的控件 的父类
    //  UIControl
    
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 移除定时器
    
    [self.timer invalidate];
    if (_isScroll == YES) {
        scrollView.contentOffset = CGPointMake(kWidth, 0);
        _currentView.backgroundColor = _viewColorArray[_currentViewIndex];
    }
    _isScroll = NO;
    
    // _currentView = _viewColorArray[_currentViewIndex];
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
    _currentView.backgroundColor = _viewColorArray[_currentViewIndex];
    _leftView.backgroundColor = _viewColorArray[(_currentViewIndex + 4) % 5];
    _rightView.backgroundColor = _viewColorArray[(_currentViewIndex + 1) % 5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
