//
//  PanelView.m
//  bi-ios-recognizers
//
//  Created by Petr on 10.10.14.
//  Copyright (c) 2014 Ackee s.r.o. All rights reserved.
//

#import "PanelView.h"

@interface PanelView ()
@property (weak, nonatomic) UISlider* slider;
@property (weak, nonatomic) UIStepper* stepper;
@property (weak, nonatomic) UISegmentedControl* segmentedControl;
@end

@implementation PanelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor lightGrayColor];
    }
    
    UILabel* text = [[UILabel alloc]initWithFrame:CGRectZero];
    self.amplitudeLabel = text;
    [self addSubview:text];
    
    return self;
}

-(UIStepper *)stepper{
    if(!_stepper){
        UIStepper* stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
        stepper.minimumValue = 0;
        stepper.maximumValue = 15;
        stepper.stepValue = 0.5;
        [stepper addTarget:self
                    action:@selector(stepperValueChanged:)
          forControlEvents:UIControlEventTouchUpInside];
        
        _stepper = stepper;
        [self addSubview:stepper];
    }
    return _stepper;
}

- (UISlider *)slider{
    if(!_slider){
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectZero];
        slider.minimumValue = 0;
        slider.maximumValue = 15;
        [slider addTarget:self
                   action:@selector(sliderValueChanged:)
         forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:slider];
        _slider = slider;
    }
    return _slider;
}

- (UISegmentedControl *)segmentedControl{
    if(!_segmentedControl){
        //color switcher
        UISegmentedControl* sc = [[UISegmentedControl alloc] initWithItems:@[@"Red",@"Blue",@"Green"]];
        sc.selectedSegmentIndex = 0;
        [sc addTarget:self
               action:@selector(segmentedControlStateChanged:)
     forControlEvents:UIControlEventValueChanged];
        
        _segmentedControl = sc;
        [self addSubview:sc];
    }
    return _segmentedControl;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.slider.frame = CGRectMake(8, 8, CGRectGetWidth(self.bounds) - 16, 44);
    self.stepper.frame = CGRectMake(8, 8 + 44 + 8, CGRectGetWidth(self.bounds) - 16, 44);
    self.segmentedControl.frame = CGRectMake(16 + CGRectGetWidth(self.stepper.bounds), 8 + 44 + 8, CGRectGetWidth(self.bounds) - CGRectGetWidth(self.stepper.bounds) - 24, CGRectGetHeight(self.stepper.bounds));
}

- (void)stepperValueChanged:(UIStepper *)stepper
{
    if ([self.delegate respondsToSelector:@selector(panelView:stepperChanged:)]) {
        [self.delegate panelView:self
             stepperChanged:stepper];
    }
    
    self.slider.value = stepper.value;
}

- (void)sliderValueChanged:(UISlider *)slider
{
    if ([self.delegate respondsToSelector:@selector(panelView:sliderChanged:)]) {
        [self.delegate panelView:self
                   sliderChanged:slider];
    }

    self.stepper.value = slider.value;
}

- (void)segmentedControlStateChanged:(UISegmentedControl*)sender {
    if ([self.delegate respondsToSelector:@selector(panelView:segmentedControlChanged:)]) {
        [self.delegate panelView:self
         segmentedControlChanged:sender];
    }
}

@end