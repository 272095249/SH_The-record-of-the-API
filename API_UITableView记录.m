
//
//  UITableView.h
//  UIKit
//
//  Copyright (c) 2005-2015 Apple Inc. All rights reserved.
//
//  Coder_Sun的GitHub地址：https://github.com/272095249
//  Coder_Sun简书网址：http://www.jianshu.com/u/87c7aa9de064
// 

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIScrollView.h>
#import <UIKit/UISwipeGestureRecognizer.h>
#import <UIKit/UITableViewCell.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UITableViewStyle) {
    UITableViewStylePlain,          // 普通类型
    UITableViewStyleGrouped         // 分组类型
};


// scrollPosition参数决定定位的相对位置
typedef NS_ENUM(NSInteger, UITableViewScrollPosition) {
    UITableViewScrollPositionNone,          //同UITableViewScrollPositionTop
    UITableViewScrollPositionTop,           //定位完成后，将定位的行显示在tableView的顶部
    UITableViewScrollPositionMiddle,        //定位完成后，将定位的行显示在tableView的中间
    UITableViewScrollPositionBottom         //定位完成后，将定位的行显示在tableView的最下面
};                // scroll so row of interest is completely visible at top/center/bottom of view


// 行变化（插入、删除、移动的动画类型）
typedef NS_ENUM(NSInteger, UITableViewRowAnimation) {
    UITableViewRowAnimationFade,            // 淡入淡出
    UITableViewRowAnimationRight,           // 从右滑入
    UITableViewRowAnimationLeft,            // 从左滑入
    UITableViewRowAnimationTop,             // 从上滑入
    UITableViewRowAnimationBottom,          // 从下滑入
    UITableViewRowAnimationNone,            // 没有动画
    UITableViewRowAnimationMiddle,          // 从中间出来
    UITableViewRowAnimationAutomatic = 100  // 自动选择合适的动画
};



// 扩大镜（一般放到第一个）
UIKIT_EXTERN NSString *const UITableViewIndexSearch NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;

// Returning this value from tableView:heightForHeaderInSection: or tableView:heightForFooterInSection: results in a height that fits the value returned from
// tableView:titleForHeaderInSection: or tableView:titleForFooterInSection: if the title is not nil.
UIKIT_EXTERN const CGFloat UITableViewAutomaticDimension NS_AVAILABLE_IOS(5_0);

@class UITableView;
@class UINib;
@protocol UITableViewDataSource;
@class UILongPressGestureRecognizer;
@class UITableViewHeaderFooterView;
@class UIRefreshControl;
@class UIVisualEffect;

// 应用于动作按钮的样式
typedef NS_ENUM(NSInteger, UITableViewRowActionStyle) {
    UITableViewRowActionStyleDefault = 0,                                           // 将默认样式应用于按钮
    UITableViewRowActionStyleDestructive = UITableViewRowActionStyleDefault,        // 等于默认样式
    UITableViewRowActionStyleNormal                                                 // 应用反应标准非破坏性操作的风格
} NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;

NS_CLASS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED@interface UITableViewRowAction : NSObject <NSCopying>


// 便利初始化方法：
+ (instancetype)rowActionWithStyle:(UITableViewRowActionStyle)style title:(nullable NSString *)title handler:(void (^)(UITableViewRowAction *action, NSIndexPath *indexPath))handler;

@property (nonatomic,readonly) UITableViewRowActionStyle style;
@property (nonatomic,copy, nullable) NSString *title;
@property (nonatomic,copy, nullable) UIColor *backgroundColor;// 默认背景颜色
@property (nonatomic,copy, nullable) UIVisualEffect* backgroundEffect;

@end

NS_CLASS_AVAILABLE_IOS(9_0)@interface UITableViewFocusUpdateContext : UIFocusUpdateContext

@property (nonatomic,strong, readonly,nullable) NSIndexPath *previouslyFocusedIndexPath;
@property (nonatomic,strong, readonly,nullable) NSIndexPath *nextFocusedIndexPath;

@end

//_______________________________________________________________________________________________________________
// this represents the display and behaviour of the cells.         这边是cell的显示和行为

@protocol UITableViewDelegate<NSObject, UIScrollViewDelegate>

@optional

// Display customization
// cell将要显示时回调
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
// section的header将要显示时回调
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
// section的fotter将要显示时回调
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
// cell已显示时回调
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
// section的header已显示时回调
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
// section的fotter已显示时回调
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);

