//
//  PrintViewController.m
//  printerOne
//
//  Created by 速通mac on 16/7/7.
//  Copyright © 2016年 速通mac. All rights reserved.
//

#import "PrintViewController.h"
#import "PrinterSDK.h"
#import "PrinterListViewController.h"
@interface PrintViewController ()
- (IBAction)print:(id)sender;
- (IBAction)select:(id)sender;
- (IBAction)deploy:(id)sender;
- (IBAction)duankai:(id)sender;

@end

@implementation PrintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)print:(id)sender {
    [PrinterWraper SetBlutoothDelegate:self];
    NSArray *headers =@[@"编号",@"名称",@"价格",@"数量",@"小计金额"];
    NSArray *values0 =@[@"0",@"杜蕾斯",@"10",@"1",@"10.0"];
    NSArray *values1 =@[@"0",@"杜蕾斯丝袜",@"100",@"1",@"100.0"];
    NSArray *values2 =@[@"0",@"大白菜",@"1",@"10",@"10.0"];
    NSArray* body =@[headers,values0,values1,values2];
    //    设置格式 大字体 行间距28 局中
    [PrinterWraper setPrintFormat:3 LineSpace:28 alinment:1 rotation:0];// 3 大字体  ，28默认行间距,1局中对齐
    NSString*photopath=[[NSBundle mainBundle] pathForResource:@"ico180" ofType:@"png"];
    
    //打印logo
    //    [PrinterWraper addPrintImage:[UIImage imageWithContentsOfFile:photopath]];
    //打印标题
    [PrinterWraper addPrintText:@"速通科技有限公司"];//打印文字
    //    设置主体内容 小字体
    [PrinterWraper setPrintFormat:1 LineSpace:28 alinment:0 rotation:0];// 1 小字体  ，28默认行间距,0左对齐
    
    [PrinterWraper addPrintText:@"一杯咖啡9块9啊\n"];//打印文字
    
    
    //打印商品列表，会自动排版，要求数组长度一致，空白地方用@""
    [PrinterWraper addItemLines:body];
    //打印二维码
//    [PrinterWraper addPrintBarcode:@"http://www.baidu.com" isTwoDimensionalCode:1];//二维码
    //    打印一维码 必须是12-13位数字
    NSString *formedUPC =[PrinterWraper addUPCLastVerifyCode:@"123456789101"];
//    [PrinterWraper addPrintBarcode:formedUPC isTwoDimensionalCode:0];//1维码 upc 必须按upc规则生成 最后一位是校验位
    
    //打印code128 任意位数字母和数字
//    [PrinterWraper addPrintBarcode:@"12345678901235678" isTwoDimensionalCode:-1];//1维码 code128
    
    
    [PrinterWraper moveToNextPage];//换页
    //    [PrinterWraper addPrintText:@"\n\n"];//打印文字
    //    开始启动打印
    //    [PrinterWraper startPrint:self.navigationController];
    BOOL res=   [PrinterWraper startPrint:self.navigationController];
    if (!res) {
        PrinterListViewController *detail=[[PrinterListViewController alloc] init];
        //        detail.taskmodel =model;
        [self.navigationController pushViewController:detail animated:YES];
        
        
    }

}

- (IBAction)select:(id)sender {
    PrinterListViewController *detail=[[PrinterListViewController alloc] init];
    
    [self.navigationController pushViewController:detail animated:YES];
    

}

- (IBAction)deploy:(id)sender {
}

- (IBAction)duankai:(id)sender {
    [PrinterWraper disconnectPrinter:nil];

}
@end
