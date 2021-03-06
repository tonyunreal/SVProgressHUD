//
//  SVProgressHUDViewController.m
//  SVProgressHUD
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"

@implementation ViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma mark - Notification Methods Sample

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
}

- (void)handleNotification:(NSNotification *)notif
{
    NSLog(@"Notification recieved: %@", notif.name);
    NSLog(@"Status user info key: %@", [notif.userInfo objectForKey:SVProgressHUDStatusUserInfoKey]);
}


#pragma mark - Show Methods Sample

- (void)show {
	[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

- (void)showWithStatus {
	[SVProgressHUD showWithStatus:@"Doing Stuff" maskType:SVProgressHUDMaskTypeBlack];
}

static float progress = 0.0f;

- (IBAction)showWithProgress:(id)sender {
    progress = 0.0f;
    [SVProgressHUD setCancelHandler:^{
        progress = 1.0f;
    }];
    [SVProgressHUD showProgress:0 status:@"Loading" maskType:SVProgressHUDMaskTypeBlack];
    [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
}

- (void)increaseProgress {
    if (progress >= 1.0f)
    {
        return;
    }
    
    progress+=0.1f;
    [SVProgressHUD showProgress:progress status:@"Loading" maskType:SVProgressHUDMaskTypeBlack];

    if(progress < 1.0f)
        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3f];
    else
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.4f];
}


#pragma mark - Dismiss Methods Sample

- (void)dismiss {
	[SVProgressHUD dismiss];
}

- (IBAction)dismissInfo{
    [SVProgressHUD showInfoWithStatus:@"Useful Information." maskType:SVProgressHUDMaskTypeBlack];

    // uncomment the line below to test hud delay for Chinese characters
    //[SVProgressHUD showInfoWithStatus:@"这里有些信息需要您的关注，请仔细阅读。" maskType:SVProgressHUDMaskTypeBlack];
}

- (void)dismissSuccess {
    [SVProgressHUD showSuccessWithStatus:@"Great Success!" maskType:SVProgressHUDMaskTypeBlack];
    
    // uncomment the line below to test hud delay for Chinese characters
	//[SVProgressHUD showSuccessWithStatus:@"操作完成!" maskType:SVProgressHUDMaskTypeBlack];
}

- (void)dismissError {
    [SVProgressHUD showErrorWithStatus:@"Failed with Error" maskType:SVProgressHUDMaskTypeBlack];
    
    // uncomment the line below to test hud delay for Chinese characters
	//[SVProgressHUD showErrorWithStatus:@"操作失败了，这里是错误原因。" maskType:SVProgressHUDMaskTypeBlack];
}

@end