// Variable height support      可变高度支持
// 返回行高（这里高度通过协议返回，是为了table能准确的定位出来要显示的Cell-index，从而满足UITableView的重用机制）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
// 返回section的header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
// 返回section的footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;


// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
// 设置行高，头视图高度和尾视图高度的估计值（对于高度可变的情况下，提高效率）
// [https://www.shinobicontrols.com/blog/ios7-day-by-day-day-19-uitableview-row-height-estimation](https://www.shinobicontrols.com/blog/ios7-day-by-day-day-19-uitableview-row-height-estimation)    //tableView估算高度网址
// 返回预估的行高
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
// 返回预估section的header高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
// 返回预估section的footer高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
/*
 使用：
 
 self.tableView.rowHeight=UITableViewAutomaticDimension;
 self.tableView.estimatedRowHeight=44.0;
 
 [cell setNeedsUpdateConstraints];
 [cell updateConstraintsIfNeeded];
 
 在 cellforrow里调用     [cell setNeedsUpdateConstraints];
 [cell updateConstraintsIfNeeded];
 
 要结合起来我之前用Storybord做cell自使用 就使用这个方法
 
 */

// Section header & footer information. Views are preferred over title should you decide to provide both
// 返回第section组头部控件 （会调整默认活已经指定的header的高度）
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;  // custom view for header. will be adjusted to default or specified header height
// 返回第section组尾部控件 （会调整默认活已经指定的footer的高度）
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;  // custom view for footer. will be adjusted to default or specified footer height

// Accessories (disclosures).

// 当cell的accessaryType为UITableViewCellAccessoryFetailDisclosureButton时，点击accessaryView将会调用delegate的tableView：accessoryButtonTappedForRowWithIndexPath方法。否则只只是didSelectRowAtIndexPath；   （accessaryView辅助视图）
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0,3_0) __TVOS_PROHIBITED;
// 设置每个单元格上面的按钮的点击方法
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;

// Selection
 
// 当前选中的row是否高亮
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);

// 指定row高亮
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);

// 通知委托表视图的指定行不在高亮显示，一般是点击其他行的时候
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);


// cell选择
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
// cell取消选择
- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);

// 已经选择选中后调用的函数
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
// 已经取消选择选中后调用的函数
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
/* 先点击row1，再点击row2，两者执行顺序：在下一行将要选中后才取消上一行的选中
 willSelectRowAtIndexPath 当前row为:0
 didSelectRowAtIndexPath 当前row为:0
 willSelectRowAtIndexPath 当前row为:1
 willDeselectRowAtIndexPath 当前row为:0
 didDeselectRowAtIndexPath 当前row为:0
 didSelectRowAtIndexPath 当前row为:1
 */


// Editing      编辑

// 设置tableView被编辑时的状态风格，如果不设置，默认是删除风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
// 自定义删除按钮的标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
// 用于自定义创建tableView被编辑时右边的按钮，按钮类型为UITableViewRowAction
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED; // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil

// 设置编辑模式下是否需要对表视图指定行进行缩进，NO为关闭缩进，这个方法可以用来去掉move时row前面的空白
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;

// 开始编辑前调用
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED;
// 完成编辑后调用
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED;


// Moving/reordering

// 移动特定的某行（注意区别之前的tableView：moveRowAtIndexPath：toIndexPath方法。当手指按住reorde accessory view移动时，只要有row moved/reordered都会调用该方法，而前者方法只有当手指放开reorder accessory view时，结束move/order操作才会调用自己。返回值代表进行移动操作后回到的行，如果设置为当前行，则不论怎么移动都会回到当前行）
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;               

// Indentation
// 行缩进
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;// return 'depth' of row for hierarchies

// 长按出来的Copy/Paste操作（复制粘贴）----->通知委托是否在指定行显示菜单，返回值为YES时，长按显示菜单
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
// 弹出选择菜单时会调用此方法（复制、粘贴、全选、剪切）
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullableid)sender NS_AVAILABLE_IOS(5_0);
// 当用户选择菜单中的某个选项时调用
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullableid)sender NS_AVAILABLE_IOS(5_0);

// Focus 焦点

// 返回能否获得焦点
- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
// 返回是否将要更新焦点
- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
// 已经更新焦点时调用
- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
// 返回上一个焦点的indexPath
- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);

@end

UIKIT_EXTERN NSString *const UITableViewSelectionDidChangeNotification;    // 通知

//_______________________________________________________________________________________________________________

NS_CLASS_AVAILABLE_IOS(2_0)@interface UITableView : UIScrollView <NSCoding>

