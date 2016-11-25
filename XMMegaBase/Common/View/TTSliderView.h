//
//  TTSliderView.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "SwipeView.h"

/**
 *  TTSliderView 的 PageControl 样式
 */
typedef NS_ENUM(NSInteger, SliderViewPageControlStyle){
    /**
     *  点
     */
    SliderViewPageControlStyleDot,
    /**
     *  数字
     */
    SliderViewPageControlStyleNumber,
};

/**
 *  TTSliderView 的 PageControl 对齐方式
 */
typedef NS_ENUM(NSInteger, SliderViewPageControlAlignment){
    /**
     *  左对齐
     */
    SliderViewPageControlAlignmentLeft      = 0,
    /**
     *  居中对齐
     */
    SliderViewPageControlAlignmentCenter    = 1,
    /**
     *  右对齐
     */
    SliderViewPageControlAlignmentRight     = 2,
};

@interface TTPageCountView : UIView
- (instancetype)initWithPageNumber:(NSInteger)number;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPages;
@end

@protocol TTSliderViewDelegate;
@protocol TTSliderViewDataSource;


@interface TTSliderView : UIView <SwipeViewDelegate, SwipeViewDataSource>
@property(nonatomic, readonly) UIPageControl *pageControl;
@property(nonatomic, readonly) TTPageCountView *pageView;
@property(nonatomic, readonly) SwipeView *swipeView;

@property(nonatomic, weak) id <TTSliderViewDelegate> delegate;
@property(nonatomic, weak) id <TTSliderViewDataSource> dataSource;

/**
 *  创建 sliderview
 *
 *  @param frame frame
 *  @param style pagecontrol 样式
 *  @param alignment pagecontrol 对齐方式
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame style:(SliderViewPageControlStyle)style alignment:(SliderViewPageControlAlignment)alignment;

/**
* 所有页面的数量
*/
@property(nonatomic, readonly) NSInteger totalItemCount;

/**
* 现在页面的索引
*/
@property(nonatomic, assign) NSInteger currentIndex;

/**
* 是否启用循环滚动
*/
@property(nonatomic, assign) BOOL wrapEnabled;

/**
* 是否启用自动滚动
*/
@property(nonatomic, assign) BOOL autoScroll;

/**
 * 设置pagecontrol选中的颜色
 */
@property (nonatomic, strong) UIColor *currentPageColor;

/**
* 当只有一张图片的时候禁用滚动
*/
@property(nonatomic) BOOL disableScrollOnlyOneImage;

/**
* 重载数据
*/
- (void)reloadData;

/**
* 滚动到指定的项
*/
- (void)scrollToItemAtIndex:(NSInteger)index;

- (void)jumpToItemAtIndex:(NSInteger)index;

@end


/**
*  SliderViewDelegate
*/
@protocol TTSliderViewDelegate <NSObject>
@optional
/**
*  选中了 SliderView 中某个 cell
*
*  @param swipeView swipeView
*  @param index      cell 的索引
*/
- (void)sliderView:(TTSliderView *)sliderView didSelectViewAtIndex:(NSInteger)index;

/**
*  SliderView 滚动到某个 cell
*
*  @param swipeView swipeView
*  @param index      cell 的索引
*/
- (void)sliderView:(TTSliderView *)sliderView didSliderToIndex:(NSInteger)index;

- (void)sliderViewDidScroll:(TTSliderView *)sliderView;

- (void)sliderViewWillBeginDragging:(TTSliderView *)sliderView;

- (void)sliderViewDidEndDragging:(TTSliderView *)sliderView willDecelerate:(BOOL)decelerate;

- (void)sliderViewWillBeginDecelerating:(TTSliderView *)sliderView;

- (void)sliderViewDidEndDecelerating:(TTSliderView *)sliderView;

- (void)sliderViewDidEndScrollingAnimation:(TTSliderView *)sliderView;

@end



/**
*  SliderViewDataSource
*/
@protocol TTSliderViewDataSource <NSObject>

@required
/**
*  swipeView 中的 cell 数量
*
*  @param swipeView swipeView
*
*  @return cell 数量
*/
- (NSInteger)numberOfItemsInSliderView:(TTSliderView *)sliderView;

/**
*  某个索引的 view
*
*  @param swipeView swipeView
*  @param index      index
*
*  @return 这个Slider要显示的view
*/
- (UIView *)sliderView:(TTSliderView *)sliderView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view;


@end