# 一个自定义的下拉多选菜单
前段时间项目刚好要做到条件筛选菜单，正好找到一些别人写的，结合自己实际需求进行优化修改，一个实用的多条件筛选菜单，根据其他的下拉进行一些改进。

点击后返回点击文字显示

![](https://github.com/sidiaoling/XZ-DropdownMenu/blob/master/Untitled.gif)

使用方法
=====
        DropdownMenu *dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_titleArray andLeftListArray:_leftArray         andRightListArray:_rightArray];
        dropdown.delegate = self;   //代理返回选中下标
        [self.view addSubview:dropdown.view];
    

//实现代理
- (void)dropdownSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right; {
    
    NSLog(@"%s : You choice %@ and %@ ---%d", __FUNCTION__, left, right);
    
}
