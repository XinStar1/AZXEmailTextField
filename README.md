# AZXEmailTextField
具有邮箱下拉提示textField    
![image](https://github.com/XinStar1/AZXEmailTextField/blob/master/textFieldResult.gif)
#使用方法
如果使用上图默认样式，一句代码搞定(其中View是打算作为自定义textField超类的view，frame是其在View中的frame)
```
AZXEmailTextField *textField = [[AZXEmailTextField alloc] initWithFrame:frame InView:view];
```
支持自定义样式，可以设置下拉列表Cell的高度
```
[textField setCellHeight:44];
```
设置要关联邮箱后缀的内容
```
[textField setTableViewSuffixArray:@[@"163.com", @"qq.com", @"gmail.com"]];
```
文字离列表左边的距离
```
[textField setLeftMargin:14];
```
分割线的左右距离等等
```
[textField setSeparatorInsets:@[@0, @14, @0, @14]]; //分别传入要设置分割线上、左、下、右离边缘的距离
```
还有许多相关自定义方法都定义在.h文件里。   
代码详细讲解可以看博客http://www.jianshu.com/p/4bfb99b828b3    
如果这个小demo帮到你的话，希望star一下当做对我的鼓励，谢谢！
