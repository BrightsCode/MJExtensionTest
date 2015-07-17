//
//  ViewController.m
//  test
//
//  Created by zhangchao on 15/7/17.
//  Copyright (c) 2015年 bright. All rights reserved.
//

#import "ViewController.h"
#import "StoreInfo.h"
#import <MJExtension.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [StoreInfo setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"store_id" : @"id"
                 };
    }];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"json"];
    
    StoreInfo *info1 = [StoreInfo objectWithKeyValues:[NSData dataWithContentsOfFile:path]];
    NSLog(@"info1 = %@",info1);
    
    NSDictionary *dic1 = [info1 keyValues];
    [[NSUserDefaults standardUserDefaults] setObject:dic1 forKey:@"storeInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSDictionary *dic2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"storeInfo"];
    
    NSLog(@"store_id = %@",dic2[@"store_id"]); //这里store_id为2231
    
    
    StoreInfo *info2 = [StoreInfo objectWithKeyValues:dic2];
    
    //2.3.8版本这里store_id为2231，2.4.0 ~ 2.5.0版本store_id就为0了。
    NSLog(@"info2.store_id = %ld",info2.store_id);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
