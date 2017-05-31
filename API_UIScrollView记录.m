//
//  UIScrollView.h
//  UIKit
//
//  Copyright (c) 2007-2015 Apple Inc. All rights reserved.
//
//  Coder_Sun的GitHub地址：https://github.com/272095249
//  Coder_Sun简书网址：http://www.jianshu.com/u/87c7aa9de064
//  iOS-源码解析专栏：http://www.jianshu.com/c/7fe8b38a197b
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIView.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

// ------------------------------------------------------------------------------------------------------------------------------------------

// UIScrollViewIndicatorStyle
typedef NS_ENUM(NSInteger, UIScrollViewIndicatorStyle) {
    UIScrollViewIndicatorStyleDefault,     // 黑与白边，在任何背景下都很好
    UIScrollViewIndicatorStyleBlack,       // 只有黑色，小，在白色背景下良好
    UIScrollViewIndicatorStyleWhite        // 只有白色，小，在黑色背景下良好
};


// UIScrollViewIndicatorStyle
typedef NS_ENUM(NSInteger, UIScrollViewKeyboardDismissMode) {
    UIScrollViewKeyboardDismissModeNone,
    UIScrollViewKeyboardDismissModeOnDrag,      // 当拖动时键盘消失
    UIScrollViewKeyboardDismissModeInteractive, // 键盘跟随拖动触摸屏，并可能再次向上拉，取消消失
} NS_ENUM_AVAILABLE_IOS(7_0);

UIKIT_EXTERN const CGFloat UIScrollViewDecelerationRateNormal NS_AVAILABLE_IOS(3_0);
UIKIT_EXTERN const CGFloat UIScrollViewDecelerationRateFast NS_AVAILABLE_IOS(3_0);

@class UIEvent, UIImageView, UIPanGestureRecognizer, UIPinchGestureRecognizer;
@protocol UIScrollViewDelegate;

NS_CLASS_AVAILABLE_IOS(2_0) @interface UIScrollView : UIView <NSCoding>
// ------------------------------------------------------------------------------------------------------------------------------------------

@property(nonatomic)         CGPoint                      contentOffset;                  // 在滚动视图中，contentOffset属性可以跟踪UIScrollView的具体位置，你能够自己获取和设置它，contentOffset的值是你当前可视内容在滚动视图上面偏移原来的左上角的偏移量
@property(nonatomic)         CGSize                       contentSize;                    // contentSize是内容大小，也就是可以滚动的大小，默认是0，没有滚动效果
@property(nonatomic)         UIEdgeInsets                 contentInset;                   // contentInset增加你在contentSize中指定的内容能够滚动的上下左右区域的距离。
@property(nullable,nonatomic,weak) id<UIScrollViewDelegate>        delegate;                       // default nil. weak reference
@property(nonatomic,getter=isDirectionalLockEnabled) BOOL directionalLockEnabled;         // 默认是NO，指定控件是否只能在一个方向上滚动(默认NO)
@property(nonatomic)         BOOL                         bounces;                        // 默认是YES，就是滚动超过边界会反弹，有反弹回来的效果，如果是NO，那么滚动到达边界会立即停止
@property(nonatomic)         BOOL                         alwaysBounceVertical;           // 默认是NO，如果是YES并且边界可以反弹，即使边界比较小，允许垂直拖动
@property(nonatomic)         BOOL                         alwaysBounceHorizontal;         // 默认是NO，如果是YES并且边界可以反弹，即使边界比较小，允许横向拖动
@property(nonatomic,getter=isPagingEnabled) BOOL          pagingEnabled __TVOS_PROHIBITED;// 当值是YES会自动滚到视图边界的倍数上，默认为NO（也就是是否整页翻动）
@property(nonatomic,getter=isScrollEnabled) BOOL          scrollEnabled;                  // 默认是YES，决定是否可以滚动
@property(nonatomic)         BOOL                         showsHorizontalScrollIndicator; // default YES. 滚动时是否显示水平滚动条
@property(nonatomic)         BOOL                         showsVerticalScrollIndicator;   // default YES. 滚动时是否显示垂直滚动条
@property(nonatomic)         UIEdgeInsets                 scrollIndicatorInsets;          // 设置滚动条的位置
@property(nonatomic)         UIScrollViewIndicatorStyle   indicatorStyle;                 // 滚动条的样式，基本只是设置颜色，总共3个颜色：默认、黑、白
@property(nonatomic)         CGFloat                      decelerationRate NS_AVAILABLE_IOS(3_0);		// 设置手指放开后的减速率


- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;  // 以恒定速度的动画到新的偏移量
- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;         // scroll so rect is just visible (nearest edges). nothing if rect completely visible 		
// 上面这两个函数用来自动滚到想要的位置，此过程中设置有动画效果，停止时，触发该函数。当animated为YES的时候有动画效果


- (void)flashScrollIndicators;             // 短时间内显示滚动条

