//
//  ConditionDoubleTableView.m
//  MacauFood
//
//  Created by Ryan Wong on 15/8/21.
//  Copyright (c) 2015年 tenfoldtech. All rights reserved.
//

/**
 *  老师列表上面的导航栏使用到的工具类
 */
#import "ConditionDoubleTableView.h"
#import "CommonDefine.h"

#define CELLHEIGHT 44.0
#define XZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation ConditionDoubleTableView

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame andLeftItems:(NSArray *)leftItems andRightItems:(NSArray *)RightItems{
    frame = SCREEN_RECT;
//    self = [super initWithFrame:CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT + 40, frame.size.width, frame.size.height - STATUS_AND_NAVIGATION_HEIGHT - 40)];
    self = [super init];
    if (self) {
        self.view.frame = CGRectMake(0, STATUS_AND_NAVIGATION_HEIGHT + 40, frame.size.width, frame.size.height - STATUS_AND_NAVIGATION_HEIGHT - 40);
        self.view.backgroundColor = [self colorWithRGB:0x000000 alpha:0.3];
        _rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height / 2)];
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height / 2, frame.size.width, frame.size.height)];
        //bottomView.backgroundColor = [UIColor redColor];
        //UITapGestureRecognizer *tapDimissMenu = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTableView)];
        //[self.view addGestureRecognizer:tapDimissMenu];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTableView) name:@"hideall" object:nil];
        _buttonIndex = -1;
        isHidden = YES;
        _leftItems = leftItems;
        _rightItems = RightItems;
        
        [self initFirstTableViewWithFrame:frame];
        [self initSecondTableViewWithFrame:frame];
        [self.view addSubview:_rootView];
        [self.view addSubview:bottomView];
    }
    [self.view setHidden:YES];
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hideTableView];
}

- (void)initFirstTableViewWithFrame:(CGRect)frame {
    _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 3, 175) style:UITableViewStylePlain];
    _firstTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _firstTableView.backgroundColor = [self colorWithRGB:0xFAFAFA];
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    _firstTableView.showsVerticalScrollIndicator = NO;
    _firstTableView.scrollEnabled = NO;
    [_rootView addSubview:_firstTableView];
//    [_firstTableView reloadData];
}

- (void)initSecondTableViewWithFrame:(CGRect)frame {
    _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width, frame.size.height / 2) style:UITableViewStylePlain];
    _secondTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _secondTableView.backgroundColor = [UIColor whiteColor];
    _secondTableView.delegate = self;
    _secondTableView.dataSource = self;
    _secondTableView.layer.borderWidth = 0.5;
    _secondTableView.hidden = YES;
    _secondTableView.showsVerticalScrollIndicator = NO;
    _secondTableView.scrollEnabled = NO;
    _secondTableView.layer.borderColor = [[self colorWithRGB:0xBEBEBE] CGColor];
    [_rootView addSubview:_secondTableView];
}

#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _firstTableView) {
        return _leftArray.count;
    } else if (tableView == _secondTableView) {
        if (_rightArray.count > firstSelectedIndex) {
            NSArray *array = [_rightArray objectAtIndex:firstSelectedIndex];
            return array.count;
        } else {
            return 0;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (tableView == _firstTableView) {
        switch (indexPath.section) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FirstCell"];
                }
                [self removeCellView:cell];
                if (_leftArray.count > 0) {
                    cell.textLabel.text = [_leftArray objectAtIndex:indexPath.row];
                    cell.textLabel.font = [UIFont systemFontOfSize:14];
                    cell.textLabel.textAlignment=UITextAlignmentCenter;
                    cell.textLabel.textColor = XZColor(51, 51, 51);
                }
                cell.textLabel.highlightedTextColor = XZColor(0, 163, 232);
                break;
            }
            default:
                break;
        }
        UIView *noSelectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        UIView *noSelectLine = [[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.bounds.size.height-1, cell.contentView.bounds.size.width, 0.5)];
        noSelectLine.backgroundColor = [self colorWithRGB:0xBEBEBE];
        [noSelectView addSubview:noSelectLine];
        UIView *selectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        UIView *selectLine = [[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.bounds.size.height-1, cell.contentView.bounds.size.width, 0.5)];
        selectLine.backgroundColor = [self colorWithRGB:0xBEBEBE];
        [selectView addSubview:selectLine];
        cell.backgroundView = noSelectView;
        cell.selectedBackgroundView = selectView;
        //UIView *selectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        //selectView.backgroundColor = [self colorWithRGB:0xBEBEBE];;
        //cell.selectedBackgroundView = selectView;
        //cell.backgroundColor = [UIColor clearColor];
        
    } else if (tableView == _secondTableView){
        switch (indexPath.section) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondCell"];
                }
                [self removeCellView:cell];
                NSArray *array = [_rightArray objectAtIndex:firstSelectedIndex];
                if (array.count <= 0) {
                    break;
                }
                NSDictionary *dic = [array objectAtIndex:indexPath.row];
                cell.textLabel.text = [dic valueForKey:@"title"];
                cell.textLabel.highlightedTextColor = XZColor(0, 163, 232);
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textAlignment=UITextAlignmentCenter;
                cell.textLabel.textColor = XZColor(51, 51, 51);
                break;
            }
            default:
                break;
        }
        UIView *noSelectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        UIView *noSelectLine = [[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.bounds.size.height-1, cell.contentView.bounds.size.width, 0.5)];
        noSelectLine.backgroundColor = [self colorWithRGB:0xBEBEBE];
        [noSelectView addSubview:noSelectLine];
        UIView *selectView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        UIView *selectLine = [[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.bounds.size.height-1, cell.contentView.bounds.size.width, 0.5)];
        selectLine.backgroundColor = [self colorWithRGB:0xBEBEBE];
        [selectView addSubview:selectLine];
        cell.backgroundView = noSelectView;
        cell.selectedBackgroundView = selectView;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELLHEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _firstTableView && _leftArray.count > 0) {
        _secondTableView.hidden = NO;
        firstSelectedIndex = indexPath.row;
        [_secondTableView reloadData];
    } else {
        _secondTableView.hidden = NO;
        [self returnSelectedValue:indexPath.row];
    }
    
}

