//
//  SRCollectionView.m
//  SRCollectionView
//
//  Created by ying on 2017/7/2.
//  Copyright © 2017年 SUIRUI. All rights reserved.
//

#import "SRCollectionView.h"

@implementation SRCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
