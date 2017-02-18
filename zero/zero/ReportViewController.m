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




<<<<<<< HEAD

/**
 
 Called when the activation of a session finishes.

**/
- (void)session:(WCSession *)session
activationDidCompleteWithState:(WCSessionActivationState)activationState
          error:(NSError *)error {
    NSLog(@"Session did complete with state");
}




- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    NSLog(@"didReceiveMessage with replyHandler");

    if(message){
        NSString* command = [message objectForKey:@"request"];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.replyLabel setText:command];
        });

        NSString* otherCounter = [message objectForKey:@"counter"];
        NSDictionary* response = @{@"response" : [NSString stringWithFormat:@"Message %@ received.",otherCounter]} ;

        if (replyHandler != nil) replyHandler(response);
    }
}


/**

 Standard WatchKit delegate

**/
-(void)sessionWatchStateDidChange:(nonnull WCSession *)session
{

    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];


        if(session.reachable){
            NSLog(@"session.reachable");
        }

        if(session.paired){
            if(session.isWatchAppInstalled){
                if(session.watchDirectoryURL != nil){
                }
            }
        }
    }
}


-(void)packageAndSendMessage:(NSDictionary*)request {
    if(WCSession.isSupported){

        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];

        if(session.reachable) {
            [session sendMessage:request replyHandler: ^(NSDictionary<NSString *,id> * __nonnull replyMessage) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     NSLog(@"--- replyHandler called --- %@",replyMessage);
                     NSDictionary* message = replyMessage;
                     NSString* response = message[@"response"];

                     if(response)
                         [self.replyLabel setText:response];
                     else
                         [self.replyLabel setText:@"nil"];
                 });
             }

                    errorHandler:^(NSError * __nonnull error) {

                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSLog(@"%@",error.localizedDescription);
                            [self.replyLabel setText:error.localizedDescription];
                        });
                    }
             ];
        }
        else {
            [self.replyLabel setText:@"Session Not reachable"];
        }

    }
    else {
        [self.replyLabel setText:@"Session Not Supported"];
    }
=======
- (void)sessionDidBecomeInactive:(WCSession *)session {
    NSLog(@"Session did become Inative");
>>>>>>> parent of 823946e... iOS and watchOS successfully send data and trigger haptic feedback
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
