//
//  ADImageView.h
//  ADImageViewDemo
//
//  Created by liuzhihui on 14-7-1.
//  Copyright (c) 2014年 liuzhihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJManagedImageV.h"

@interface ADImageView : UIView
{
    HJManagedImageV *imgView;
    UILabel *imageTitle;
    UIView *shadowView;
}

@property (nonatomic, strong) HJManagedImageV *imgView;
@property (nonatomic, strong) UILabel *imageTitle;

@end