// 便利初始化方式：根据风格
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style NS_DESIGNATED_INITIALIZER;// must specify style at creation. -initWithFrame: calls this with UITableViewStylePlain
- (nullableinstancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic,readonly) UITableViewStyle style;    // 列表视图的类型，只读
@property (nonatomic,weak, nullable)id <UITableViewDataSource> dataSource;
@property (nonatomic,weak, nullable)id <UITableViewDelegate> delegate;
@property (nonatomic) CGFloat rowHeight;            // 行高
@property (nonatomic) CGFloat sectionHeaderHeight;  // 组头的高度
@property (nonatomic) CGFloat sectionFooterHeight;  // 组尾的高度
@property (nonatomic) CGFloat estimatedRowHeight NS_AVAILABLE_IOS(7_0);             // 估算行高，默认0
@property (nonatomic) CGFloat estimatedSectionHeaderHeight NS_AVAILABLE_IOS(7_0);   // 估算组头的高度
@property (nonatomic) CGFloat estimatedSectionFooterHeight NS_AVAILABLE_IOS(7_0);   // 估算组尾的高度
@property (nonatomic) UIEdgeInsets separatorInset NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;// 允许更改分割线的frame

@property (nonatomic,strong, nullable) UIView *backgroundView NS_AVAILABLE_IOS(3_2);// 背景视图（自动匹配tableView视图大小），设置互作为列表视图的子视图，切在所有cell和headers/footers的后面，默认为nil

// Data     数据的刷新

- (void)reloadData;// 刷新列表
- (void)reloadSectionIndexTitles NS_AVAILABLE_IOS(3_0);  // 刷新你section这个方法常用语新加或者删除了索引类别二无需率先呢整个表视图的情况下

// Info     信息

@property (nonatomic,readonly) NSInteger numberOfSections;      // 列表的组数
// 某一组有多少行
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

