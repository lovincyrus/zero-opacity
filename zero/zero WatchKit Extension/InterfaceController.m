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

// reportBtn
//@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *reportBtn;

// session
@property (strong, nonatomic) WCSession *session;

@end


@implementation InterfaceController

-(instancetype)init {
    self = [super init];

    // check if a session is supported
    if (self) {
        if ([WCSession isSupported]) {
            self.session = [WCSession defaultSession];
            self.session.delegate = self;
            [self.session activateSession];
        }
    }
    return self;
}




// activeationDidCompleteWithState
- (void)session:(WCSession *)session
activationDidCompleteWithState:(WCSessionActivationState)activationState
          error:(NSError *)error {
}



//
//- (void)awakeWithContext:context {
//    [super awakeWithContext:context];
//    NSLog(@"Passed %@",context);
//}




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




- (IBAction)reportPressed {
    [self sendReport:@"Report"];
    NSLog(@"reportPressed");
}




// send report to reportLabel
-(void)sendReport:(NSString *)report {
    NSDictionary *applicationDict = @{@"report":report};
    [self.session updateApplicationContext:applicationDict error:nil];

    NSLog(@"sendReport");

}



@end
