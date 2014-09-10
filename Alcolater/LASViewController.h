//
//  LASViewController.h
//  Alcolater
//
//  Created by Lisa Accardi on 9/6/14.
//  Copyright (c) 2014 com.lemonappstand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LASViewController : UIViewController

@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;

-(void)buttonPressed:(UIButton *)sender;

@end