// 某一组所占的矩形区域（包括header，footer和所有的行）
- (CGRect)rectForSection:(NSInteger)section;
// 某一组的header所占的矩形区域
- (CGRect)rectForHeaderInSection:(NSInteger)section;
// 某一组的footer所占的矩形区域
- (CGRect)rectForFooterInSection:(NSInteger)section;
// 某一分区的row所占的矩形区域
- (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath;

// 某一点在tableView上所占的分区，如果该点不在tableView的任何row上返回nil
- (nullable NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;
// 某一行所在的分区，如果改行是不可见的返回nil
- (nullable NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;
// 某一矩形区域内所有行所在的所有分区，返回元素为NSIndexPath类型的数组。当该矩形是一个无效值时，返回nil
- (nullable NSArray<NSIndexPath *> *)indexPathsForRowsInRect:(CGRect)rect;

// 某一分区的cell没如果改cell是不可见的或者indexPath超出了返回则返回nil
- (nullable__kindof UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic,readonly) NSArray<__kindof UITableViewCell *> *visibleCells;   // 所有可见的cell，只读数组型（数组类型为UITableViewCell）

@property (nonatomic,readonly, nullable) NSArray<NSIndexPath *> *indexPathsForVisibleRows;  // 所有可见行所在的分区，只读数组型（NSIndexPath）

// 某一组的header视图（常用语自定义headerView用）
- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
// 某一组的footer视图（常用语自定义footerView用）
- (nullable UITableViewHeaderFooterView *)footerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);

//使表视图定位到某一位置（行）
- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
// 使表视图定位到选中行
- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

// Row insertion/deletion/reloading.
// 这两个方法，是配合起来使用的，标记了一个tableView的动画快。分别代表动画的开始和结束。两者成对出现，可以嵌套使用。一般，在添加，删除，选择tableView中使用，并实现动画效果。在动画快内，不建议使用reloadData方法，如果使用，会影响动画
- (void)beginUpdates;  // 允许多个插入/行和段被同时删除动画。可排序
- (void)endUpdates;    // 只调用插入/删除/重载呼叫或改变一更新区块内的编辑状态。然而对于行数等属性可能是无效的

// 插入某些组
- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
// 删除某些组
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
// 刷新某些组
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
// 一定组section到组newSection的位置
- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection NS_AVAILABLE_IOS(5_0);

// 插入某些行
- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
// 删除某些行
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

// 刷新tableView指定行的数据
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
// 移动分区indexPath的行到分区newIndexPath
- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath NS_AVAILABLE_IOS(5_0);


// 编辑、设置之后，行的显示会基于数据源查询插入/删除/重排序的控制  Editing. When set, rows show insert/delete/reorder controls based on data source queries    

@property (nonatomic,getter=isEditing)BOOL editing;           // 设置是否是编辑状态（编辑状态下的cell左边会出现一个减号，编辑右边会划出删除按钮）
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@property (nonatomic)BOOL allowsSelection NS_AVAILABLE_IOS(3_0);         // 当不再编辑模式时，是否可以选中，默认YES
@property (nonatomic)BOOL allowsSelectionDuringEditing;                  // 当处在编辑模式时，是否可以选中。默认NO
@property (nonatomic)BOOL allowsMultipleSelection NS_AVAILABLE_IOS(5_0); // 是否可以同时选中。默认NO
@property (nonatomic)BOOL allowsMultipleSelectionDuringEditing NS_AVAILABLE_IOS(5_0);  // 当处在编辑模式时，是否可以同时选中。默认NO

// Selection        选中

@property (nonatomic,readonly, nullable) NSIndexPath *indexPathForSelectedRow;// 选中的行所在的分区（单选）
@property (nonatomic,readonly, nullable) NSArray<NSIndexPath *> *indexPathsForSelectedRows NS_AVAILABLE_IOS(5_0);// 选中的行所在的所有分区（多选）

// Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
// 选中某行，注意：这两个方法将不会回调代理中的方法
- (void)selectRowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
// 取消选中某行
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;


// Appearance       外观

@property (nonatomic) NSInteger sectionIndexMinimumDisplayRowCount;   //  设置索引栏最小显示行数。先睡先在右侧专门章节索引列表当行数达到此值。默认值是0
@property (nonatomic,strong, nullable) UIColor *sectionIndexColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;   // 设置索引栏字体颜色
@property (nonatomic,strong, nullable) UIColor *sectionIndexBackgroundColor NS_AVAILABLE_IOS(7_0) UI_APPEARANCE_SELECTOR;    // 设置索引栏背景颜色
@property (nonatomic,strong, nullable) UIColor *sectionIndexTrackingBackgroundColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;  // 设置索引栏被选中时的颜色

@property (nonatomic) UITableViewCellSeparatorStyle separatorStyle __TVOS_PROHIBITED;    // 设置分割线的风格
@property (nonatomic,strong, nullable) UIColor *separatorColor UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;    // 设置分割线颜色
@property (nonatomic,copy, nullable) UIVisualEffect *separatorEffect NS_AVAILABLE_IOS(8_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED; // 设置分割线毛玻璃效果（iOS8之后可用）

@property (nonatomic)BOOL cellLayoutMarginsFollowReadableWidth NS_AVAILABLE_IOS(9_0);       // 判断是否需要根据内容留有空白
@property (nonatomic,strong, nullable) UIView *tableHeaderView;     // 设置tableView头视图
@property (nonatomic,strong, nullable) UIView *tableFooterView;     // 设置tableView尾视图

// 从复用池张取cell
- (nullable__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
// 获取一个已注册的cell
- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
// 从复用池获取头视图或尾视图
- (nullable__kindof UITableViewHeaderFooterView *)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);



// 通过xib文件注册cell
- (void)registerNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(5_0);
// 通过oc类注册cell
- (void)registerClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);

// 通过xib文件注册头视图和尾视图
- (void)registerNib:(nullable UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);
// 通过OC类注册头视图和尾视图
- (void)registerClass:(nullable Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);


// Focus

@property (nonatomic)BOOL remembersLastFocusedIndexPath NS_AVAILABLE_IOS(9_0);  // 使用Apple TV遥控器控制屏幕上的用户界面

@end

//_______________________________________________________________________________________________________________
// this protocol represents the data model object. as such, it supplies no information about appearance (including the cells)

@protocol UITableViewDataSource<NSObject>

@required

// 每个section下cell的个数（必须实现）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

// 通过Indexpath返回具体的cell（必须实现）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

// 返回有多少个section（默认是1）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

// 每个section上面的标语内容
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
// 每个section下面的标语内容
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;


// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
// 是否可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;


// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
// 是否可拖拽
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

// Index

// 右侧索引条需要的数组内容
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED;                                                   // return list of section titles to display in section index view (e.g. "ABCD...Z#")
// 索引值对应的section-index
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED; // tell table which section corresponds to section title/index (e.g. "B",1))

// Data manipulation - insert and delete support


// 对Cell编辑后的回调
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

// 对Cell拖拽后的回调
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end

//_______________________________________________________________________________________________________________

// This category provides convenience methods to make it easier to use an NSIndexPath to represent a section and row
@interface NSIndexPath (UITableView)

// 类方法
+ (instancetype)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@property (nonatomic,readonly) NSInteger section;     // indexPath的组
@property (nonatomic,readonly) NSInteger row;         // indexPath的行

@end

NS_ASSUME_NONNULL_END

/*
 ----dataSource/delegate方法大概执行顺序(所有方法均实现)：
 1).numberOfSectionsInTableView；有多少section，例如k；
 2).tableView:estimatedHeightForHeaderInSection + tableView:estimatedHeightForFooterInSection；计算k-1 section的header、footer大概高度；
 3).tableView:numberOfRowsInSection；k-1 section有多少 row；
 4).tableView:estimatedHeightForRowAtIndexPath；计算k-1 section中所有row的大概高度；
 5).重复1)~4)步骤，直到所有0至k-1的section计算完；
 6).sectionIndexTitlesForTableView；索引titles；
 7).tableView:heightForRowAtIndexPath；依次计算visible区域(屏幕区域)里每个cell的高度(这里的所有cell记做集合A，决定于屏幕高度和estimatedHeightForXXX方法)
 8).tableView:cellForRowAtIndexPath；创建第一个indexPath上的cell
 9).tableView:indentationLevelForRowAtIndexPath； indexPath上的cell的缩进；
 10).tableView:canEditRowAtIndexPath； indexPath上的cell编辑属性；
 11).tableView:willDisplayCell:forRowAtIndexPath； indexPath上的cell将要显示；
 12),重复8)~11)，直到所有visible区域cell(集合A)创建完毕；
 13).tableView:heightForHeaderInSection + tableView:heightForFooterInSection + tableView:viewForHeaderInSection + tableView:viewForHeaderInSection；依次计算visible区域里所有section的header高度、footer高度、viewForHead、viewForFooter；
 
 
 
 
 
 ----执行顺序(没有实现estimatedHeight这些方法)：
 1).numberOfSectionsInTableView；有多少section，例如k；
 2).tableView:heightForHeaderInSection + tableView:heightForFooterInSection；计算k-1 section的header、footer高度；
 3).tableView:numberOfRowsInSection；k-1 section有多少 row；
 4).tableView:heightForRowAtIndexPath；计算k-1 section中所有row得高度；
 5).重复1)~4)步骤，直到所有0至k-1的section计算完
 6).sectionIndexTitlesForTableView；索引titles；
 7).tableView:cellForRowAtIndexPath；创建第一个indexPath上的cell
 8).tableView:indentationLevelForRowAtIndexPath； indexPath上的cell的缩进；
 9).tableView:canEditRowAtIndexPath； indexPath上的cell编辑属性；
 10).tableView:willDisplayCell:forRowAtIndexPath； indexPath上的cell将要显示；
 12).重复7)~12)，知道所有visible区域(屏幕)cell创建完毕；
 13).tableView:viewForHeaderInSection + tableView:viewForHeaderInSection；依次计算visible区域里所有的viewForHead、viewForFooter；
 备注：
 1.由上可看出，estimatedHeight在加载tableview的时候代替了heightFor方法，heightFor方法只有当cell需要显示的时候，才会调用。
 2.关于estimatedHeightForXXX相关方法，里面的返回值并不能随意填写的，应该是真实高度的大概值；因为在加载tableview的时候，当所有的section header/footer row的高度都大概计算完，开始计算高度、并创建visible区域的cell时候，这些cell属不属于visible区域的判断依据就是之前的estimatedHeightForXXX方法返回的值算出来的；例如estimatedHeightForXXX相关方法返回值过大，算出来当前visible(屏幕)区域，包含3个section header 、footer以及里面的row，所以实际创建的时候也是创建这些cell(参考上文中方法执行顺序)，当这些cell创建完，实际情况高度（heightForXXX方法所得）可能只占visible(屏幕)区域的一半，导致屏幕另一半空白。注意visible区域初始显示的cell是由estimatedHeightForXXX相关方法决定的，而不是heightForXXX这些方法真实高度决定的，所以有时tableview中visible区域尾部cell显示不出来或者创建的cell比visible区域cell多，都是estimatedHeightForXXX和heightForXXX方法相差导致的原因。
 3.以上方法和ViewController那些方法关系：先执行viewdidload、willAppear等相关方法，再执行numberOfSectionsInTableView系列方法。
 */
