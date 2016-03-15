//
//  ConditionDoubleTableView.h
//  MacauFood
//
//  Created by Ryan Wong on 15/8/21.
//  Copyright (c) 2015年 tenfoldtech. All rights reserved.
//

/**
 *  老师列表上面的导航栏使用到的工具类
 */
#import <UIKit/UIKit.h>
@protocol ConditionDoubleTableViewDelegate <NSObject>

@required
- (void)selectedFirstValue:(NSString *)first SecondValue:(NSString *)second;
- (void)hideMenu;
@end

@interface ConditionDoubleTableView : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UIView *_rootView;
    
    UITableView *_firstTableView;
    UITableView *_secondTableView;
    UIView *bottomView;
    NSArray *_leftItems;
    NSArray *_rightItems;
    NSArray *_leftArray;
    NSArray *_rightArray;
    
    NSInteger firstSelectedIndex;
    NSInteger secondSelectedIndex;
    
    NSInteger _buttonIndex;
    NSInteger _onex;
    NSInteger _twox;
    BOOL isHidden;
    BOOL isfirstopen;
}

@property (nonatomic, strong) id <ConditionDoubleTableViewDelegate>delegate;

//初始化下拉菜单
- (id)initWithFrame:(CGRect)frame andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)RightItems;
//显示下拉菜单
- (void)showTableView:(NSInteger)index WithSelectedLeft:(NSString *)left Right:(NSString *)right;
- (void)hideTableView;
@end
