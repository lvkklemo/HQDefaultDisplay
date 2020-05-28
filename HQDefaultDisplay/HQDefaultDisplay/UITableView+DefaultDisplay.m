//
//  UITableView+DefaultDisplay.m
//  HQDefaultDisplay
//
//  Created by 宇航 on 2020/5/28.
//  Copyright © 2020 tecent. All rights reserved.
//

/*
 定义方法和属性
 1.运行时,是开发OC的;OC是在运行时的C语言的API的基础之上的封装
 2.可以动态的给对象增加属性 : 字典转模型框架
 3.可以动态的交换方法的地址 : 可以交换自定义的方法和系统的方法的地址
 4.可以动态的获取对象的属性 : 字典转模型框架
 5.可以动态的给某个分类关联上它的属性
 6.可以动态的给对象的私有的成员变量赋值
 7.只在开发大型框架时使用的,平时开发用不到的
 */
#import "UITableView+DefaultDisplay.h"

#import <objc/runtime.h>

const char * kDefaultView;

@implementation UITableView (DefaultDisplay)

+ (void)initialize{
    NSLog(@"%s",__func__);
}
+ (void)load{
    NSLog(@"%s",__func__);
    Method originMethod =class_getInstanceMethod(self, @selector(reloadData));
    Method currentMethod =class_getInstanceMethod(self, @selector(hq_reloadData));
    method_exchangeImplementations(originMethod,currentMethod);
}

-(void)hq_reloadData{
    [self hq_reloadData];
    [self fillDefaultView];
}
- (void)fillDefaultView{
    id<UITableViewDataSource> dataSource = self.dataSource;
    NSInteger section = ([dataSource respondsToSelector:@selector(numberOfRowsInSection:)])?[dataSource numberOfSectionsInTableView:self]:1;
    NSInteger rows = 0;
    for (int index = 0; index<section; index++) {
        NSUInteger row = [dataSource tableView:self numberOfRowsInSection:section];
        rows = rows + row;
    }
    if (rows == 0) {
        //self.displayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self addSubview:self.displayView];
        self.displayView.backgroundColor = [UIColor purpleColor];
    }else{
        self.displayView.hidden =YES;
    }
}

/*
 参数1 : 关联的对象
 参数2 : 关联的key
 参数3 : 关联的value
 参数4 : 关联的value的存储策略
 */
#pragma mark getter and setter
- (void)setDisplayView:(UIView *)displayView{
    objc_setAssociatedObject(self, &kDefaultView, displayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)displayView{
    return objc_getAssociatedObject(self, &kDefaultView);
}
@end
