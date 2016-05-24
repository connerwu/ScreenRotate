//
//  ViewController.m
//  ScreenRotate
//
//  Created by wackosix on 16/5/24.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL fullScreened; //标记是不是已经是全屏
@property (nonatomic, assign) BOOL autoRotate; //是否自动旋转

@end

@implementation ViewController


- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
}


- (IBAction)autoRotateSwitch:(UISwitch *)sender {
    
    self.autoRotate = sender.on;
    
}
- (IBAction)rotateLeft:(id)sender {
    
    [self rotateOrientation:UIInterfaceOrientationLandscapeLeft];
}

- (IBAction)rotateRight:(id)sender {
    [self rotateOrientation:UIInterfaceOrientationLandscapeRight];
    
}
- (IBAction)portrait:(id)sender {
    
    [self rotateOrientation:UIInterfaceOrientationPortrait];
}
- (IBAction)upsideDown:(id)sender {
    [self rotateOrientation:UIInterfaceOrientationPortraitUpsideDown];
    
}
- (void)rotateOrientation:(UIInterfaceOrientation)orientation {
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:YES];
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:orientation] forKey:@"orientation"];
}


#pragma mark Rotate
/**
 *  旋转屏幕的时候，是否自动旋转子视图，NO的话不会旋转控制器的子控件
 *
 */
- (BOOL)shouldAutorotate
{
    return self.autoRotate;
}

/**
 *  当前控制器支持的旋转方向
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationPortraitUpsideDown ;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if (self.fullScreened)
        return UIInterfaceOrientationPortrait;
    return UIInterfaceOrientationLandscapeRight;
}


//按钮控制视频全屏逻辑
- (IBAction)rotate:(id)sender {
    
    self.fullScreened = !self.fullScreened;
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    if (!self.fullScreened) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
        [self viewDidLayoutSubviews];
        return;
    }
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    
    if ([[[UIDevice currentDevice] valueForKey:@"orientation"] isEqualToValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight]]) {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationPortrait] forKey:@"orientation"];
    }
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight] forKey:@"orientation"];
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
    [self viewDidLayoutSubviews];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fullScreened = false;
    self.autoRotate = false;
}

@end

