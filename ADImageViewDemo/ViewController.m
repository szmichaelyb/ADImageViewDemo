//
//  ViewController.m
//  ADImageViewDemo
//
//  Created by liuzhihui on 14-7-1.
//  Copyright (c) 2014年 liuzhihui. All rights reserved.
//

#import "ViewController.h"
#import "DataCenter.h"
#import "AllDefine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    imageScrollView = [[ADImageViewController alloc] initWithFrame:CGRectMake(0, 104, 320, 120) delegate:self];
    [self.view addSubview:imageScrollView.view];
    adImgArray = [[NSMutableArray alloc] init];
    [self refreshADImgInfoWithType];
    [self initTestWithoutJSON];
}

<<<<<<< HEAD
/**
 *  @brief  イメージのJSON情報を取得できないためのテスト
 *
 */
=======
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)initTestWithoutJSON{
    NSDictionary *dict1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Title1",KINFOCELLTITLE,@"http://www.sogou.com/images/logo/new/sogou.png",KINFOCELLIMG, nil];
    NSDictionary *dict2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Title2",KINFOCELLTITLE,@"http://weixin.sogou.com/images/chuizhi_index/new-wx-logo.v.1.gif",KINFOCELLIMG, nil];
    NSDictionary *dict3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Title3",KINFOCELLTITLE,@"http://www.baidu.com/img/baidu_sylogo1.gif",KINFOCELLIMG, nil];
    NSArray *array = [[NSArray alloc] initWithObjects:dict1,dict2,dict3, nil];
    [self resetADImageArray:array];
}

<<<<<<< HEAD
/**
 *  @brief  イメージのJSON情報を設定し、更新する
 *
 */
=======
//加载焦点轮显图片
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)resetADImageArray: (NSArray *)array
{
    [adImgArray removeAllObjects];
    
    if (array != nil && [array count] != 0)
    {
        [adImgArray addObjectsFromArray: array];
        [imageScrollView setImgInfoArray: adImgArray];
        
    }
}

<<<<<<< HEAD
/**
 *  @brief  イメージのJSON情報を取得し、更新する
 *
 */
=======
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)refreshADImgInfoWithType
{
   [[DataCenter sharedCenter] getADPhotoList:^(NSArray *focusImgs){
        [self resetADImageArray: focusImgs];
        return;
    }onError: ^(NSError *error){
        NSLog(@"AD img error:%@", error);
    }];
    
}

#pragma mark -
#pragma mark ADImageView Delegate
<<<<<<< HEAD
/**
 *  @brief  イメージのタップされたらの動作
 *
 *  @param  item  クリックされたイメージビュー
 */
=======
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)ADImageDidSelectItem:(ADImageView *)item
{
    //
    NSLog(@"Did select image item");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
