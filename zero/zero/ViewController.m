//
//  ViewController.m
//  zero
//
//  Created by 吳隆筠 on 1/25/17.
//  Copyright © 2017 Cyrus Goh. All rights reserved.
//


/**
 
 1.
 https://www.mapbox.com/ios-sdk/#telemetry_opt_out

 Integrate the setting directly into your app. Hook a UISwitch control up to the MGLMapboxMetricsEnabled Boolean user default, which should be YES by default. Then set MGLMapboxMetricsEnabledSettingShownInApp to YES in your app’s Info.plist file.
 
 
 2. CMD + Shift + K to clean the project
**/

#import "ViewController.h"
@import Mapbox;



@interface ViewController () <MGLMapViewDelegate>

@property (strong, nonatomic) IBOutlet MGLMapView *mapView;

@end



@implementation ViewController


// Do any additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    // set the map view's delegate property
    self.mapView.delegate = self;

    // create annotation and assign it to local variable point
    MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
    // give the point annotation a coordinate
    point.coordinate = CLLocationCoordinate2DMake(37.369168, -122.038412);
    point.title = @"Chick-fil-A";
    point.subtitle = @"550 W El Camino Real, Sunnyvale, CA 94087";

    // add the annotation to the map view
    [self.mapView addAnnotation:point];
}


// Note: You can remove this method, which lets you customize low-memory behavior.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// Tapping the annotation (display title and subtitle)
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    // Always try to show a callout when an annotation is tapped.
    return YES;
}

@end



/*

     [super viewDidLoad];
 
     MGLMapView *mapView = [[MGLMapView alloc] initWithFrame:self.view.bounds];
 
     mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
 
     // Set the map’s center coordinate and zoom level.
     [mapView setCenterCoordinate:CLLocationCoordinate2DMake(59.31, 18.06)
                        zoomLevel:9
                         animated:NO];
 
     [self.view addSubview:mapView];

*/
