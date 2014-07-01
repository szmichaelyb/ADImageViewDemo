//
//  ViewController.h
//  ADImageViewDemo
//
//  Created by liuzhihui on 14-7-1.
//  Copyright (c) 2014年 liuzhihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADImageViewController.h"

@interface ViewController : UIViewController<ADImageViewDelegate>
{
    ADImageViewController *imageScrollView;
    NSMutableArray *adImgArray;
}
@end
