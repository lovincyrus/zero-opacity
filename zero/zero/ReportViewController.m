//
//  ReportViewController.m
//  zero
//
//  Created by 吳隆筠 on 2/5/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import "ReportViewController.h"
#import <WatchConnectivity/WatchConnectivity.h>

@interface ReportViewController () <WCSessionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *reportLabel;

@end

@implementation ReportViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
}




- (void)sessionDidDeactivate:(WCSession *)session {
    // Begin the activation process for the new Apple Watch.
    [[WCSession defaultSession] activateSession];
    NSLog(@"Session did deactivate");
}




- (void)sessionDidBecomeInactive:(WCSession *)session {
    NSLog(@"Session did become Inative");
}




- (void)session:(WCSession *)session activationDidCompleteWithState:(WCSessionActivationState)activationState
          error:(NSError *)error {
    NSLog(@"Session did complete with state");
}




- (void)session:(nonnull WCSession *)session didReceiveApplicationContext:(nonnull NSDictionary<NSString *,id> *)applicationContext {
    NSString *report = [applicationContext objectForKey:@"report"];

    //Use this to update the UI instantaneously (otherwise, takes a little while)
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.reportLabel setText:[NSString stringWithFormat:@"Label: %@", report]];
    });
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
