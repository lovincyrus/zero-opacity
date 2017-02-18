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

@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (assign) int counter;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // Configuring and activating a session
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
        NSLog(@"ReportViewController.m WCSession is supported");
    }


    self.counter = 1;
    self.counterLabel.text = [NSString stringWithFormat:@"%i",_counter];
}




/**

 Called when the session prepares to stop communicating with the current Apple Watch.

 **/
- (void)sessionDidBecomeInactive:(WCSession *)session {
    NSLog(@"Session did become Inactive");
}






/**

 Called after all data from the previous session has been delivered and communication with the Apple Watch has ended.

 **/
- (void)sessionDidDeactivate:(WCSession *)session {
    [[WCSession defaultSession] activateSession];

    NSLog(@"Session did deactivate");
}





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
 */
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
}






#pragma mark Button Actions
- (IBAction)SendMessageButtonPressed:(id)sender {
    [self.replyLabel setText:@"Sending Message ..."];

    NSDictionary* message = @{@"request":[NSString stringWithFormat:@"Message %d from the Phone",self.counter] ,@"counter":[NSString stringWithFormat:@"%d",self.counter]};

    self.counter++;
    self.counterLabel.text = [NSString stringWithFormat:@"%i",_counter];

    //Send message
    [self packageAndSendMessage:message];

}


//- (IBAction)sendMessageButtonPressed {
//    [self.replyLabel setText:@"Sending..."];
//
//    self.counter++;
//    [self setTitle:[NSString stringWithFormat:@"%i",_counter]];
//
//    NSDictionary* message = @{@"request":[NSString stringWithFormat:@"Message %d from the Phone",self.counter] ,@"counter":[NSString stringWithFormat:@"%d",self.counter]};
//
//    [self packageAndSendMessage:message];
//
//}




- (IBAction)yesButtonPressed:(id)sender {
    [self.replyLabel setText:@"Sending Yes..."];

    self.counter++;
    self.counterLabel.text = [NSString stringWithFormat:@"%i",_counter];

    //Build message and send
    [self packageAndSendMessage:@{@"request":@"Yes",@"counter":[NSString stringWithFormat:@"%i",_counter]}];
}




- (IBAction)noButtonPressed:(id)sender {

    [self.replyLabel setText:@"Sending No..."];

    self.counter++;
    self.counterLabel.text = [NSString stringWithFormat:@"%i",_counter];
    
    
    //Build message and send
    [self packageAndSendMessage:@{@"request":@"No",@"counter":[NSString stringWithFormat:@"%i",_counter]}];
}
@end
