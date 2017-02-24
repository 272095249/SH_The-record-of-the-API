//
//  UIView.h
//  UIKit
//
//
//  Coder_Sun的GitHub地址：https://github.com/272095249
//  Coder_Sun简书网址：http://www.jianshu.com/u/87c7aa9de064
//

#import <Foundation/Foundation.h>
#import <UIKit/UIResponder.h>
#import <UIKit/UIInterface.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIAppearance.h>
#import <UIKit/UIDynamicBehavior.h>
#import <UIKit/NSLayoutConstraint.h>
#import <UIKit/UITraitCollection.h>
#import <UIKit/UIFocus.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIViewAnimationCurve) {
    UIViewAnimationCurveEaseInOut,         // slow at beginning and end
    UIViewAnimationCurveEaseIn,            // slow at beginning
    UIViewAnimationCurveEaseOut,           // slow at end
    UIViewAnimationCurveLinear
};

/**
 *  设置图片的显示方式
 */
typedef NS_ENUM(NSInteger, UIViewContentMode) {
    /**
     *  填充  根据视图的比例去拉伸图片内容
     */
    UIViewContentModeScaleToFill,
    /**
     *  缩放填充   保持图片内容的纵横比例，来适应视图的大小
     */
    UIViewContentModeScaleAspectFit,
    /**
     *  用图片内容来填充视图的大小，多余的部分可以被修剪掉来填充整个视图边界
     */
    UIViewContentModeScaleAspectFill,
    /**
     *  重绘边界   这个选项是单视图的尺寸位置发生变化的时候通过调用setNeedsDisplay方法来重新显示
     */
    UIViewContentModeRedraw,
    /**
     *  保持图片原比例，居中
     */
    UIViewContentModeCenter,
    /**
     *  保持图片原比例，居上
     */
    UIViewContentModeTop,
    /**
     *  保持图片原比例，居下
     */
    UIViewContentModeBottom,
    /**
     *  保持图片原比例，居左
     */
    UIViewContentModeLeft,
    /**
     *  保持图片原比例，居右
     */
    UIViewContentModeRight,
    /**
     *  保持图片原比例，居左上
     */
    UIViewContentModeTopLeft,
    /**
     *  保持图片原比例，居右上
     */
    UIViewContentModeTopRight,
    /**
     *  保持图片原比例，居左下
     */
    UIViewContentModeBottomLeft,
    /**
     *  保持图片原比例，居右下
     */
    UIViewContentModeBottomRight,
};

/**
 *  过渡动画
 */
typedef NS_ENUM(NSInteger, UIViewAnimationTransition) {
    /**
     *  正常
     */
    UIViewAnimationTransitionNone,
    /**
     *  从左向右翻
     */
    UIViewAnimationTransitionFlipFromLeft,
    /**
     *  从右向左翻
     */
    UIViewAnimationTransitionFlipFromRight,
    /**
     *  从下向上卷
     */
    UIViewAnimationTransitionCurlUp,
    /**
     *  从上向下卷
     */
    UIViewAnimationTransitionCurlDown,
};

/**
 *  自适应枚举
 */
typedef NS_OPTIONS(NSUInteger, UIViewAutoresizing) {
    /**
     *  视图将不进行自动尺寸调整
     */
    UIViewAutoresizingNone                 = 0,
    /**
     *  视图的左边界将随着父视图宽度的变化而按比例进行调整。否则，视图和其父视图的左边界的相对位置将保持不变。
     */
    UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
    /**
     *  视图的宽度将和父视图的宽度一起成比例变化。否则，视图的宽度将保持不变
     */
    UIViewAutoresizingFlexibleWidth        = 1 << 1,
    /**
     *  视图的右边界将随着父视图宽度的变化而按比例进行调整。否则，视图和其父视图的右边界的相对位置将保持不变。
     */
    UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
    /**
     *  视图的上边界将随着父视图高度的变化而按比例进行调整。否则，视图和其父视图的上边界的相对位置将保持不变。
     */
    UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
    /**
     *  视图的高度将和父视图的高度一起成比例变化。否则，视图的高度将保持不变
     */
    UIViewAutoresizingFlexibleHeight       = 1 << 4,
    /**
     *  视图的底边界将随着父视图高度的变化而按比例进行调整。否则，视图和其父视图的底边界的相对位置将保持不变。
     */
    UIViewAutoresizingFlexibleBottomMargin = 1 << 5
};

/**
 *  动画执行选项设置
 */
typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
    
// 这部分是基础属性的设置
    /**
     *  提交动画的时候布局子控件，表示子控件将和父控件一同动画。
     */
    UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
    /**
     *  动画时允许用户交流，比如触摸
     */
    UIViewAnimationOptionAllowUserInteraction      = 1 <<  1,
    /**
     *  从当前状态开始动画
     */
    UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2,
    /**
     *  动画无限重复
     */
    UIViewAnimationOptionRepeat                    = 1 <<  3,
    /**
     *  动画运行到结束点后仍然以动画方式回到初始点,前提是设置动画无限重复   （Auto reverse：自动翻转）
     */
    UIViewAnimationOptionAutoreverse               = 1 <<  4,
    /**
     *  忽略嵌套动画时间设置
     */
    UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5,
    /**
     *  忽略嵌套动画速度设置
     */
    UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6,
    /**
     *  动画过程中重绘视图（注意仅仅适用于转场动画）
     */
    UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7,
    /**
     *  视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
     */
    UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8,
    /**
     *  不继承父动画设置或动画类型。
     */
    UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9,
    
    