- (void)removeCellView:(UITableViewCell*)cell {
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
}

#pragma mark - 私有方法
//显示下拉菜单
- (void)showTableView:(NSInteger)index WithSelectedLeft:(NSString *)left Right:(NSString *)right {
    if (isHidden == YES || _buttonIndex != index) {
        _buttonIndex = index;
        isHidden = NO;
        self.view.alpha = 1.0;
        [self.view setHidden:NO];
        [self reloadTableViewData:index];
        [self showSingleOrDouble];
        [self showLastSelectedLeft:left Right:right];
        _rootView.center = CGPointMake(self.view.frame.size.width / 2, 0 - _rootView.bounds.size.height / 2);
        [UIView animateWithDuration:0.5 animations:^{
            _rootView.center = CGPointMake(self.view.frame.size.width / 2, _rootView.bounds.size.height / 2);
        }];
    } else {
        [self hideTableView];
    }
}

- (void)showSingleOrDouble {
    if (_leftArray.count <= 0) {
        [_firstTableView setHidden:YES];
        _secondTableView.frame = CGRectMake( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 2);
    } else {
        [_firstTableView setHidden:NO];
        _secondTableView.frame = CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH/3*2, SCREEN_HEIGHT / 2);
    }
    //三个按钮的判断
    if (_buttonIndex == 1) {
        [_firstTableView setHidden:YES];
        _secondTableView.scrollEnabled = NO;
        _secondTableView.hidden = NO;
        _secondTableView.frame = CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH/3, CELLHEIGHT*4);
        bottomView.frame=CGRectMake(0, SCREEN_HEIGHT/2-60, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    else if (_buttonIndex == 2){
        [_firstTableView setHidden:YES];
        _secondTableView.scrollEnabled = NO;
        _secondTableView.hidden = NO;
        _secondTableView.frame = CGRectMake(SCREEN_WIDTH / 3*2, 0, SCREEN_WIDTH/3, CELLHEIGHT*5);
        bottomView.frame=CGRectMake(0, SCREEN_HEIGHT/2-40, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    else if (_buttonIndex == 0){
        _secondTableView.scrollEnabled = YES;
        _secondTableView.hidden = YES;
        bottomView.frame=CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
}

//按了不同按钮,刷新菜单数据
- (void)reloadTableViewData:(NSInteger)index {
    _leftArray = [[NSArray alloc] initWithArray:[_leftItems objectAtIndex:index]];
    _rightArray = [[NSArray alloc] initWithArray:[_rightItems objectAtIndex:index]];
}

//渐渐隐藏菜单
- (void)hideTableView {
    isHidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0.0;
    } completion:^(BOOL finish){
         [self.view setHidden:YES];
        _rootView.center = CGPointMake(self.view.frame.size.width / 2, 0 - _rootView.bounds.size.height / 2);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideMenu" object:[NSString stringWithFormat:@"%ld",(long)_buttonIndex]];
    }];
}

//返回选中位置
- (void)returnSelectedValue:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedFirstValue:SecondValue:)]) {
        NSInteger firstSelected = firstSelectedIndex > 0 ? firstSelectedIndex : 0;
        NSString *firstIndex;
        if (_leftArray.count != 0) {
            firstIndex = [_leftArray objectAtIndex:firstSelected];
        }
        
        _onex = firstSelected;
        _twox = index;
        NSString *indexObj = [[[_rightArray objectAtIndex:firstSelected] objectAtIndex:index] valueForKey:@"title"];
        [self.delegate performSelector:@selector(selectedFirstValue:SecondValue:) withObject:firstIndex withObject:indexObj];
        [self hideTableView];
    }
    //NSLog(@"%ld,%ld--%d",(long)firstSelectedIndex,(long)secondSelectedIndex,_buttonIndex);
}

//显示最后一次选中位置
- (void)showLastSelectedLeft:(NSString *)leftSelected Right:(NSString *)rightSelected {
    
    NSInteger left = [leftSelected intValue];
    if (_leftArray.count > 0) {
        [_firstTableView reloadData];
        NSIndexPath *leftSelectedIndexPath = [NSIndexPath indexPathForRow:left inSection:0];
        if (!isfirstopen) {
            [_firstTableView selectRowAtIndexPath:leftSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            isfirstopen = YES;
        }
        else{
            
        }
        
    }
    
    firstSelectedIndex = left;
    
    NSInteger right = [rightSelected intValue];
    [_secondTableView reloadData];
    NSIndexPath *rightSelectedIndexPath = [NSIndexPath indexPathForRow:right inSection:0];
    //[_secondTableView selectRowAtIndexPath:rightSelectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (UIColor*)colorWithRGB:(unsigned int)RGBValue
{
    return [UIColor colorWithRed:((RGBValue&0xFF0000)>>16)/255.0 green:((RGBValue&0xFF00)>>8)/255.0 blue:(RGBValue&0xFF)/255.0 alpha:1];
}

- (UIColor*)colorWithRGB:(unsigned int)RGBValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((RGBValue&0xFF0000)>>16)/255.0 green:((RGBValue&0xFF00)>>8)/255.0 blue:(RGBValue&0xFF)/255.0 alpha:alpha];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hideMenu" object:nil];
}

@end
