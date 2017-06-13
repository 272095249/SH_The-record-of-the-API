//
//  UIResponder.h
//  UIKit
//
//  Copyright (c) 2005-2015 Apple Inc. All rights reserved.
//
//  Coder_Sun的GitHub地址：https://github.com/272095249
//  Coder_Sun简书网址：http://www.jianshu.com/u/87c7aa9de064
//  iOS-源码解析专栏：http://www.jianshu.com/c/7fe8b38a197b
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIEvent.h>

NS_ASSUME_NONNULL_BEGIN

@class UIPress;
@class UIPressesEvent;
/*
	在iOS中不是任何对象都能处理事件，只有继承了UIResponser的对象才能接收并处理事件，当控件用户交互属性设为NO或者hidden设为YES（隐藏）或者alpha=0（透明）时不能接收事件

*/

NS_CLASS_AVAILABLE_IOS(2_0) @interface UIResponder : NSObject
#pragma mark - 响应者事件
- (nullable UIResponder*)nextResponder;		// 获取下一个响应者

- (BOOL)canBecomeFirstResponder;    // 当它放弃响应者，可以设置自身成为第一响应者，默认为NO
- (BOOL)becomeFirstResponder;		// 设置第一响应者

- (BOOL)canResignFirstResponder;    // 如果一个对象可以放弃对象响应者就返回YES，默认YES
- (BOOL)resignFirstResponder;		// 放弃第一响应者

- (BOOL)isFirstResponder;		// 是否是第一响应者


#pragma mark - 触摸屏幕操作
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;	// 触摸开始
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;	// 触摸移动
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;	// 触摸结束
- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;	// 触摸取消
- (void)touchesEstimatedPropertiesUpdated:(NSSet * _Nonnull)touches NS_AVAILABLE_IOS(9_1);	// 3Dtouch用的



#pragma mark - 深按功能（3Dtouch用）
- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0);	// 开始按压
- (void)pressesChanged:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0);	// 按压选择
- (void)pressesEnded:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0);	// 按压结束
- (void)pressesCancelled:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event NS_AVAILABLE_IOS(9_0);	// 按压取消


#pragma mark - 可以实现摇一摇等
- (void)motionBegan:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0);	// 运动开始
- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0);	// 运动结束
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(3_0);	// 运动取消

#pragma mark - 远程控制接收事件
- (void)remoteControlReceivedWithEvent:(nullable UIEvent *)event NS_AVAILABLE_IOS(4_0);	// 远程控制接收事件
/*
 
 下方是如何使用远程控制接收事件：
 
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{

// 要使用远程事件 需要在AppDelegate中的didFinishLaunchingWithOptions方法中写[[UIApplication sharedApplication] beginReceivingRemoteControlEvents]; 用来启用远程控制事件接收的

    NSLog(@"远程控制事件");
    // 然后在这里写处理远程事件的处理，下方是耳机远程事件的操作

    NSLog(@"%li,%li",(long)event.type,(long)event.subtype);
    if(event.type==UIEventTypeRemoteControl){
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                NSLog(@"播放事件");
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                NSLog(@"播放或暂停事件");
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"下一曲");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"上一曲");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                NSLog(@"快进开始");
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
                NSLog(@"快进停止");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                NSLog(@"快退开始");
                break;
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                NSLog(@"快退结束");
                break;
            default:
                break;
        }
    }
}
 
*/


- (BOOL)canPerformAction:(SEL)action withSender:(nullable id)sender NS_AVAILABLE_IOS(3_0);	// 处理命令事件
/*
 
 返回可以响应的事件
 
 - (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
 
     return (action == @selector(copy:) || action == @selector(paste:) || action == @selector(cut:) || action == @selector(select:) || action == @selector(selectAll:) || action == @selector(delete:));
 }
 */


- (nullable id)targetForAction:(SEL)action withSender:(nullable id)sender NS_AVAILABLE_IOS(7_0);	// 初始化并处理命令事件

@property(nullable, nonatomic,readonly) NSUndoManager *undoManager NS_AVAILABLE_IOS(3_0);	// 公共的事件撤销管理者

@end

// > 默认情况下，程序的每一个window都有一个undo管理器，它是一个用于管理undo和redo操作的共享对象。然而，响应链上的任何对象的类都可以有自定义undo管理器。例如，UITextField的实例的自定义管理器在文件输入框放弃第一响应者状态时会被清理掉。当需要一个undo管理器时，请求会沿着响应链传递，然后UIWindow对象会返回一个可用的实例。