// 动画速度控制（可从其中选择一个设置）
    /**
     *  动画先缓慢，然后逐渐加速（淡入淡出）
     */
    UIViewAnimationOptionCurveEaseInOut            = 0 << 16,
    /**
     *  动画逐渐变慢（淡入）
     */
    UIViewAnimationOptionCurveEaseIn               = 1 << 16,
    /**
     *  动画逐渐加速（淡出）
     */
    UIViewAnimationOptionCurveEaseOut              = 2 << 16,
    /**
     *  动画匀速执行，默认值（线性，匀速执行）
     */
    UIViewAnimationOptionCurveLinear               = 3 << 16,
    
    
// 转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
    /**
     *  没有转场动画效果
     */
    UIViewAnimationOptionTransitionNone            = 0 << 20,
    /**
     *  从左侧翻转效果
     */
    UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
    /**
     *  从右侧翻转效果
     */
    UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
    /**
     *  向后翻页的动画过渡效果
     */
    UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
    /**
     *  向前翻页的动画过渡效果
     */
    UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
    /**
     *  旧视图溶解消失显示下一个新视图的效果（溶解效果）
     */
    UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
    /**
     *  从上方翻转效果
     */
    UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
    /**
     *  从底部翻转效果
     */
    UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
    
    
/*
    关于最后一组转场动画它一般是用在这个方法中的：
        [UIView transitionFromView: toView: duration: options: completion:^(BOOL finished) {}];
    该方法效果是插入一面视图移除一面视图，期间可以使用一些转场动画效果
 
 */
    
    
} NS_ENUM_AVAILABLE_IOS(4_0);
};

/**
 *  关键帧动画效果选项
 */
typedef NS_OPTIONS(NSUInteger, UIViewKeyframeAnimationOptions) {
    /**
     *  动画过程中保证子视图跟随运动
     */
    UIViewKeyframeAnimationOptionLayoutSubviews            = UIViewAnimationOptionLayoutSubviews,
    /**
     *  动画过程中允许用户交互
     */
    UIViewKeyframeAnimationOptionAllowUserInteraction      = UIViewAnimationOptionAllowUserInteraction,
    /**
     *  所有视图从当前状态开始运行
     */
    UIViewKeyframeAnimationOptionBeginFromCurrentState     = UIViewAnimationOptionBeginFromCurrentState,
    /**
     *  重复运行动画
     */
    UIViewKeyframeAnimationOptionRepeat                    = UIViewAnimationOptionRepeat,
    /**
     *  动画运行到结束点后仍然以动画方式回到初始点
     */
    UIViewKeyframeAnimationOptionAutoreverse               = UIViewAnimationOptionAutoreverse,
    /**
     *  忽略嵌套动画时间设置
     */
    UIViewKeyframeAnimationOptionOverrideInheritedDuration = UIViewAnimationOptionOverrideInheritedDuration,
    /**
     *  不继承父动画设置或动画类型
     */
    UIViewKeyframeAnimationOptionOverrideInheritedOptions  = UIViewAnimationOptionOverrideInheritedOptions,
    
// 东动画模式设置（同前面关键帧动画模式一一对应，可以从其中选择一个进行设置）
    /**
     *  连续运算模式
     */
    UIViewKeyframeAnimationOptionCalculationModeLinear     = 0 << 10,
    /**
     *  离散运算模式
     */
    UIViewKeyframeAnimationOptionCalculationModeDiscrete   = 1 << 10,
    /**
     *  均匀执行运算模式
     */
    UIViewKeyframeAnimationOptionCalculationModePaced      = 2 << 10,
    /**
     *  平滑运算模式
     */
    UIViewKeyframeAnimationOptionCalculationModeCubic      = 3 << 10,
    /**
     *  平滑均匀运算模式
     */
    UIViewKeyframeAnimationOptionCalculationModeCubicPaced = 4 << 10 } NS_ENUM_AVAILABLE_IOS(7_0);
};

typedef NS_ENUM(NSUInteger, UISystemAnimation) {
    UISystemAnimationDelete,    // removes the views from the hierarchy when complete
} NS_ENUM_AVAILABLE_IOS(7_0);

/**
 *  定义了tint color的调整模式
 */
typedef NS_ENUM(NSInteger, UIViewTintAdjustmentMode) {
    /**
     *  视图的着色调整模式与父视图一致（自动的）
     */
    UIViewTintAdjustmentModeAutomatic,
    /**
     *  视图的tintColor属性返回完全未修改的视图着色颜色（正常的）
     */
    UIViewTintAdjustmentModeNormal,
    /**
     *  视图的tintColor属性返回一个去饱和度的、变暗的视图着色颜色（暗淡的）
     */
    UIViewTintAdjustmentModeDimmed,
    
    /**
     * 学习网址： http://www.cocoachina.com/ios/20150703/12363.html?utm_medium=referral&utm_source=pulsenews
     */
    
} NS_ENUM_AVAILABLE_IOS(7_0);
};

/**
 *  改变界面布局方式，对于有些国家来说，他们是从右往左阅读的 下面是强制效果和未用效果
 */
typedef NS_ENUM(NSInteger, UISemanticContentAttribute) {
    /**
     *  语义内容未指明
     */
    UISemanticContentAttributeUnspecified = 0,
    /**
     *  适合于回放控制例如Play/RW/FF按钮和播放头洗涤器
     */
    UISemanticContentAttributePlayback,
    /**
     *  适合于控制那些稍微方向改变在ui.例如 一个语句控制对文本对齐或者 一个d-pad 在游戏中
     */
    UISemanticContentAttributeSpatial,
    /**
     *  视图总是从左向右布局
     */
    UISemanticContentAttributeForceLeftToRight,
    /**
     *  视图总是从右向左布局
     */
    UISemanticContentAttributeForceRightToLeft
} NS_ENUM_AVAILABLE_IOS(9_0);
};


/**
 *  Description
 */
typedef NS_ENUM(NSInteger, UIUserInterfaceLayoutDirection) {
    /**
     *  从左到右的布局
     */
    UIUserInterfaceLayoutDirectionLeftToRight,
    /**
     *  从右到左的布局
     */
    UIUserInterfaceLayoutDirectionRightToLeft,
    
} NS_ENUM_AVAILABLE_IOS(5_0);
};