/*
 Scrolling with no scroll bars is a bit complex. on touch down, we don't know if the user will want to scroll or track a subview like a control.
 on touch down, we start a timer and also look at any movement. if the time elapses without sufficient change in position, we start sending events to
 the hit view in the content subview. if the user then drags far enough, we switch back to dragging and cancel any tracking in the subview.
 the methods below are called by the scroll view and give subclasses override points to add in custom behaviour.
 you can remove the delay in delivery of touchesBegan:withEvent: to subviews by setting delaysContentTouches to NO.

没有滚动条的滚动是一个有点复杂的。在触摸结束后，我们不知道用户将要滚动画着跟踪视图像控制。
在接触下来，我们开始一个计时器，也看任何运动。如果没有足够的时间改变位置，我们开始向中观的内容试图发送事件。如果用户拖拽足够远，我们切换回拖和取消在子视图的任何跟踪。
下面的方法是由滚动视图调用的，给子类重写点添加自定义行为。
你可以删除交货延迟 touchesBegen：withEvent： 设置子视图的delaysContentTouches


 */

@property(nonatomic,readonly,getter=isTracking)     BOOL tracking;        // 当用户touch后还没有开始拖动的时候是YES，否则为NO
@property(nonatomic,readonly,getter=isDragging)     BOOL dragging;        // 如果scrollView正在被拖动，返回YES（检测当前目标是否正在被拖拽）
@property(nonatomic,readonly,getter=isDecelerating) BOOL decelerating;    // 当滚动后，手指放开但是孩子啊继续滚动中。这个时候是YES，其他时候是NO（监控当前目标是否正在减速）

@property(nonatomic) BOOL delaysContentTouches;       // 默认是YES，当值是YES的时候，用户触碰开始，scrollView要延迟一会，看看用户是否有意图滚动。加入滚动了，那么捕捉touch-down时间，否则就不捕捉。加入值是NO，当用户触碰，scrollView会立即触发（控制试图是否延时调用开始滚动的方法）

@property(nonatomic) BOOL canCancelContentTouches;    // 当值是YES的时候，用户触碰后，然后在一定时间内没有移动，scrollView发送tracking events，然后用户移动手指足够长度触发滚动事件，这个时候scrollView发送了touchesCancelled：withEvent：到subView，然后scrollView开始滚动。假如为NO，scrollView发送tracking events后，就算用户移动手指，scrollView也不会滚动（控制控件是否接触取消touch的事件）


- (BOOL)touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event inContentView:(UIView *)view;    // 默认是YES，当值是YES的时候，用户触碰开始，scrollView要延迟一会，看看用户是否有意图滚动。加入滚动了，那么捕捉touch-down时间，否则就不捕捉。加入值是NO，当用户触碰，scrollView会立即触发（控制试图是否延时调用开始滚动的方法）


- (BOOL)touchesShouldCancelInContentView:(UIView *)view;	// 开始发送tracking message消息给subview的时候调用这个方法，决定是否发送tracking message消息给subView，假如返回NO，发送，YES则不发送




@property(nonatomic) CGFloat minimumZoomScale;     // default is 1.0  表示能缩最小的倍数
@property(nonatomic) CGFloat maximumZoomScale;     // default is 1.0. 表示能放最大的倍数

@property(nonatomic) CGFloat zoomScale NS_AVAILABLE_IOS(3_0);            // default is 1.0
- (void)setZoomScale:(CGFloat)scale animated:(BOOL)animated NS_AVAILABLE_IOS(3_0);
- (void)zoomToRect:(CGRect)rect animated:(BOOL)animated NS_AVAILABLE_IOS(3_0);

@property(nonatomic) BOOL  bouncesZoom;          // 和bounces类似，区别在于：这个效果反应在缩放方面加入缩放超过最大缩放，那么会有反弹效果；假如是NO，则到达最大或者最小的时候立即停止

@property(nonatomic,readonly,getter=isZooming)       BOOL zooming;       // 当正在缩放的时候是YES，否则是NO
@property(nonatomic,readonly,getter=isZoomBouncing)  BOOL zoomBouncing;  // 当内容放大到最大或者缩小到最小的时候值是YES，否则是NO

@property(nonatomic) BOOL  scrollsToTop __TVOS_PROHIBITED;          // default is YES.		是否支持滑动到最顶端（点击状态条的时候）


@property(nonatomic, readonly) UIPanGestureRecognizer *panGestureRecognizer NS_AVAILABLE_IOS(5_0);  // 手势类：拖拽

@property(nullable, nonatomic, readonly) UIPinchGestureRecognizer *pinchGestureRecognizer NS_AVAILABLE_IOS(5_0);  // 手势类：捏合

@property(nonatomic, readonly) UIGestureRecognizer *directionalPressGestureRecognizer UIKIT_AVAILABLE_TVOS_ONLY(9_0);   // 手势识别器

@property(nonatomic) UIScrollViewKeyboardDismissMode keyboardDismissMode NS_AVAILABLE_IOS(7_0); // default is UIScrollViewKeyboardDismissModeNone       当拖动时键盘消失

@end

// ------------------------------------------------------------------------------------------------------------------------------------------

@protocol UIScrollViewDelegate<NSObject>

@optional

// scrollView已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

// 视图已经放大或者缩小
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2);

// scrollView开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView; 		

// scrollView即将停止拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0);

// scrollView结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

// scrollView即将减速完成
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;

// scrollView减速完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

// scrollView结束减速并且必须有动画效果才会触发（必须要有动画效果）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

// 返回缩放后的试图，但只能返回scrollView（内容）上的子视图
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView;

// 开始缩放
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view NS_AVAILABLE_IOS(3_2);

// 结束缩放
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale;

// 点击状态栏，调用此方法，此方法能实现的前提是scrollToTop的属性是YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;

// scrollView已经回到顶部了
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
