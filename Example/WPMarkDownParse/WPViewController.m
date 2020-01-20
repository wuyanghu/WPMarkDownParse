//
//  WPViewController.m
//  WPMarkDownParse
//
//  Created by 823105162@qq.com on 01/20/2020.
//  Copyright (c) 2020 823105162@qq.com. All rights reserved.
//

#import "WPViewController.h"
#import "YYText.h"
#import "WPMarkDownParseFactory.h"

@interface WPViewController ()
@property (nonatomic,strong) YYLabel * yylabel;
@end

@implementation WPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    [super configureCell:cell atIndexPath:indexPath];
    
}

@end