@protocol UICoordinateSpace <NSObject>

- (CGPoint)convertPoint:(CGPoint)point toCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
- (CGPoint)convertPoint:(CGPoint)point fromCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
- (CGRect)convertRect:(CGRect)rect toCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
- (CGRect)convertRect:(CGRect)rect fromCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);

@property (readonly, nonatomic) CGRect bounds NS_AVAILABLE_IOS(8_0);

@end

@class UIBezierPath, UIEvent, UIWindow, UIViewController, UIColor, UIGestureRecognizer, UIMotionEffect, CALayer, UILayoutGuide;

NS_CLASS_AVAILABLE_IOS(2_0) @interface UIView : UIResponder <NSCoding, UIAppearance, UIAppearanceContainer, UIDynamicItem, UITraitEnvironment, UICoordinateSpace, UIFocusEnvironment>

+ (Class)layerClass;                        // UIView有个layer属性，可以返回它的主CALayer实例，UIView有一个layerClass方法，返回主layer所使用的类，UIView的子类可以通过重载这个方法来让UIView使用不同的CALayer来显示

- (instancetype)initWithFrame:(CGRect)frame;          // 便利初始化方法：根据frame创建视图
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;   // 实例化从序列化

@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;  // 是否可以与用户交互
@property(nonatomic)                                 NSInteger tag;                // 当前视图的标签，默认是0
@property(nonatomic,readonly,strong)                 CALayer  *layer;              // 用来视图渲染的核心动画层

- (BOOL)canBecomeFocused NS_AVAILABLE_IOS(9_0); // NO by default   // 可成为焦点,默认为no
@property (readonly, nonatomic, getter=isFocused) BOOL focused NS_AVAILABLE_IOS(9_0);

// 用户交互布局继承从语义内容属性
+ (UIUserInterfaceLayoutDirection)userInterfaceLayoutDirectionForSemanticContentAttribute:(UISemanticContentAttribute)attribute NS_AVAILABLE_IOS(9_0);
@property (nonatomic) UISemanticContentAttribute semanticContentAttribute NS_AVAILABLE_IOS(9_0);    // 语义布局属性
@end



#pragma mark - 关于UIView几何方面的分类
@interface UIView(UIViewGeometry)


@property(nonatomic) CGRect            frame;   // 当前视图的边界，包括大小和原点，这里是在父视图的坐标系下

// use bounds/center and not frame if non-identity transform. if bounds dimension is odd, center may be have fractional part
@property(nonatomic) CGRect            bounds;      // 当前视图的边界，包括大小和原点，这里是在自己的坐标系下
@property(nonatomic) CGPoint           center;      // 当前视图的中心，并制定是在父视图的坐标系下
@property(nonatomic) CGAffineTransform transform;   // 形变属性（平移/缩放/旋转）
/*
 CGAffineTransform结构体,有六个值，分别是：
 CGFloat a, b, c, d;
 CGFloat tx, ty;
 */
@property(nonatomic) CGFloat           contentScaleFactor;      // 应用到当前视图的比例Scale

@property(nonatomic,getter=isMultipleTouchEnabled) BOOL multipleTouchEnabled __TVOS_PROHIBITED;   // 是否支持多点触控，默认是NO
@property(nonatomic,getter=isExclusiveTouch) BOOL       exclusiveTouch __TVOS_PROHIBITED;         // 决定当前视图是否是处理触摸事件的唯一对象，默认为NO

- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event;   // 此方法可试下点击穿透、点击下层视图功能
/*
 
 方法测试：
     继承UIView创建一个view，在.m文件中写
     - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event  {
     
         UIView *hitView = [super hitTest:point withEvent:event];
         if (point.x <= self.center.x) {
             hitView = nil;
         }
         return hitView;
     }
     
     然后在viewController中初始化View，然后添加touch事件
     - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     
         UITouch * touch = touches.anyObject;
         NSLog(@"%@",touch.view);
     }

    这样如果点击的是view中心点左边视图则是父视图响应，点击view中心店右边视图则是此视图响应
 
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event;   // 这个函数的用处是判断当前的点击或者触摸事件的点是否在当前的View中

- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view;      // 把本地视图（调用者）下的point（第一参数）转换为指定View（第二参数）的point（返回值）
- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view;    // 把指定View（第二参数）下的point（第一参数）转化为本地视图（调用者）的point（返回值）
- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;      // 把本地视图（调用者）下的rect（第一参数）转换为指定View（第二参数）的rect（返回值）
- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;        // 把指定View（第二参数）下的rect（第一参数）转化为本地视图（调用者）的rect（返回值）


/**
 *  当你改变视图的边框矩形时，其内嵌的子视图的位置和尺寸往往需要改变，以适应原始视图的新尺寸。如果视图的autoresizesSubViews属性声明被设置为YES，其子视图会根据autoresizingMask属性的值自动进行尺寸调整
 */
@property(nonatomic) BOOL               autoresizesSubviews; // 这个属性是决定当视图大小边界发生改变时，其子视图是否也跟着自动调整大小，默认为YES
/**
 *  设置视图的自动尺寸调整行为的方法是通过OR操作符将期望的自定尺寸调整常量连接起来。并将结果赋值给视图的autoresizingMask属性。比如要使一个视图和其父视图左下角的相对位置保持不变可以加入UIViewAutoresizingFlexibleRightMargin
 */
