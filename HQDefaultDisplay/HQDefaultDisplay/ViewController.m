//
//  ViewController.m
//  HQDefaultDisplay
//
//  Created by 宇航 on 2020/5/28.
//  Copyright © 2020 tecent. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+DefaultDisplay.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation ViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _tableView.delegate =self;
        _tableView.dataSource=self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self loadServeData];

}

- (void)loadServeData{
    self.dataArray = [NSMutableArray array];
    //[self.dataArray  addObject:@"yuhang"];
    //[self.dataArray  addObject:@"kele"];
    
    self.tableView.displayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSString * text = self.dataArray[indexPath.row];
    cell.textLabel.text =text;
    cell.textLabel.textColor =[UIColor purpleColor];
    return cell;
}
@end
