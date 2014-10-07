//
//  ViewController.m
//  bi-ios-recognizers
//
//  Created by Dominik Vesely on 07/10/14.
//  Copyright (c) 2014 Ackee s.r.o. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) UISegmentedControl* mySegmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
    
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    
    UIPanGestureRecognizer* panReco = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    
    [v addGestureRecognizer:tapGesture];
    [v addGestureRecognizer:doubleTapGesture];
    [v addGestureRecognizer:panReco];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    [self.view addSubview:v];
    
    GraphView* graph = [[GraphView alloc] initWithFrame:CGRectMake(10, 130, CGRectGetWidth(self.view.frame)-20, 200)];
    graph.backgroundColor = [UIColor lightGrayColor];
   
    self.myGraph = graph;
    
    [self.view addSubview:graph];
    

    UISegmentedControl* sc = [[UISegmentedControl alloc] initWithItems:@[@"Red",@"Blue",@"Green"]];
    sc.center = CGPointMake(self.view.frame.size.width-sc.frame.size.width/2-10, 338+sc.frame.size.height/2);
    sc.selectedSegmentIndex = 0;
    [sc addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    self.mySegmentedControl = sc;
    [self.view addSubview:sc];
    
    
    
}

- (void) pan:(UIPanGestureRecognizer*) recognizer {
    
    CGPoint point = [recognizer translationInView:self.view];
    
    static CGPoint center;
    
    switch(recognizer.state) {
            
        case UIGestureRecognizerStateBegan: {
            center = recognizer.view.center;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            recognizer.view.center = CGPointMake(point.x + center.x, point.y + center.y);
            break;
        }
        
        default:
            break;
            
    }
    
}

- (void) oneTap:(UITapGestureRecognizer*) recognizer {
    NSLog(@"OneTap");
}

- (void) doubleTap:(UITapGestureRecognizer*) recognizer {
    NSLog(@"DoubleTap");
}

- (IBAction)stepperChanged:(UIStepper *)sender {
    self.myGraph.amp = sender.value;
    self.amplitudeLabel.text = [NSString stringWithFormat:@"%u", (unsigned)self.myGraph.amp];
    
}

- (void) segmentedAction:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.myGraph.color = [UIColor redColor];
            break;
        case 1:
            self.myGraph.color = [UIColor blueColor];
            break;
        case 2:
            self.myGraph.color = [UIColor greenColor];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