@property(nonatomic) UIViewAutoresizing autoresizingMask;    // 决定当当前视图的父视图大小发生变化时，当前视图该怎么调整自己的size
/*
 
 UIViewAutoresizing枚举值：
 UIViewAutoresizingNone                 //视图将不进行自动尺寸调整。
 UIViewAutoresizingFlexibleHeight       //视图的高度将和父视图的高度一起成比例变化。否则，视图的高度将保持不变
 UIViewAutoresizingFlexibleWidth        //视图的宽度将和父视图的宽度一起成比例变化。否则，视图的宽度将保持不变
 UIViewAutoresizingFlexibleLeftMargin   //视图的左边界将随着父视图宽度的变化而按比例进行调整。否则，视图和其父视图的左边界的相对位置将保持不变。
 UIViewAutoresizingFlexibleRightMargin  //视图的右边界将随着父视图宽度的变化而按比例进行调整。否则，视图和其父视图的右边界的相对位置将保持不变。
 UIViewAutoresizingFlexibleBottomMargin //视图的底边界将随着父视图高度的变化而按比例进行调整。否则，视图和其父视图的底边界的相对位置将保持不变。
 UIViewAutoresizingFlexibleTopMargin    //视图的上边界将随着父视图高度的变化而按比例进行调整。否则，视图和其父视图的上边界的相对位置将保持不变。
 
 */

- (CGSize)sizeThatFits:(CGSize)size;     // 返回最符合其子视图的大小。返回最佳尺寸，默认返回self.frame.size
- (void)sizeToFit;                       // 移动并调整子视图的大小

@end




#pragma mark - UIVew层级
@interface UIView(UIViewHierarchy)

@property(nullable, nonatomic,readonly) UIView       *superview;    // 获取父视图，只读属性
@property(nonatomic,readonly,copy) NSArray<__kindof UIView *> *subviews;    // 当前视图的所有子视图，只读属性
@property(nullable, nonatomic,readonly) UIWindow     *window;       // 当前视图上的UIWindow对象，只读属性

- (void)removeFromSuperview;        // 从父视图移除
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index;      // 在索引位置插入一个视图
- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2;      // 用索引值交换两个视图

- (void)addSubview:(UIView *)view;      // 向当前视图上添加子视图
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview;     // 在某个视图下插入一个视图
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview;     // 在某个视图上插入一个视图

- (void)bringSubviewToFront:(UIView *)view;     // 把这个View放到最前面
- (void)sendSubviewToBack:(UIView *)view;       // 把这个View放到最后面

- (void)didAddSubview:(UIView *)subview;        // 告诉视图添加子视图
- (void)willRemoveSubview:(UIView *)subview;        // 即将移除子视图

- (void)willMoveToSuperview:(nullable UIView *)newSuperview;        // 即将从父视图移除
- (void)didMoveToSuperview;     // 已经移除，父视图改变
- (void)willMoveToWindow:(nullable UIWindow *)newWindow;        // 窗口对象即将改变
- (void)didMoveToWindow;        // 已经语出窗体对象

#pragma mark 系统自动调用
- (BOOL)isDescendantOfView:(UIView *)view;  // 判定一个视图是否在其父视图的视图层中
- (nullable __kindof UIView *)viewWithTag:(NSInteger)tag; // 返回指定tag的View


#pragma mark 布局

- (void)setNeedsLayout;     // 标记视图需要重新布局，会调用layoutSubviews
- (void)layoutIfNeeded;     // 当调用了setNeedsLayout并不会马上调用layoutSubViews，这时会调用该方法，可以强制发生重新布局

#pragma mark 系统自动调用（留给子类去实现）
/**
 *  控件的frame，约束发生改变的时候就会调用，一般在这里重写布局子控件的位置和尺寸
 *  重写了这个方法后一定要调用[super layoutSubviews]
 */
- (void)layoutSubviews;    // 对子视图布局
/*
 
 layoutSubviews在以下情况下会被调用：
 1、init初始化不会触发layoutSubviews ,  但 initWithFrame 进行初始化时，当rect的值不为CGRectZero时,也会触发.
 2、addSubview会触发layoutSubviews.
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化.
 4、滚动一个UIScrollView会触发layoutSubviews.
 5、旋转Screen会触发父UIView上的layoutSubviews事件.
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件.
 [1]、layoutSubviews对subviews重新布局
 [2]、layoutSubviews方法调用先于drawRect
 [3]、setNeedsLayout在receiver标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews
 [4]、layoutIfNeeded方法如其名，UIKit会判断该receiver是否需要layout
 [5]、layoutIfNeeded遍历的不是superview链，应该是subviews链
 
 */



@property (nonatomic) UIEdgeInsets layoutMargins;   // 布局视图，距离父视图的上左下右的距离
@property (nonatomic) BOOL preservesSuperviewLayoutMargins; // 这个属性默认是NO，如果把它设为YES，layoutMargins会根据屏幕中相关View的布局而改变
- (void)layoutMarginsDidChange;     // 在我们改变View的layoutMargins这个属性时，会触发这个方法。我们在自己的View里面可以重写这个方法来捕获layoutMargins的变化。在大多数情况下，我们可以在这个方法里触发drawing和layout的Update


@property(readonly,strong) UILayoutGuide *layoutMarginsGuide NS_AVAILABLE_IOS(9_0);

/// This content guide provides a layout area that you can use to place text and related content whose width should generally be constrained to a size that is easy for the user to read. This guide provides a centered region that you can place content within to get this behavior for this view.
@property (nonatomic, readonly, strong) UILayoutGuide *readableContentGuide  NS_AVAILABLE_IOS(9_0);
@end



#pragma mark - UIView渲染
@interface UIView(UIViewRendering)
/**
 *  drawRect是对receiver的重绘
 *  setNeedDisplay在receiver标上一个需要被重新绘图的标记，在下一个draw周期自动重绘，iphone device的刷新频率是60hz，也就是1/60秒后重绘
 */
- (void)drawRect:(CGRect)rect;      // 渲染 重写此方法 执行重绘

