//
//  LASViewController.m
//  Alcolater
//
//  Created by Lisa Accardi on 9/6/14.
//  Copyright (c) 2014 com.lemonappstand. All rights reserved.
//

#import "LASViewController.h"

@interface LASViewController () <UITextFieldDelegate>


@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UIGestureRecognizer *hideKeyboardTapGestureRecognizer;
@property (weak, nonatomic) UILabel *numberOfBeersLabel;

@end

@implementation LASViewController

-(void)loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UIButton *button = [[UIButton alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
   
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    return self;
}

- (void)viewDidLoad
{
    // Calls the superclass's implementation
    [super viewDidLoad];
    
    // Set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    // Tells the text field that 'self', this is instance of LASViewController should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    if ([self isDeviceiPhone] == FALSE) {

    self.calculateButton.titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:44];
//    self.beerPercentTextField.placeholder. = [UIFont fontWithName:@"AmercianTypewriter" size:44];
        
    }

    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    // Tells 'self.beerCountSlider' that when its value changes, it shoudl call '[self -sliderValueDidChange:]'
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells 'self.calculateButton' that when a finger is lifted from the button while still inside it's bounds, to call '[self -buttonPressed:]'
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    // Tells the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tap
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
}

-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.keyboardType = UIKeyboardTypeNumberPad;
    

    if ([self isDeviceiPhone]) {
      
        CGFloat padding = 20;
        CGFloat itemWidth = viewWidth - padding - padding;
        self.beerPercentTextField.frame = CGRectMake(padding, 70, itemWidth, itemHeight);
        self.beerPercentTextField.font = [UIFont fontWithName:@"System" size:20];
        self.calculateButton.frame = CGRectMake(padding, 275, itemWidth, itemHeight);
        self.resultLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:22];
        self.resultLabel.frame = CGRectMake(padding, 190, itemWidth, itemHeight *2);
        self.beerCountSlider.frame = CGRectMake(padding, 120, itemWidth, itemHeight);
    } else {
        CGFloat padding = 70;
        CGFloat itemWidth = viewWidth - padding - padding;
        self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight *4);
        self.calculateButton.frame = CGRectMake(padding, 610, itemWidth, itemHeight *4);
        self.resultLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:44];
        self.resultLabel.frame = CGRectMake(padding, 400, itemWidth, itemHeight *4);
        self.beerCountSlider.frame = CGRectMake(padding, 190, itemWidth, itemHeight);
        self.beerPercentTextField.font = [UIFont fontWithName:@"System" size:44];
        
    }
    self.resultLabel.backgroundColor = [UIColor blueColor];
    self.resultLabel.textColor = [UIColor whiteColor];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)isDeviceiPhone{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        return  TRUE;
    else
        return FALSE;
}

- (void)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        sender.text = nil;
    }
}
- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    self.numberOfBeersLabel.text = [NSString stringWithFormat:@"%.0f", self.beerCountSlider.value];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
    
    [self.beerPercentTextField resignFirstResponder];
    
//    // first, calculate how much alcohol is in all those beers...
//    
//    int numberOfBeers = self.beerCountSlider.value;
//    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
//    
//    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
//    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
//    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
//    
//    // now, calculate the equivalent amount of wine...
//    
//    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
//    float alcoholPercentageOfWine = 0.13;  // 13% is average
//    
//    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
//    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
//    
//    // decide whether to use "beer"/"beers" and "glass"/"glasses"
//    
//    NSString *beerText;
//    
//    if (numberOfBeers == 1) {
//        beerText = NSLocalizedString(@"beer", @"singular beer");
//    } else {
//        beerText = NSLocalizedString(@"beers", @"plural of beer");
//    }
//    NSString *wineText;
//    
//    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
//        wineText = NSLocalizedString(@"glass", @"singular glass");
//    } else {
//        wineText = NSLocalizedString(@"glasses", @"plural of glass");
//    }
//    
//    // generate the result text, and display it on the label
//    
//    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
//    self.resultLabel.text = resultText;
    
}
- (void)buttonPressed:(UIButton*)sender {
    [self.beerPercentTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}

- (void)tapGestureDidFire:(id)sender {
    [self.beerPercentTextField resignFirstResponder];
}

@end
