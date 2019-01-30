//
//  ViewController.m
//  touchOpen
//
//  Created by 李俊宇 on 2019/1/29.
//  Copyright © 2019 李俊宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;  ///< <#Description#>
@property (nonatomic, strong) NSArray *footerContent;  ///< <#Description#>
@property (nonatomic, strong) NSMutableArray *isOpen;  ///< 是否展开


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置代理，数据源
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    self.isOpen = [NSMutableArray array];
    
    self.dataSource = @[@"如何参与活动？",@"付款成功后显示商品不在订单怎么办？",@"如果登录密码忘记了怎么办？"];
    
    self.footerContent = @[@"查看活动详情，然后点击分享给好友帮您点赞，集满赞数就会自动获取抽中的资格啦~",@"",@""];
    
    for (int i = 0; i < self.dataSource.count; i ++) {
        BOOL isOpen = NO;               //默认不展开
        [self.isOpen addObject:[NSNumber numberWithBool:isOpen]];
    }
    
}


#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.section];
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 8)];
    image1.image = [UIImage imageNamed:@"ic_arrow_right_dark_gray_shrinkage"];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 8)];
    image2.image = [UIImage imageNamed:@"ic_arrow_right_dark_gray_up"];
    
    
    if ([self.isOpen[indexPath.section] boolValue])
        cell.accessoryView = image2;
    else
        cell.accessoryView = image1;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark - UITableView Delegate methods

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *introLabel = [UILabel new];
    introLabel.numberOfLines = 0;
    [view addSubview:introLabel];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.footerContent[section] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 17],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    //自适应label的高度
    introLabel.attributedText = string;
    CGSize baseSize = CGSizeMake(375, CGFLOAT_MAX);
    CGSize labelSize = [introLabel sizeThatFits:baseSize];
    introLabel.frame = CGRectMake(16, 0, 375, labelSize.height);
    introLabel.tintColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    //自适应label的高度
    if ([self.isOpen[section] boolValue]) {
        UILabel *label = [UILabel new];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:self.footerContent[section] attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: 17]}];
        label.attributedText = string;
        label.numberOfLines = 0;
        CGSize baseSize = CGSizeMake(375, CGFLOAT_MAX);
        CGSize labelSize = [label sizeThatFits:baseSize];
        return labelSize.height;
    }
    else
        return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 8)];
    image1.image = [UIImage imageNamed:@"ic_arrow_right_dark_gray_shrinkage"];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 8)];
    image2.image = [UIImage imageNamed:@"ic_arrow_right_dark_gray_up"];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (![self.isOpen[indexPath.section] boolValue]) {
        cell.accessoryView = image2;
        BOOL isOpen = YES;
        [self.isOpen replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:isOpen]];
    }else{
        cell.accessoryView = image1;
        BOOL isOpen = NO;
        [self.isOpen replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:isOpen]];
    }
    
    //如果想点击有动画效果就用局部刷新 如果想点击马上响应就用全局刷新
//    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
//    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];

    [self.tableView reloadData];
}


@end