- (void)setNeedsDisplay;    // 需要重新渲染  标记为需要重绘 一步调用drawRect
- (void)setNeedsDisplayInRect:(CGRect)rect;     // 需要重新渲染某一块区域

@property(nonatomic)                 BOOL              clipsToBounds;              // 决定了子视图的显示范围。具体来说，当取值为YES时，裁剪超出父视图范围的子视图范围
@property(nullable, nonatomic,copy)            UIColor          *backgroundColor;  // 设置背景颜色
@property(nonatomic)                 CGFloat           alpha;                      // 透明度，0.0-1.0的数值，0为全透明，1为不透明
@property(nonatomic,getter=isOpaque) BOOL              opaque;                     // 是否透明，默认为YES
/*
 决定该消息接收者(UIView instance)是否让其视图不透明,用处在于给绘图系统提供一个性能优化开关。
 myView.opaque = NO;
 该值为YES, 那么绘图在绘制该视图的时候把整个视图当作不透明对待。优化绘图过程并提升系统性能；为了性能方面的考量，默认被置为YES。
 该值为NO,，不去做优化操作。
 一个不透明视图需要整个边界里面的内容都是不透明。基于这个原因，opaque设置为YES，要求对应的alpha必须为1.0。如果一个UIView实例opaque被设置为YES, 而同时它又没有完全填充它的边界(bounds),或者它包含了整个或部分的透明的内容视图，那么将会导致未知的结果。
 因此，如果视图部分或全部支持透明，那么你必须把opaque这个值设置为NO.
 */

@property(nonatomic)                 BOOL              clearsContextBeforeDrawing; // 决定在子视图重画之前是否先清理视图以前的内容
@property(nonatomic,getter=isHidden) BOOL              hidden;                     // 是否隐藏，默认为NO
@property(nonatomic)                 UIViewContentMode contentMode;                // 决定当视图边界变时呈现视图内容的方式
/*
 UIViewContentMode枚举值：
 UIViewContentModeScaleToFill                // 填充
 UIViewContentModeScaleAspectFit             // 缩放填充
 UIViewContentModeRedraw                     // 重绘边界
 UIViewContentModeCenter                     // 保持相同的大小，居中
 UIViewContentModeTop                        // 保持相同的大小，居上
 UIViewContentModeBottom,                    // 保持相同的大小，居下
 UIViewContentModeLeft,                      // 保持相同的大小，居左
 UIViewContentModeRight,                     // 保持相同的大小，居右
 UIViewContentModeTopLeft,                   // 保持相同的大小，居左上
 UIViewContentModeTopRight,                  // 保持相同的大小，居右上
 UIViewContentModeBottomLeft,                // 保持相同的大小，居左下
 UIViewContentModeBottomRight,               // 保持相同的大小，居右下
 */
@property(nonatomic)                 CGRect            contentStretch; // 用于制定那部分是可拉伸的，取值在0.0~1.0之间
/*
 [imageView setContentStretch:CGRectMake(150.0/300.0, 100.0/200.0, 10.0/300.0, 10.0/200.0)];
 
 　　 image.png的大小是 200  x  150 ；
 　　 mageView的frame是（0，0，300，200）；
 　　 150.0/300.0表示x轴上，前150个像素不进行拉伸。
 　　 100.0/200.0表示y轴上，前100个像素不进行拉伸。
 　　 10.0/300.0表示x轴上150后的10个像素（151-160）进行拉伸，直到image.png铺满imageView。
 　　 10.0/200.0表示y轴上100后的10个像素（101-110）进行拉伸，直到image.png铺满imageView。
 */

@property(nullable, nonatomic,strong)          UIView           *maskView;  // 模具视图


@property(null_resettable, nonatomic, strong) UIColor *tintColor;     // 视图控件的颜色

@property(nonatomic) UIViewTintAdjustmentMode tintAdjustmentMode;     // 视图的色彩模式
/*
 枚举值：
    UIViewTintAdjustmentModeAutomatic,      //自动的
    UIViewTintAdjustmentModeNormal,         //正常的
    UIViewTintAdjustmentModeDimmed,         //暗淡的
 */


- (void)tintColorDidChange;     // 视图颜色属性发生变化时，由系统调用

@end



#pragma mark - 动画
@interface UIView(UIViewAnimation)

+ (void)beginAnimations:(nullable NSString *)animationID context:(nullable void *)context;  // 用来表示动画的开始
+ (void)commitAnimations;                                                 // 标记动画结束，执行动画（与beginAnimations方法成对使用）


