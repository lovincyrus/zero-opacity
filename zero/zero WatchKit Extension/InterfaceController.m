//
//  InterfaceController.m
//  zero WatchKit Extension
//
//  Created by 吳隆筠 on 1/25/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>


@interface InterfaceController() <WCSessionDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *replyLabel;

@property (assign) int counter;

//@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *reportButton;
//@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *speedLabel;

// session
//@property (strong, nonatomic) WCSession *session;
@end


@implementation InterfaceController



- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configuring and activating a session
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
        NSLog(@"InterfaceController.m WCSession is supported");

    }

    self.counter = 1;
    [self setTitle:[NSString stringWithFormat:@"%i",_counter]];
}




- (void)session:(WCSession *)session
activationDidCompleteWithState:(WCSessionActivationState)activationState
          error:(NSError *)error {
    NSLog(@"Session did complete with state");
}




- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    NSLog(@"%@ willActivate (HANDS UP)", self);
}




- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    NSLog(@"%@ didDeactivate (HANDS DOWN)", self);
}





- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message replyHandler:(void(^)(NSDictionary<NSString *, id> *replyMessage))replyHandler {
    if(message){
        NSString* command = [message objectForKey:@"request"];
        [self.replyLabel setText:command];

        NSString* otherCounter = [message objectForKey:@"counter"];
        NSDictionary* response = @{@"response" : [NSString stringWithFormat:@"Message %@ received.",otherCounter]} ;

        if (replyHandler != nil) replyHandler(response);
    }
}




-(void)packageAndSendMessage:(NSDictionary*)request {
    // check session
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];

        if(session.reachable) {
            [session sendMessage:request
                    replyHandler:
             ^(NSDictionary<NSString *,id> * __nonnull replyMessage) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     NSLog(@"--- replyHandler called --- %@",replyMessage);
                     NSDictionary* message = replyMessage;
                     NSString* response = message[@"response"];

                        // Haptic Types
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeSuccess];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeNotification];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeDirectionUp];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeDirectionDown];
                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeFailure];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeRetry];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeStart];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeStop];
//                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeClick];


                     if(response)
                         [self.replyLabel setText:response];
                     else
                         [self.replyLabel setText:@"nil"];
                 });
             }
                    errorHandler:^(NSError * __nonnull error) {

                    // Failure Haptic
                     [[WKInterfaceDevice currentDevice] playHaptic:WKHapticTypeFailure];

                        dispatch_async(dispatch_get_main_queue(), ^{
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









/**
 Standard WatchKit delegate
 */
-(void)sessionWatchStateDidChange:(nonnull WCSession *)session {
    if(WCSession.isSupported){
        WCSession* session = WCSession.defaultSession;
        session.delegate = self;
        [session activateSession];
    }
}



#pragma mark Button Actions
- (IBAction)sendMessageButtonPressed {
    [self.replyLabel setText:@"Sending..."];

    self.counter++;
    [self setTitle:[NSString stringWithFormat:@"%i",_counter]];

    NSDictionary* message = @{@"request":[NSString stringWithFormat:@"Message %d from the Phone",self.counter] ,@"counter":[NSString stringWithFormat:@"%d",self.counter]};

    [self packageAndSendMessage:message];

}




- (IBAction)yesButtonPressed {
    [self.replyLabel setText:@"Sending Yes..."];

    self.counter++;
    [self setTitle:[NSString stringWithFormat:@"%i",_counter]];

    [self packageAndSendMessage:@{@"request":@"Yes",@"counter":[NSString stringWithFormat:@"%i",_counter]}];

}



- (IBAction)noButtonPressed {
    [self.replyLabel setText:@"Sending No..."];

    self.counter++;
    [self setTitle:[NSString stringWithFormat:@"%i",_counter]];

    [self packageAndSendMessage:@{@"request":@"No",@"counter":[NSString stringWithFormat:@"%i",_counter]}];
}

@end
