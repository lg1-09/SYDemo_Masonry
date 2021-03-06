//
//  ViewController.m
//  DemoMasonry
//
//  Created by zhangshaoyu on 16/3/16.
//  Copyright © 2016年 zhangshaoyu. All rights reserved.
//  github：https://github.com/potato512/SYDemo_Masonry

#import "ViewController.h"
#import "LabelViewController.h"
#import "ViewViewController.h"
#import "ImageViewViewController.h"
#import "TextViewViewController.h"
#import "TextFieldViewController.h"
#import "AnimationViewController.h"
#import "OtherViewController.h"
#import "ScrollViewViewController.h"
#import "CollectionViewViewController.h"
#import "TableViewViewController.h"
#import "LoginViewController.h"

#import "GoodsDetailsVC.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *VCArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Masonry";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"demo" style:UIBarButtonItemStyleDone target:self action:@selector(barbuttonClick)];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 视图

- (void)setUI
{
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    
    UIScrollView *mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:mainScrollView];
    mainScrollView.backgroundColor = [UIColor redColor];
    
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.top.mas_equalTo(10.0);
//        make.left.mas_equalTo(10.0);
//        make.right.mas_equalTo(-10.0);
//        make.bottom.mas_equalTo(-10.0);
        
        // 或等价于
        make.top.left.mas_equalTo(10.0);
        make.bottom.right.mas_equalTo(-10.0);
        
        // 或等价于
//        make.top.left.bottom.and.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0));
        
        // 或等价于
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0));
    }];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectZero];
    [mainScrollView addSubview:containerView];
    containerView.backgroundColor = [UIColor orangeColor];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
//        make.edges.equalTo(mainScrollView);
//        make.width.equalTo(mainScrollView);
        
        // 或等价于
        make.top.left.bottom.and.right.equalTo(mainScrollView).with.insets(UIEdgeInsetsZero);
        make.width.equalTo(mainScrollView);
    }];
    
    UIView *lastView = nil;
    NSInteger count = self.array.count;
    for (NSInteger index = 0; index < count; index++)
    {
        NSString *title = self.array[index];
  
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainScrollView addSubview:button];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.tag = index;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor colorWithHue:(arc4random() % 256 / 256.0)
                                          saturation:(arc4random() % 128 / 256.0) + 0.5
                                          brightness:(arc4random() % 128 / 256.0) + 0.5
                                               alpha:1];

        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.and.right.equalTo(containerView);
            make.height.mas_equalTo(50.0);
            
            if (lastView)
            {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else
            {
                make.top.mas_equalTo(containerView.mas_top);
            }
        }];
        
        lastView = button;
    }
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

#pragma mark - 响应

- (void)barbuttonClick
{
    GoodsDetailsVC *vc = [[GoodsDetailsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)buttonClick:(UIButton *)button
{
    NSInteger index = button.tag;
    Class class = self.VCArray[index];
    ViewController *controller = [[class alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - setter

- (NSArray *)array
{
    if (!_array)
    {
        _array = [NSArray arrayWithObjects:@"label视图", @"view视图", @"imageview视图", @"textview视图", @"textfield视图", @"其他视图", @"animation动画视图", @"scrollview视图", @"collectionview视图", @"tableview视图", @"登录视图", nil];
    }
    
    return _array;
}

- (NSArray *)VCArray
{
    if (!_VCArray)
    {
        _VCArray = [NSArray arrayWithObjects:[LabelViewController class], [ViewViewController class], [ImageViewViewController class], [TextViewViewController class], [TextFieldViewController class], [OtherViewController class], [AnimationViewController class], [ScrollViewViewController class], [CollectionViewViewController class], [TableViewViewController class], [LoginViewController class], nil];
    }
    
    return _VCArray;
}

@end