+ (void)setAnimationDelegate:(nullable id)delegate;                          // 设置动画代理对象，当动画开始或者结束时会发消息给代理对象
+ (void)setAnimationWillStartSelector:(nullable SEL)selector;                // 当动画即将开始时，执行delegate对象的selector，并且把beginAnimations：context：中传入的参数传进selector
+ (void)setAnimationDidStopSelector:(nullable SEL)selector;                  // 当动画结束时，执行delegate对象的selector，并且把beginAnimations：context：中传入的参数传进selector
+ (void)setAnimationDuration:(NSTimeInterval)duration;              // 动画的持续时间，秒为单位
+ (void)setAnimationDelay:(NSTimeInterval)delay;                    // 动画延迟delay秒后再开始
+ (void)setAnimationStartDate:(NSDate *)startDate;                  // 动画开始的时间，默认为now
+ (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // 动画的节奏控制  default = UIViewAnimationCurveEaseInOut
+ (void)setAnimationRepeatCount:(float)repeatCount;                 // 动画的重复次数
+ (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;    // 如果设置为YES，代表动画每次重复执行的效果会跟上一次相反
+ (void)setAnimationBeginsFromCurrentState:(BOOL)fromCurrentState;  // 设置动画开始时的状态
/*
 如果是YES，那么在开始和结束图片视图渲染一次并在动画中创建帧；否则，视图将会在每一帧都渲染。例如缓存，你不需要在视图转变中不停的更新，你只需要等到转换完成再去更新视图。
 1、开始一个动画块。
 2、在容器视图中设置转换。
 3、在容器视图中移除子视图。
 4、在容器视图中添加子视图。
 5、结束动画块。
 */

+ (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache;  // 设置视图View的过渡效果，transition指定过渡类型，cache设置YES代表使用视图缓存，性能较好

+ (void)setAnimationsEnabled:(BOOL)enabled;                         // 设置动画是否可用
+ (BOOL)areAnimationsEnabled;                                       // 返回动画效果是否开启
+ (void)performWithoutAnimation:(void (^)(void))actionsWithoutAnimation NS_AVAILABLE_IOS(7_0);  // 先检查动画当前是否启用，然后禁止动画，执行block内方法，最后重新启用动画。它并不会阻塞局域CoreAnimation的动画

+ (NSTimeInterval)inheritedAnimationDuration NS_AVAILABLE_IOS(9_0);

@end


#pragma mark - 动画block
@interface UIView(UIViewAnimationWithBlocks)

// 下方三个是属性动画
/**
 *  动画效果处理块
 *
 *  @param duration   动画时间
 *  @param delay      延迟时间
 *  @param options    动画参数
 *  @param animations 动画效果块
 *  @param completion 完成效果块
 */
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;       // 一般的动画

// 没有延迟时间 没有动画参数 options默认为0
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion; // delay = 0.0, options = 0

// 动画效果处理块 delay= = 0.0，options = 0，completion = NULL
+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations NS_AVAILABLE_IOS(4_0); // delay = 0.0, options = 0, completion = NULL

/* Performs `animations` using a timing curve described by the motion of a spring. When `dampingRatio` is 1, the animation will smoothly decelerate to its final model values without oscillating. Damping ratios less than 1 will oscillate more and more before coming to a complete stop. You can use the initial spring velocity to specify how fast the object at the end of the simulated spring was moving before it was attached. It's a unit coordinate system, where 1 is defined as travelling the total animation distance in a second. So if you're changing an object's position by 200pt in this animation, and you want the animation to behave as if the object was moving at 100pt/s before the animation started, you'd pass 0.5. You'll typically want to pass 0 for the velocity. */
// Spring（弹簧）Animation的API比一般动画多了两个参数 usingSpringWithDamping（范围为0.0f~1.0f），数值越小弹簧的震动的效果越明显     initialSpringVelocity表示初始速度，数值越大一开始移动越快
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;      // 弹性动画

// 过渡动画效果块
+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;     // 转场动画
/*
 [UIView transitionWithView:_redView
                 duration:2.0
                 options:UIViewAnimationOptionTransitionCurlDown
                 animations:^{
                     [_blackView removeFromSuperview];
                     [_redView addSubview:_blackView];
                 } completion:^(BOOL finished) {
                     _redView.backgroundColor = [UIColor brownColor];
     }];
 */

// 视图之间切换的过渡动画效果块
+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(4_0); // toView added to fromView.superview, fromView removed from its superview


// 在一组视图上执行指定的系统动画，并可以并行自定义动画。其中parallelAnimations就是与系统动画并行的自定义动画
+ (void)performSystemAnimation:(UISystemAnimation)animation onViews:(NSArray<__kindof UIView *> *)views options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))parallelAnimations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

@end



#pragma mark - 核心架构动画
@interface UIView (UIViewKeyframeAnimations)

/*
    关键帧动画实例：
     [UIView animateKeyframesWithDuration:2.0delay:0options:UIViewKeyframeAnimationOptionRepeatanimations:^{
     
         _blackView.frame = CGRectMake(30, 30, 50, 50);
         [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0 animations:^{
         _redView.frame = CGRectMake(50, 50, 50, 50);
     }];
     
     } completion:^(BOOL finished) {
     
         _redView.frame= CGRectMake(50, 50, 100, 100);;
         _blackView.frame = CGRectMake(30, 30, 80, 80);
     
     }];
 */

// 为当前视图创建一个可以用于设置基本关键帧动画的block对象
+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);
/**
 *  指定一个关键帧的单个帧的时间和动画  iOS7后可用
 *
 *  @param frameStartTime 一个倍数从0~1，假设一个动画持续的时间是2秒，设置frameStartTime为0.5 那么后面设置的动画将会在整体动画执行1秒后开始
 *  @param frameDuration  动画持续时间
 *  @param animations     动画效果块
 */
+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations NS_AVAILABLE_IOS(7_0); // start time and duration are values between 0.0 and 1.0 specifying time and duration relative to the overall time of the keyframe animation

@end


#pragma mark - 手势识别
@interface UIView (UIViewGestureRecognizers)

@property(nullable, nonatomic,copy) NSArray<__kindof UIGestureRecognizer *> *gestureRecognizers;    // 访问手势集合

- (void)addGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;       // 添加手势
- (void)removeGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer;        // 移除手势


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;      // 通过返回值决定是否识别此手势

@end


#pragma mark - 动作效果
@interface UIView (UIViewMotionEffects)

/*! Begins applying `effect` to the receiver. The effect's emitted keyPath/value pairs will be
 applied to the view's presentation layer.
 
 Animates the transition to the motion effect's values using the present UIView animation
 context. */


