//
//  ADImageViewController.m
//  ADImageViewDemo
//
//  Created by liuzhihui on 14-7-1.
//  Copyright (c) 2014年 liuzhihui. All rights reserved.
//


#import "ADImageViewController.h"
#import "HJManagedImageV.h"
#import "AllDefine.h"
#import "DataCenter.h"

static CGFloat SWITCH_AD_PICTURE_INTERVAL = 150.0;

@interface ADImageViewController()

<<<<<<< HEAD
- (void)switchADImageItems;
=======
- (void)switchFocusImageItems;
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
- (void)moveToTargetPosition:(CGFloat)targetX;

@end


@implementation ADImageViewController
@synthesize delegate;

- (NSArray *)getImgInfoArray
{
    return imgInfoArray;
}

- (void)setImgInfoArray: (NSArray *)array
{
    if ([array count] != 0)
    {
        [imgInfoArray removeAllObjects];
        [imgInfoArray addObjectsFromArray: array];
        
        [self setSubviews];
    }
}

- (id)initWithFrame: (CGRect)frame delegate:(id<ADImageViewDelegate>)aDelegate ADImageInfoArray: (NSArray *)infoArray
{
    self = [super init];
    if (self)
    {
        viewFrame = frame;
        self.imgInfoArray = infoArray;
        self.delegate = aDelegate;
    }
    
    return self;
}

- (id)initWithFrame: (CGRect)frame delegate:(id<ADImageViewDelegate>)aDelegate
{
    self = [super init];
    if (self)
    {
        viewFrame = frame;
        self.delegate = aDelegate;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = viewFrame;
    self.view.backgroundColor = [UIColor whiteColor];
    imgInfoArray = [[NSMutableArray alloc] init];
    imgViewArray = [[NSMutableArray alloc] init];
    
    scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 25, 100, 25)];
    
    [self.view addSubview: scrollView];
    [self.view addSubview: pageControl];
    
    // single tap gesture recognizer
    UITapGestureRecognizer *tapGestureRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureRecognizer:)];
    tapGestureRecognize.numberOfTapsRequired = 1;
    [scrollView addGestureRecognizer:tapGestureRecognize];
    
    [self setSubviews];
}

<<<<<<< HEAD
/**
 *  @brief  イメージとページ制御ビューを生成する
 *
 */
=======
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)setSubviews
{
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * (imgInfoArray.count + 2), scrollView.frame.size.height);
    
    pageControl.numberOfPages = imgInfoArray.count;
    pageControl.currentPage = 0;
    
    [self addImageToScroll];
}

<<<<<<< HEAD
/**
 *  @brief  イメージをビューに加入する
 *
 */
=======
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)addImageToScroll
{
    [imgViewArray removeAllObjects];
    for (int i = 0; i < imgInfoArray.count; i++)
    {
        NSDictionary *dic = [imgInfoArray objectAtIndex: i] ;
        ADImageView *viewItem = [[ADImageView alloc] initWithFrame:CGRectMake((i +1) * self.view.frame.size.width, 0, self.view.frame.size.width, scrollView.frame.size.height)];
        viewItem.tag = i;
        [self setImgViewItem:dic viewItem:viewItem];
        [scrollView addSubview:viewItem];
        [imgViewArray addObject: viewItem];
        if (i == 0) {
            ADImageView *viewItem = [[ADImageView alloc] initWithFrame:CGRectMake((imgInfoArray.count + 1) * self.view.frame.size.width, 0, self.view.frame.size.width, scrollView.frame.size.height)];
            viewItem.tag = i;
            [self setImgViewItem:dic viewItem:viewItem];
            [scrollView addSubview:viewItem];
        }else if(i == imgInfoArray.count - 1){
            ADImageView *viewItem = [[ADImageView alloc] initWithFrame:CGRectMake((0) * self.view.frame.size.width, 0, self.view.frame.size.width, scrollView.frame.size.height)];
            viewItem.tag = i;
            
            [self setImgViewItem:dic viewItem:viewItem];
            [scrollView addSubview:viewItem];
        }
    }
    [scrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height) animated:NO];
    
    
