//
//  LASMainMenuViewController.m
//  Alcolater
//
//  Created by Lisa Accardi on 9/8/14.
//  Copyright (c) 2014 com.lemonappstand. All rights reserved.
//

#import "LASMainMenuViewController.h"
#import "LASViewController.h"
#import "LASWhiskeyViewController.h"

@interface LASMainMenuViewController ()

@property (strong, nonatomic) UIButton *wineButton;
@property (strong, nonatomic) UIButton *whiskeyButton;

@end

@implementation LASMainMenuViewController

- (void)loadView {
    
    self.view = [[UIView alloc] init];
    
    
    
    
    

        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blueColor];
    self.wineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.wineButton.backgroundColor = [UIColor orangeColor];
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.wineButton setTitle:@"Wine" forState:UIControlStateNormal];
   
    self.wineButton.titleLabel.textColor = [UIColor whiteColor];

    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiskeyButton setTitle:@"Whiskey" forState:UIControlStateNormal];
    self.whiskeyButton.backgroundColor = [UIColor yellowColor];
    self.title = NSLocalizedString(@"Wine or Whiskey", @"Wine or Whiskey");
    

    self.wineButton.frame = CGRectMake(50, 210.0, 100.0, 40.0);
    self.whiskeyButton.frame = CGRectMake(180, 210.0, 100.0, 40.0);
  
    [self.view addSubview:self.wineButton];
    [self.view addSubview:self.whiskeyButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(BOOL)isDeviceiPhone{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return  TRUE;
    else
        return FALSE;
}

- (void)winePressed:(UIButton *) sender {
    LASViewController *wineVC = [[LASViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
    
    
}
- (void) whiskeyPressed:(UIButton *) sender {
    LASWhiskeyViewController *whiskeyVC = [[LASWhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}

@end