/*

 当你打开装有iOS7以上的iPhone主屏，默认的背景是一幅蓝色的星空图片。当上下左右翻转iPhone时，有趣的效果将会出现，星空背景也会沿着各个方向发生位移，这与主屏上的各个App Icon形成了一种独特的视差效果。
 //UIMotionEffect
 1. UIInterpolatingMotionEffect
 
 UIInterpolatingMotionEffect是UIMotionEffect的子类，虽然扩展也不复杂，提供的方法也很简单，但在很多场景下可以比较直接和方便的满足我们的需求。
 
 它有4个property:
 
 1.keyPath，左右翻转屏幕将要影响到的属性，比如center.x。
 
 2.type（UIInterpolatingMotionEffectType类型），观察者视角，也就是屏幕倾斜的方式，目前区分水平和垂直两种方式。
 
 3&4.minimumRelativeValue和maximumRelativeValue，keyPath对应的值的变化范围，注意这个是id类型。min对应最小的offset，max对应最大的offset。
 
 UIInterpolatingMotionEffect * xEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
 xEffect.minimumRelativeValue =  [NSNumber numberWithFloat:-40.0];
 xEffect.maximumRelativeValue = [NSNumber numberWithFloat:40.0];
 [targetView addMotionEffect:xEffect];
 参考自http://www.cocoachina.com/ios/20150121/10967.html

*/

- (void)addMotionEffect:(UIMotionEffect *)effect NS_AVAILABLE_IOS(7_0);     // 添加一个UIMotionEffect

/*! Stops applying `effect` to the receiver. Any affected presentation values will animate to
 their post-removal values using the present UIView animation context. */
- (void)removeMotionEffect:(UIMotionEffect *)effect NS_AVAILABLE_IOS(7_0);      // 移除一个UIMotionEffect

@property (copy, nonatomic) NSArray<__kindof UIMotionEffect *> *motionEffects NS_AVAILABLE_IOS(7_0);    // 包含的UIMotionEffect

@end


//
// UIView Constraint-based Layout Support
//

typedef NS_ENUM(NSInteger, UILayoutConstraintAxis) {
    UILayoutConstraintAxisHorizontal = 0,
    UILayoutConstraintAxisVertical = 1
};

// Installing Constraints

/* A constraint is typically installed on the closest common ancestor of the views involved in the constraint.
 It is required that a constraint be installed on _a_ common ancestor of every view involved.  The numbers in a constraint are interpreted in the coordinate system of the view it is installed on.  A view is considered to be an ancestor of itself.
 */
#pragma mark - 约束基于布局
@interface UIView (UIConstraintBasedLayoutInstallingConstraints)

@property(nonatomic,readonly) NSArray<__kindof NSLayoutConstraint *> *constraints NS_AVAILABLE_IOS(6_0);    // 视图布局约束

- (void)addConstraint:(NSLayoutConstraint *)constraint; // 添加约束
- (void)addConstraints:(NSArray<__kindof NSLayoutConstraint *> *)constraints; // 添加一组约束
- (void)removeConstraint:(NSLayoutConstraint *)constraint; // 移除某个约束
- (void)removeConstraints:(NSArray<__kindof NSLayoutConstraint *> *)constraints; // 移除一组约束
@end

// Core Layout Methods

/* To render a window, the following passes will occur, if necessary.
 
 update constraints
 layout
 display
 
 Please see the conceptual documentation for a discussion of these methods.
 */

#pragma mark - 核心布局方法
@interface UIView (UIConstraintBasedLayoutCoreMethods)
- (void)updateConstraintsIfNeeded; // 更新约束布局及其子布局
- (void)updateConstraints; // 更新约束布局
- (BOOL)needsUpdateConstraints;     // 返回约束布局是否需要更新，YES为是
- (void)setNeedsUpdateConstraints;      // 设置需要更新的约束布局
@end

// Compatibility and Adoption




#pragma mark - 布局兼容性
@interface UIView (UIConstraintBasedCompatibility)


@property(nonatomic) BOOL translatesAutoresizingMaskIntoConstraints; // 返回一个BOOL，判断自动布局是否可以转换约束布局


+ (BOOL)requiresConstraintBasedLayout;      // 返回View是否约束布局模式

@end

// Separation of Concerns

#pragma mark - 布局图层
@interface UIView (UIConstraintBasedLayoutLayering)


- (CGRect)alignmentRectForFrame:(CGRect)frame;      // 返回视图矩形对于指定视图框架
- (CGRect)frameForAlignmentRect:(CGRect)alignmentRect;      // 返回框架对于指定视图矩形


- (UIEdgeInsets)alignmentRectInsets;        // 返回自定义视图框架

- (UIView *)viewForBaselineLayout NS_DEPRECATED_IOS(6_0, 9_0, "Override -viewForFirstBaselineLayout or -viewForLastBaselineLayout as appropriate, instead") __TVOS_PROHIBITED;      // 如果超出越是范围，自动生成基线限制，以满足视图需求

/* -viewForFirstBaselineLayout is called by the constraints system when interpreting
 the firstBaseline attribute for a view.
 For complex custom UIView subclasses, override this method to return the text-based
 (i.e., UILabel or non-scrollable UITextView) descendant of the receiver whose first baseline
 is appropriate for alignment.
 UIView's implementation returns [self viewForLastBaselineLayout], so if the same
 descendant is appropriate for both first- and last-baseline layout you may override
 just -viewForLastBaselineLayout.
 */
@property(readonly,strong) UIView *viewForFirstBaselineLayout NS_AVAILABLE_IOS(9_0);

/* -viewForLastBaselineLayout is called by the constraints system when interpreting
 the lastBaseline attribute for a view.
 For complex custom UIView subclasses, override this method to return the text-based
 (i.e., UILabel or non-scrollable UITextView) descendant of the receiver whose last baseline
 is appropriate for alignment.
 UIView's implementation returns self.
 */
@property(readonly,strong) UIView *viewForLastBaselineLayout NS_AVAILABLE_IOS(9_0);

