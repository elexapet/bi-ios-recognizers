//
//  PanelView.h
//  bi-ios-recognizers
//
//  Created by Petr on 10.10.14.
//  Copyright (c) 2014 Ackee s.r.o. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PanelViewDelegate;

@interface PanelView : UIView

@property (weak, nonatomic) id<PanelViewDelegate> delegate;
@property (weak, nonatomic) UILabel *amplitudeLabel;

@end

@protocol PanelViewDelegate <NSObject>

@property (nonatomic, readonly) double defaultAmp;
- (void)panelView:(PanelView *)panelView sliderChanged:(UISlider *)slider;
- (void)panelView:(PanelView *)panelView stepperChanged:(UIStepper *)stepper;
- (void)panelView:(PanelView *)panelView segmentedControlChanged:(UISegmentedControl *)sc;

@end
