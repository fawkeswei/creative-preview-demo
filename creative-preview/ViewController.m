//
//  ViewController.m
//  creative-preview
//
//  Created by Fawkes Wei on 2019/5/23.
//  Copyright © 2019 Forza Football. All rights reserved.
//

@import GoogleMobileAds;

#import "ViewController.h"

@interface ViewController () <GADUnifiedNativeAdLoaderDelegate, GADAdLoaderDelegate>

@property (nonatomic, strong) GADAdLoader *adLoader;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UIButton *callToActionButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adLoader = [[GADAdLoader alloc]
                     initWithAdUnitID:@"/21787483995/Fishstick_debug"
                     rootViewController:self
                     adTypes:@[kGADAdLoaderAdTypeUnifiedNative]
                     options:nil];
    self.adLoader.delegate = self;
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveUnifiedNativeAd:(GADUnifiedNativeAd *)nativeAd {
    [self.activityIndicatorView stopAnimating];
    
    self.timestampLabel.text = [NSDate date].description;
    self.titleLabel.text = nativeAd.headline;
    self.bodyLabel.text = nativeAd.body;
    [self.callToActionButton setTitle:nativeAd.callToAction forState:UIControlStateNormal];
}

- (void)adLoader:(nonnull GADAdLoader *)adLoader didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    [self.activityIndicatorView stopAnimating];
    
    self.timestampLabel.text = error.description;
    self.titleLabel.text = nil;
    self.bodyLabel.text = nil;
    [self.callToActionButton setTitle:nil forState:UIControlStateNormal];
}

- (IBAction)requestAdButtonTapped:(id)sender {
    [self.activityIndicatorView startAnimating];
    DFPRequest *adLoaderRequest = [DFPRequest request];
    adLoaderRequest.customTargeting = @{
                                        @"locale": @"fawkes_TW"
                                        };
    [self.adLoader loadRequest:adLoaderRequest];
}

- (IBAction)debugMenuTapped:(id)sender {
    GADDebugOptionsViewController *debugOptionsViewController = [GADDebugOptionsViewController debugOptionsViewControllerWithAdUnitID:@"/21787483995/Fishstick_debug"];
    [self presentViewController:debugOptionsViewController animated:YES completion:nil];
}

@end