// 按键调节器枚举(快捷键)
typedef NS_OPTIONS(NSInteger, UIKeyModifierFlags) {
    UIKeyModifierAlphaShift     = 1 << 16,  // Alppha+Shift键
    UIKeyModifierShift          = 1 << 17,  // Shift键
    UIKeyModifierControl        = 1 << 18,  // Control键
    UIKeyModifierAlternate      = 1 << 19,  // Alt键
    UIKeyModifierCommand        = 1 << 20,  // Command键
    UIKeyModifierNumericPad     = 1 << 21,  // Num键
} NS_ENUM_AVAILABLE_IOS(7_0);

NS_CLASS_AVAILABLE_IOS(7_0) @interface UIKeyCommand : NSObject <NSCopying, NSSecureCoding>

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic,readonly) NSString *input;		// 输入字符串
@property (nonatomic,readonly) UIKeyModifierFlags modifierFlags;	// 按键调节器
@property (nullable,nonatomic,copy) NSString *discoverabilityTitle NS_AVAILABLE_IOS(9_0);

// The action for UIKeyCommands should accept a single (id)sender, as do the UIResponderStandardEditActions below

// Creates an key command that will _not_ be discoverable in the UI.
+ (UIKeyCommand *)keyCommandWithInput:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags action:(SEL)action;		// 按指定调节器键输入字符串并设置事件

// Key Commands with a discoverabilityTitle _will_ be discoverable in the UI.
+ (UIKeyCommand *)keyCommandWithInput:(NSString *)input modifierFlags:(UIKeyModifierFlags)modifierFlags action:(SEL)action discoverabilityTitle:(NSString *)discoverabilityTitle NS_AVAILABLE_IOS(9_0);

@end

@interface UIResponder (UIResponderKeyCommands)		// 响应者类的按键命令类类目
@property (nullable,nonatomic,readonly) NSArray<UIKeyCommand *> *keyCommands NS_AVAILABLE_IOS(7_0); // 组合快捷键命令（装有多个按键的数组）
@end

@interface NSObject(UIResponderStandardEditActions)   // NSObject类的标准编辑事件相应类类目

- (void)cut:(nullable id)sender NS_AVAILABLE_IOS(3_0);          // 剪贴
- (void)copy:(nullable id)sender NS_AVAILABLE_IOS(3_0);         // 复制
- (void)paste:(nullable id)sender NS_AVAILABLE_IOS(3_0);        // 粘贴
- (void)select:(nullable id)sender NS_AVAILABLE_IOS(3_0);       // 选择
- (void)selectAll:(nullable id)sender NS_AVAILABLE_IOS(3_0);	// 选择全部
- (void)delete:(nullable id)sender NS_AVAILABLE_IOS(3_2);       // 删除
- (void)makeTextWritingDirectionLeftToRight:(nullable id)sender NS_AVAILABLE_IOS(5_0);	// 从左到右写入字符串（居左）
- (void)makeTextWritingDirectionRightToLeft:(nullable id)sender NS_AVAILABLE_IOS(5_0);	// 从右到左写入字符串（居左）
- (void)toggleBoldface:(nullable id)sender NS_AVAILABLE_IOS(6_0);	// 切换字体为黑体（粗体）
- (void)toggleItalics:(nullable id)sender NS_AVAILABLE_IOS(6_0);	// 切换文字为斜体
- (void)toggleUnderline:(nullable id)sender NS_AVAILABLE_IOS(6_0);	// 给文字添加下划线

- (void)increaseSize:(nullable id)sender NS_AVAILABLE_IOS(7_0);	// 增加字体大小
- (void)decreaseSize:(nullable id)sender NS_AVAILABLE_IOS(7_0);	// 减小字体大小

@end

@class UIInputViewController;
@class UITextInputMode;
@class UITextInputAssistantItem;


@interface UIResponder (UIResponderInputViewAdditions)


@property (nullable, nonatomic, readonly, strong) __kindof UIView *inputView NS_AVAILABLE_IOS(3_2);		// 键盘输入视图（系统默认的，可以自定义）
@property (nullable, nonatomic, readonly, strong) __kindof UIView *inputAccessoryView NS_AVAILABLE_IOS(3_2);	// 弹出键盘时附带的视图

/// This method is for clients that wish to put buttons on the Shortcuts Bar, shown on top of the keyboard.
/// You may modify the returned inputAssistantItem to add to or replace the existing items on the bar.
/// Modifications made to the returned UITextInputAssistantItem are reflected automatically.
/// This method should not be overriden. Goes up the responder chain.
@property (nonnull, nonatomic, readonly, strong) UITextInputAssistantItem *inputAssistantItem NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED __WATCHOS_PROHIBITED;

// For viewController equivalents of -inputView and -inputAccessoryView
// Called and presented when object becomes first responder.  Goes up the responder chain.
@property (nullable, nonatomic, readonly, strong) UIInputViewController *inputViewController NS_AVAILABLE_IOS(8_0);		// 键盘输入视图控制器
@property (nullable, nonatomic, readonly, strong) UIInputViewController *inputAccessoryViewController NS_AVAILABLE_IOS(8_0);	// 弹出键盘时附带的视图的视图控制器


