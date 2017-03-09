/********************************/
// CS63A - Winter 2017
// HW2: Milestone 2
// Student Name: Cyrus Goh
// SID: 20186628
/********************************/

//
//  PageContentViewController.m
//  zero
//
//  Created by 吳隆筠 on 1/27/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()
@end

@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.titleText;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