<<<<<<< HEAD
    [self performSelector:@selector(switchADImageItems) withObject:nil afterDelay:SWITCH_AD_PICTURE_INTERVAL];
}

/**
 *  @brief  イメージビューの画像とタートルを設定する
 *
 *  @param  dic  イメージビューの画像とタートル情報
 *  @param  dic  設定されるイメージビュー
 */
=======
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_AD_PICTURE_INTERVAL];
}

>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)setImgViewItem:(NSDictionary *)dic viewItem:(ADImageView *)viewItem
{
    NSString *urlStr = [dic valueForKey: KINFOCELLIMG];
    viewItem.imgView.url = [NSURL URLWithString: urlStr];
    viewItem.imgView.oid = urlStr;
    [[DataCenter sharedCenter] managedObject: viewItem.imgView];
    viewItem.imageTitle.text = [dic valueForKey: KINFOCELLTITLE];
}

<<<<<<< HEAD
/**
 *  @brief  イメージビューのページを移動する
 *
 */
- (void)switchADImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchADImageItems) object:nil];
=======

- (void)switchFocusImageItems
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(switchFocusImageItems) object:nil];
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
    
    CGFloat targetX = scrollView.contentOffset.x + scrollView.frame.size.width;
    [self moveToTargetPosition:targetX];
    
<<<<<<< HEAD
    [self performSelector:@selector(switchADImageItems) withObject:nil afterDelay:SWITCH_AD_PICTURE_INTERVAL];
}

/**
 *  @brief  イメージをクリックする動作をキャプチャーする
 *
 *  @param  gestureRecognizer  クリックする動作
 */
- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer

=======
    [self performSelector:@selector(switchFocusImageItems) withObject:nil afterDelay:SWITCH_AD_PICTURE_INTERVAL];
}

- (void)singleTapGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
{
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
    if (page > -1 && page < imgInfoArray.count+1)
    {
        ADImageView *item = [imgViewArray objectAtIndex: page-1];
        if ([self.delegate respondsToSelector:@selector(ADImageDidSelectItem:)])
        {
            [self.delegate ADImageDidSelectItem:item];
        }
    }
}

<<<<<<< HEAD
/**
 *  @brief  イメージビューのページの数を更新する
 *
 */
=======

>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
- (void)moveToTargetPosition:(CGFloat)targetX
{
    if (targetX >= scrollView.contentSize.width)
    {
        targetX = 0.0;
    }
    
    [scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES] ;
    pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.frame.size.width);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pagewidth/([imgInfoArray count]+2))/pagewidth)+1;
<<<<<<< HEAD
    page --;  // デフォルトで二番目のページから開始する
=======
    page --;  // 默认从第二页开始
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
    pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)myScrollView
{
    CGFloat pagewidth = scrollView.frame.size.width;
    int currentPage = floor((scrollView.contentOffset.x - pagewidth/ ([imgInfoArray count]+2)) / pagewidth) + 1;
    if (currentPage==0)
    {
<<<<<<< HEAD
        [scrollView scrollRectToVisible:CGRectMake(320 * [imgInfoArray count],0,pagewidth,scrollView.frame.size.height) animated:NO];
    }
    else if (currentPage==([imgInfoArray count]+1))
    {
        [scrollView scrollRectToVisible:CGRectMake(320,0,pagewidth,scrollView.frame.size.height) animated:NO];     }
=======
        [scrollView scrollRectToVisible:CGRectMake(320 * [imgInfoArray count],0,pagewidth,scrollView.frame.size.height) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([imgInfoArray count]+1))
    {
        [scrollView scrollRectToVisible:CGRectMake(320,0,pagewidth,scrollView.frame.size.height) animated:NO]; // 最后+1,循环第1页
    }
>>>>>>> 4e01ed72dea717fd1e072871fbb53d12a9739239
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
