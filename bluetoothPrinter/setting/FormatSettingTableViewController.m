//
//  FormatSettingTableViewController.m
//  PrinterDemo
//
//  Created by doulai on 9/30/15.
//  Copyright © 2015 com.cmcc. All rights reserved.
//

#import "FormatSettingTableViewController.h"
#import "ValueEditViewController.h"
//#import "HjTools.h"
@interface FormatSettingTableViewController ()<UIActionSheetDelegate>
{
    UIPickerView *pick;
    UIButton *okbtn;
    UIButton *cancelbtn;
    NSMutableDictionary *settingDictionary;
    NSArray *TextIndexarray;
    NSArray *TextIndexarrayCN;

    NSArray *ButtonIndexarray;
    NSArray *ButtonIndexarrayCN;
    
    NSArray *printtypeArr;
    NSArray *printFontArr;
    NSString *choosedKeyword;
}
@end

@implementation FormatSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    UIBarButtonItem*rightbaritem=[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(rightbarPress)];
//    self.navigationItem.rightBarButtonItem = rightbaritem;
    

//NSLocalizedString(@"公司图标", @"") logo
  TextIndexarray    = @[@"printertype", @"printerfontsize",@"copycount",@"autoprint",@"printphone",@"company",@"operater",@"welcome",@"barcode"];
  TextIndexarrayCN =@[ NSLocalizedString(@"打印机宽度", @""), NSLocalizedString(@"字体大小", @""),NSLocalizedString(@"打印联数", @""),NSLocalizedString(@"保存后自动打印", @""),NSLocalizedString(@"打印客户详情", @""), NSLocalizedString(@"公司名称", @""), NSLocalizedString(@"开单员", @""), NSLocalizedString(@"页脚", @""), NSLocalizedString(@"二维码", @""),];
    

    ButtonIndexarray  = ITEMS_PRODUCT_KEY;
    ButtonIndexarrayCN  = ITEMS_PRODUCT_VALUE;
    
    printtypeArr = @[@"58mm",@"80mm",@"110mm",NSLocalizedString(@"针式210mm",@""),@"AirPrint 210mm"];
    printFontArr = @[NSLocalizedString(@"自动", @""),NSLocalizedString(@"小字体", @""),NSLocalizedString(@"中字体", @""),NSLocalizedString(@"大字体", @"")];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSDictionary *saved= [PrinterWraper getPrinterSetting];
    settingDictionary =[NSMutableDictionary dictionaryWithDictionary:saved];
    [self.tableView reloadData];
     [self saveChange];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)rightbarPress{
  
    [self saveChange];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveChange{
    [PrinterWraper setPrinterSetting:settingDictionary];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return TextIndexarray.count;
    }else
        return ButtonIndexarray.count;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"表头表尾打印内容", @"");
    }else if(section == 1)
        return NSLocalizedString(@"商品信息打印项目", @"");
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingindentify" ];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"settingindentify"];
        }
        NSString *keyword = TextIndexarray[indexPath.row];
        cell.textLabel.text = TextIndexarrayCN[indexPath.row];
        if ([keyword isEqualToString:@"printertype"]) {
            NSNumber * index = [settingDictionary objectForKey:keyword];
            cell.detailTextLabel.text = printtypeArr[[index integerValue]];
           
        }else if ( [keyword isEqualToString:@"printerfontsize"])
        {
            NSNumber * index = [settingDictionary objectForKey:keyword];
            cell.detailTextLabel.text = printFontArr[[index integerValue]];
        }else if ( [keyword isEqualToString:@"copycount"])
        {
            NSNumber * index = [settingDictionary objectForKey:keyword];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",[index intValue]+1];
            
        }else if ( [keyword isEqualToString:@"autoprint"] || [keyword isEqualToString:@"printphone"])
        {
            NSNumber * index = [settingDictionary objectForKey:keyword];
            if ([index intValue]==0) {
                cell.detailTextLabel.text =NSLocalizedString(@"否", @"");
            }else
                cell.detailTextLabel.text =NSLocalizedString(@"是", @"");
            
        }else if ([keyword isEqualToString:@"logo"]){
            
        }
        else
            cell.detailTextLabel.text = settingDictionary[keyword];

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;


    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingproductindentify" ];
        if (!cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"settingproductindentify"];
        }
        NSString *keyword = ButtonIndexarray[indexPath.row];
        cell.textLabel.text = ButtonIndexarrayCN[indexPath.row];
        NSNumber *check=[settingDictionary objectForKey:keyword];
        if ([check boolValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else
            cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;

    }
        // Configure the cell...
    
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    choosedKeyword = nil;
    if (indexPath.section == 0) {

        NSString *keyword = TextIndexarray[indexPath.row];
        
//        NSString *value=[settingDictionary objectForKey:keyword];
        if (indexPath.row < 5) {
            choosedKeyword =keyword;
            [self showActionSheet];
        }else
        {

            ValueEditViewController *detail =[[ValueEditViewController alloc ] init];
            detail.title =TextIndexarrayCN[indexPath.row];
            detail.keyword = keyword;
            [self.navigationController pushViewController:detail animated:YES];
        }
        
    }else if(indexPath.section == 1){
        NSString *keyword = ButtonIndexarray[indexPath.row];
      
        NSNumber *check=[settingDictionary objectForKey:keyword];
        check =[NSNumber numberWithBool:![check boolValue]];
        [settingDictionary setObject:check forKey:keyword];
        [self.tableView reloadData];
        
        [self saveChange];
    }
    
}
#pragma mark sheet
-(void)showActionSheet{
    
    UIActionSheet *action =[[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"请选择", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"取消", @"") destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    NSArray *tmp;
    if ([choosedKeyword isEqualToString:@"printertype"] ) {
        tmp =printtypeArr;
    }
    if ([choosedKeyword isEqualToString:@"printerfontsize"]) {
        tmp = printFontArr;
    }
    if ([choosedKeyword isEqualToString:@"copycount"]) {
        tmp =@[@"1",@"2",@"3"];
    }
    if ([choosedKeyword isEqualToString:@"autoprint"]) {
        tmp =@[NSLocalizedString(@"否",@""),NSLocalizedString(@"是",@"")];
    }
    if ([choosedKeyword isEqualToString:@"printphone"]) {
        tmp =@[NSLocalizedString(@"否",@""),NSLocalizedString(@"是",@"")];
    }
    for (NSString *item in tmp) {
        [action addButtonWithTitle:item];
    }
    [action showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 8_3);
{

    if (buttonIndex > 0) {
        buttonIndex--;

         NSNumber * printertype =[NSNumber numberWithInteger:buttonIndex];
        [settingDictionary setObject:printertype forKey:choosedKeyword];
        [self.tableView reloadData];
         [self saveChange];
    }
    
}
#pragma mark pick

@end
