//
//  SRCollectionView.m
//  SRCollectionView
//
//  Created by ying on 2017/7/2.
//  Copyright © 2017年 SUIRUI. All rights reserved.
//
#define MAS_SHORTHAND
#import "SRCollectionView.h"
#import "Masonry.h"

@implementation SRCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];
    
    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self addSubview:redView];
    
    UIView *blueView = UIView.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];
    
    UIView *grayView = [UIView new];
    grayView.backgroundColor = UIColor.cyanColor;
    grayView.layer.borderColor = UIColor.cyanColor.CGColor;
    grayView.layer.borderWidth = 2;
    [self addSubview:grayView];
    UIView *superview = self;
    int padding = 10;
    
    //if you want to use Masonry without the mas_ prefix
    //define MAS_SHORTHAND before importing Masonry.h see Masonry iOS Examples-Prefix.pch
    [greenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.top).offset(padding);
        make.left.equalTo(superview.left).offset(padding);
        make.bottom.equalTo(blueView.top).offset(-padding);
        make.right.equalTo(redView.left).offset(-padding);
        make.width.equalTo(redView.width);
        
        make.height.equalTo(redView.height);
        make.height.equalTo(blueView.height);
        
    }];
    
    //with is semantic and option
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding); //with with
        make.left.equalTo(greenView.mas_right).offset(padding); //without with
        make.bottom.equalTo(blueView.mas_top).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.width.equalTo(greenView.mas_width);
        
        make.height.equalTo(@[greenView, blueView]); //can pass array of views
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(greenView.mas_bottom).offset(padding);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.bottom.equalTo(superview.mas_bottom).offset(-padding);
        make.right.equalTo(grayView.left).offset(-padding);
        make.width.equalTo(grayView.width);
        
        make.height.equalTo(redView.height);
        make.height.equalTo(greenView.height);
    }];
    
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(redView.mas_bottom).offset(padding);
        make.left.equalTo(blueView.right).offset(padding);
        make.bottom.equalTo(superview.mas_bottom).offset(-padding);
        make.right.equalTo(superview.mas_right).offset(-padding);
        make.width.equalTo(blueView.width);
        
        make.height.equalTo(blueView.height);
        make.height.equalTo(greenView.height);
    }];

}

@end