/* Override this method to tell the layout system that there is something it doesn't natively understand in this view, and this is how large it intrinsically is.  A typical example would be a single line text field.  The layout system does not understand text - it must just be told that there's something in the view, and that that something will take a certain amount of space if not clipped.
 
 In response, UIKit will set up constraints that specify (1) that the opaque content should not be compressed or clipped, (2) that the view prefers to hug tightly to its content.
 
 A user of a view may need to specify the priority of these constraints.  For example, by default, a push button
 -strongly wants to hug its content in the vertical direction (buttons really ought to be their natural height)
 -weakly hugs its content horizontally (extra side padding between the title and the edge of the bezel is acceptable)
 -strongly resists compressing or clipping content in both directions.
 
 However, you might have a case where you'd prefer to show all the available buttons with truncated text rather than losing some of the buttons. The truncation might only happen in portrait orientation but not in landscape, for example. In that case you'd want to setContentCompressionResistancePriority:forAxis: to (say) UILayoutPriorityDefaultLow for the horizontal axis.
 
 The default 'strong' and 'weak' priorities referred to above are UILayoutPriorityDefaultHigh and UILayoutPriorityDefaultLow.
 
 Note that not all views have an intrinsicContentSize.  UIView's default implementation is to return (UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric).  The _intrinsic_ content size is concerned only with data that is in the view itself, not in other views. Remember that you can also set constant width or height constraints on any view, and you don't need to override instrinsicContentSize if these dimensions won't be changing with changing view content.
 */
UIKIT_EXTERN const CGFloat UIViewNoIntrinsicMetric NS_AVAILABLE_IOS(6_0); // -1
- (CGSize)intrinsicContentSize;     // 返回view的自然尺寸
- (void)invalidateIntrinsicContentSize; // 使内容尺寸无效化

- (UILayoutPriority)contentHuggingPriorityForAxis:(UILayoutConstraintAxis)axis;     // 返回放大的视图布局的轴线
- (void)setContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis;      // 设置放大的视图布局的轴线

- (UILayoutPriority)contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxis)axis;       // 返回缩小的视图布局的轴线
/*
 axis:布局约束
 枚举值：
 UILayoutConstraintAxisHorizontal    //水平
 UILayoutConstraintAxisVertical      //垂直
 返回值：小数
 */
- (void)setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis;    // 设置缩小的视图布局的轴线
@end

// Size To Fit

UIKIT_EXTERN const CGSize UILayoutFittingCompressedSize NS_AVAILABLE_IOS(6_0);
UIKIT_EXTERN const CGSize UILayoutFittingExpandedSize NS_AVAILABLE_IOS(6_0);


#pragma mark - 约束基于布局适应尺寸
@interface UIView (UIConstraintBasedLayoutFittingSize)

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize; // 返回最合适的尺寸
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority;   // 满足约束视图布局的大小
@end

@interface UIView (UILayoutGuideSupport)

/* UILayoutGuide objects owned by the receiver.
 */
@property(nonatomic,readonly,copy) NSArray<__kindof UILayoutGuide *> *layoutGuides NS_AVAILABLE_IOS(9_0);

/* Adds layoutGuide to the receiver, passing the receiver in -setOwningView: to layoutGuide.
 */
- (void)addLayoutGuide:(UILayoutGuide *)layoutGuide NS_AVAILABLE_IOS(9_0);

/* Removes layoutGuide from the receiver, passing nil in -setOwningView: to layoutGuide.
 */
- (void)removeLayoutGuide:(UILayoutGuide *)layoutGuide NS_AVAILABLE_IOS(9_0);
@end

@class NSLayoutXAxisAnchor,NSLayoutYAxisAnchor,NSLayoutDimension;


#pragma mark - 布局指南支持
@interface UIView (UIViewLayoutConstraintCreation)
/* Constraint creation conveniences. See NSLayoutAnchor.h for details.
 */
@property(readonly, strong) NSLayoutXAxisAnchor *leadingAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutXAxisAnchor *trailingAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutXAxisAnchor *leftAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutXAxisAnchor *rightAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutYAxisAnchor *topAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutYAxisAnchor *bottomAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutDimension *widthAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutDimension *heightAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutXAxisAnchor *centerXAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutYAxisAnchor *centerYAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutYAxisAnchor *firstBaselineAnchor NS_AVAILABLE_IOS(9_0);
@property(readonly, strong) NSLayoutYAxisAnchor *lastBaselineAnchor NS_AVAILABLE_IOS(9_0);

@end

// Debugging

/* Everything in this section should be used in debugging only, never in shipping code.  These methods may not exist in the future - no promises.
 */
#pragma mark - 布局Debug
@interface UIView (UIConstraintBasedLayoutDebugging)


- (NSArray<__kindof NSLayoutConstraint *> *)constraintsAffectingLayoutForAxis:(UILayoutConstraintAxis)axis;     // 返回影响视图布局限制的轴线


- (BOOL)hasAmbiguousLayout;     // 返回视图布局约束是否影响指定视图，主要用于调试约束布局，结合exerciseAmbiguityInLayout
- (void)exerciseAmbiguityInLayout;      // 随机改变不同效值布局视图，主要用于调试基于约束布局的视图
@end



#pragma mark - 状态复位
@interface UIView (UIStateRestoration)
@property (nullable, nonatomic, copy) NSString *restorationIdentifier;      // 该标识符决定该视图是否支持恢复状态，其实也只是个标识符而已
- (void) encodeRestorableStateWithCoder:(NSCoder *)coder;       // 保存视图状态相关信息
- (void) decodeRestorableStateWithCoder:(NSCoder *)coder;       // 恢复和保持视图状态相关信息
@end


#pragma mark - UISnapshotting
@interface UIView (UISnapshotting)

- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates;      // 返回一个基于当前视图的内容快照视图
- (UIView *)resizableSnapshotViewFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates withCapInsets:(UIEdgeInsets)capInsets;  // 返回一个基于当前视图的特定内容的快照视图，拉伸插图

- (BOOL)drawViewHierarchyInRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates;     // 利用View层次结构病将其绘制到当前的上下文中
@end

NS_ASSUME_NONNULL_END

