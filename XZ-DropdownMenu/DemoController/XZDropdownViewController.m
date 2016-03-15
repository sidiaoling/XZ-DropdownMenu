//
//  XZDropdownViewController.m
//  XZ-DropdownMenu
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XZDropdownViewController.h"
#import "DropdownMenu.h"

@interface XZDropdownViewController () <dropdownDelegate> {
    
    ConditionDoubleTableView *tableView;
    NSArray *_titleArray;
    NSArray *_leftArray;
    NSArray *_rightArray;
}

@end

@implementation XZDropdownViewController

- (id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self testData];
    DropdownMenu *dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_titleArray andLeftListArray:_leftArray andRightListArray:_rightArray];
    dropdown.delegate = self;   //此句的代理方法可返回选中下标值
    [self.view addSubview:dropdown.view];
}

#pragma mark -- dropdownDelegate
- (void)testData {
    [self testTitleArray];
    [self testLeftArray];
    [self testRightArray];
}

//每个下拉的标题
- (void) testTitleArray {
    _titleArray = @[@"年级科目", @"师资水平",@"智能排序"];
}

//左边列表可为空，则为单下拉菜单，可以根据需要传参
- (void)testLeftArray {
    NSArray *One_leftArray = @[@"全部", @"小学", @"初中", @"高中"];
    NSArray *Two_leftArray = [[NSArray alloc] init];
    NSArray *R_leftArray = [[NSArray alloc] init];
    
    
    _leftArray = [[NSArray alloc] initWithObjects:One_leftArray, Two_leftArray,R_leftArray, nil];
}

//测试数据，测试数据一般是网络请求获取，此处暂时写死
- (void)testRightArray {
    NSArray *F_rightArray = @[
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"语文"},
                                  @{@"title":@"数学"},
                                  @{@"title":@"英语"},
                                  @{@"title":@"化学"},
                                  @{@"title":@"生物"},
                                  @{@"title":@"物理"},
                                  @{@"title":@"地理"},
                                  @{@"title":@"政治"},
                                  @{@"title":@"历史"},
                                  @{@"title":@"心理"}
                                  ] ,
                              
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"语文"},
                                  @{@"title":@"数学"},
                                  @{@"title":@"英语"},
                                  @{@"title":@"心理"},
                                  ],
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"语文"},
                                  @{@"title":@"数学"},
                                  @{@"title":@"英语"},
                                  @{@"title":@"化学"},
                                  @{@"title":@"生物"},
                                  @{@"title":@"物理"},
                                  @{@"title":@"地理"},
                                  @{@"title":@"政治"},
                                  @{@"title":@"历史"},
                                  @{@"title":@"心理"}
                                  ] ,
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"语文"},
                                  @{@"title":@"数学"},
                                  @{@"title":@"英语"},
                                  @{@"title":@"化学"},
                                  @{@"title":@"生物"},
                                  @{@"title":@"物理"},
                                  @{@"title":@"地理"},
                                  @{@"title":@"政治"},
                                  @{@"title":@"历史"},
                                  @{@"title":@"心理"}
                                  ]
                              ];
    
    NSArray *S_rightArray = @[
                              @[
                                  @{@"title":@"全部"},
                                  @{@"title":@"一级教师"},
                                  @{@"title":@"高级教师"},
                                  @{@"title":@"正高级教师"}
                                  ]
                              ];
    NSArray *R_rightArray = @[
                              @[
                                  @{@"title":@"默认排序"},
                                  @{@"title":@"评分优先"},
                                  @{@"title":@"教龄优先"},
                                  @{@"title":@"答题数优先"},
                                  @{@"title":@"预约数优先"}
                                  ] ,
                              ];
    
    _rightArray = [[NSArray alloc] initWithObjects:F_rightArray, S_rightArray,R_rightArray, nil];
}

//实现代理，返回选中的下标，若左边没有列表，则返回0
- (void)dropdownSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right; {
    
    NSLog(@"%s : You choice %@ and %@ ---%d", __FUNCTION__, left, right);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
