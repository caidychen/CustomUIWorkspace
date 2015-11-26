//
//  DemoViewController.m
//  CustomUIWorkspace
//
//  Created by CHEN KAIDI on 26/11/15.
//  Copyright (c) 2015 CHEN KAIDI. All rights reserved.
//

#import "DemoViewController.h"
#import "PTCustomMenuSliderView.h"

#define Screenwidth [UIScreen mainScreen].bounds.size.width
#define Screenheight [UIScreen mainScreen].bounds.size.height
@interface DemoViewController ()<PTCustomMenuSliderViewDelegate>

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    PTCustomMenuSliderView *sliderView = [[PTCustomMenuSliderView alloc] initWithFrame:CGRectMake(0, 100, Screenwidth, 44)];
    [sliderView setAttributeWithItems:@[@"全部",@"待付款",@"待发货",@"待收货",@"全部",@"待付款",@"待发货",@"待收货"] buttonWidth:Screenwidth/4 themeColor:[UIColor redColor] idleColor:[UIColor grayColor] trackerWidth:25];
    
    sliderView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
    sliderView.layer.borderWidth = 1;
    sliderView.delegate = self;
    [self.view addSubview:sliderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sliderView:(PTCustomMenuSliderView *)sliderView didSelecteAtIndex:(NSInteger)index{
    NSLog(@"PTCustomMenuSliderView: did selecte on index:%ld",index);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
