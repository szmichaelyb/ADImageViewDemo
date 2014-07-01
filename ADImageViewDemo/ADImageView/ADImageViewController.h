//
//  ADImageViewController.h
//  ADImageViewDemo
//
//  Created by liuzhihui on 14-7-1.
//  Copyright (c) 2014年 liuzhihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ADImageView.h"

@protocol ADImageViewDelegate;

@interface ADImageViewController : UIViewController<UIScrollViewDelegate>
{
    CGRect viewFrame;
    
    UIScrollView *scrollView;
    UIPageControl *pageControl;
    
    NSMutableArray *imgInfoArray;
    NSMutableArray *imgViewArray;
}

@property (nonatomic, assign) id<ADImageViewDelegate> delegate;

- (id)initWithFrame: (CGRect)frame delegate:(id<ADImageViewDelegate>)aDelegate;

- (id)initWithFrame: (CGRect)frame delegate:(id<ADImageViewDelegate>)aDelegate ADImageInfoArray: (NSArray *)infoArray;

- (NSArray *)getImgInfoArray;

- (void)setImgInfoArray: (NSArray *)array;

- (void)addImageToScroll;

@end

#pragma mark - FocusImageViewDelegate
@protocol ADImageViewDelegate <NSObject>

- (void)ADImageDidSelectItem:(ADImageView *)item;



@end