@property (nullable, nonatomic, readonly, strong) UITextInputMode *textInputMode NS_AVAILABLE_IOS(7_0);		// 文本输入模式

@property (nullable, nonatomic, readonly, strong) NSString *textInputContextIdentifier NS_AVAILABLE_IOS(7_0);	// 文本输入模式标识

+ (void)clearTextInputContextIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(7_0);	// 根据设置的标识清楚指定的文本输入模式

- (void)reloadInputViews NS_AVAILABLE_IOS(3_2);		// 重新刷新键盘输入视图

@end

/*

注意:
UITextFields和UITextView有一个inputAccessoryView的属性，当你想在键盘上展示一个自定义的view时，你就可以设置该属性。你设置的view就会自动和键盘keyboard一起显示了。
需要注意的是，你所自定义的view既不应该处在其他的视图层里，也不应该成为其他视图的子视图。其实也就是说，你所自定义的view只需要赋给属性inputAccessoryView就可以了，不要再做其他多余的操作。
我们在使用UITextView和UITextField的时候，可以通过它们的inputAccessoryView属性给输入时呼出的键盘加一个附属视图，通常是UIToolBar，用于回收键盘。
inputView就是显示键盘的view,如果重写这个view则不再弹出键盘，而是弹出自己的view.如果想实现当某一控件变为第一响应者时不弹出键盘而是弹出我们自定义的界面，那么我们就可以通过修改这个inputView来实现，比如弹出一个日期拾取器。
inputView不会随着键盘出现而出现，设置了InputView只会当UITextField或者UITextView变为第一相应者时显示出来，不会显示键盘了。设置了InputAccessoryView，它会随着键盘一起出现并且会显示在键盘的顶端。InutAccessoryView默认为nil.

*/


// These are pre-defined constants for use with the input property of UIKeyCommand objects.	// 按键输入箭头指向
UIKIT_EXTERN NSString *const UIKeyInputUpArrow         NS_AVAILABLE_IOS(7_0);
UIKIT_EXTERN NSString *const UIKeyInputDownArrow       NS_AVAILABLE_IOS(7_0);
UIKIT_EXTERN NSString *const UIKeyInputLeftArrow       NS_AVAILABLE_IOS(7_0);
UIKIT_EXTERN NSString *const UIKeyInputRightArrow      NS_AVAILABLE_IOS(7_0);
UIKIT_EXTERN NSString *const UIKeyInputEscape          NS_AVAILABLE_IOS(7_0);

@interface UIResponder (ActivityContinuation)
@property (nullable, nonatomic, strong) NSUserActivity *userActivity NS_AVAILABLE_IOS(8_0);		// 用户活动
- (void)updateUserActivityState:(NSUserActivity *)activity NS_AVAILABLE_IOS(8_0);		// 更新用户活动
- (void)restoreUserActivityState:(NSUserActivity *)activity NS_AVAILABLE_IOS(8_0);		// 回复用户活动
@end

/*

注意：
支持User Activities
在UIResponder中，已经为我们提供了一个userActivity属性，它是一个NSUserActivity对象。因此我们在UIResponder的子类中不需要再去声明一个userActivity属性，直接使用它就行。其声明如下：
@property(nonatomic, retain) NSUserActivity *userActivity
由UIKit管理的User Activities会在适当的时间自动保存。一般情况下，我们可以重写UIResponder类的updateUserActivityState:方法来延迟添加表示User Activity的状态数据。当我们不再需要一个User Activity时，我们可以设置userActivity属性为nil。任何由UIKit管理的NSUserActivity对象，如果它没有相关的响应者，则会自动失效。
另外，多个响应者可以共享一个NSUserActivity实例。
上面提到的updateUserActivityState:是用于更新给定的User Activity的状态。其定义如下：
- (void)updateUserActivityState:(NSUserActivity *)activity
子类可以重写这个方法来按照我们的需要更新给定的User Activity。我们需要使用NSUserActivity对象的addUserInfoEntriesFromDictionary:方法来添加表示用户Activity的状态。
在我们修改了User Activity的状态后，如果想将其恢复到某个状态，则可以使用以下方法：
- (void)restoreUserActivityState:(NSUserActivity *)activity
子类可以重写这个方法来使用给定User Activity的恢复响应者的状态。系统会在接收到数据时，将数据传递给application:continueUserActivity:restorationHandler:以做处理。我们重写时应该使用存储在user activity的userInfo字典中的状态数据来恢复对象。当然，我们也可以直接调用这个方法

*/


NS_ASSUME_NONNULL_END




