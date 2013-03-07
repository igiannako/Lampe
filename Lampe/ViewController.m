//
//  ViewController.m
//  Lampe
//
//  Created by Ilias Giannakopoulos on 10/14/12.
//  Copyright (c) 2012 Worbb. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define degreesToRadians(x) (M_PI * x / 180.0)
#define P(x,y) CGPointMake(x, y)
#define Pb(x,y) CGPointMake(x, y)

@interface ViewController ()

@end

@implementation ViewController

@synthesize offButton, onView, onButton, offView;

-(IBAction)torchOn:(id)sender
{
    onButton.hidden = YES;
    offButton.hidden = NO;
    
    onView.hidden = NO;
    offView.hidden = YES;
    
    //--
    
    AVCaptureDevice *flashlight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([flashlight isTorchAvailable] && [flashlight isTorchModeSupported:AVCaptureTorchModeOn])
    {
        BOOL success = [flashlight lockForConfiguration:nil];
        if (success)
        {
            [flashlight setTorchMode:AVCaptureTorchModeOn];
            [flashlight unlockForConfiguration];
        }
    }
}

-(IBAction)torchOff:(id)sender
{
    onButton.hidden = NO;
    offButton.hidden = YES;
    
    onView.hidden = YES;
    offView.hidden = NO;

    AVCaptureDevice *flashlight = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([flashlight isTorchAvailable] && [flashlight isTorchModeSupported:AVCaptureTorchModeOn])
    {
        BOOL success = [flashlight lockForConfiguration:nil];
        if (success)
        {
            [flashlight setTorchMode:AVCaptureTorchModeOff];
            [flashlight unlockForConfiguration];
        }
    }
}

- (void)viewDidLoad
{
    onButton.hidden = NO;
    offButton.hidden = YES;
    
    onView.hidden = YES;
    offView.hidden = NO;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
	[trackPath moveToPoint:P(-200, -50)];
	[trackPath addCurveToPoint:P(400, 100)
				 controlPoint1:P(-100, 300)
				 controlPoint2:P(300, 200)];
	[trackPath addCurveToPoint:P(300, 100)
				 controlPoint1:P(100, 300)
				 controlPoint2:P(50, 400)];
    //[trackPath addCurveToPoint:P(290, 700)
	//			 controlPoint1:P(200, 10)
	//			 controlPoint2:P(100, 10)];
	//[trackPath addCurveToPoint:P(210, 200)
	//			 controlPoint1:P(30, 420)
	//			 controlPoint2:P(280, 300)];
	//[trackPath addCurveToPoint:P(70, 110)
	//			 controlPoint1:P(110, 80)
	//			 controlPoint2:P(110, 120)];
	[trackPath addCurveToPoint:P(-100, -120)
				 controlPoint1:P(450, 200)
				 controlPoint2:P(150, 80)];
    
    UIBezierPath *trackPath2 = [UIBezierPath bezierPath];
	[trackPath2 moveToPoint:P(-200, -50)];
	[trackPath2 addCurveToPoint:P(600, 120)
				 controlPoint1:P(300, 0)
				 controlPoint2:P(300, 80)];
	//[trackPath addCurveToPoint:P(400, 380)
	//			 controlPoint1:P(100, 300)
	//			 controlPoint2:P(200, 480)];
	[trackPath2 addCurveToPoint:P(290, 700)
				 controlPoint1:P(200, 10)
				 controlPoint2:P(100, 10)];
	//[trackPath addCurveToPoint:P(210, 200)
	//			 controlPoint1:P(30, 420)
	//			 controlPoint2:P(280, 300)];
	//[trackPath addCurveToPoint:P(70, 110)
	//			 controlPoint1:P(110, 80)
	//			 controlPoint2:P(110, 120)];
	[trackPath2 addCurveToPoint:P(-200, 0)
				 controlPoint1:P(500, 300)
				 controlPoint2:P(300, 100)];
    
	CALayer *car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 30.0, 30.0); // CGRectMake(0, 0, image.size.width, image.size.height);
	car.position = P(-100, -25);
	car.contents = (id)([UIImage imageNamed:@"ButterflyWhite.png"].CGImage);
    car.transform = CATransform3DMakeScale(0.40, 0.80, 1);
    
    CALayer *car2 = [CALayer layer];
	car2.bounds = CGRectMake(0, 0, 30.0, 30.0); // CGRectMake(0, 0, image.size.width, image.size.height);
	car2.position = P(-100, -25);
	car2.contents = (id)([UIImage imageNamed:@"ButterflyWhite.png"].CGImage);
    car2.transform = CATransform3DMakeScale(0.40, 0.80, 1);
	
    [self.view.layer addSublayer:car];
    [self.view.layer addSublayer:car2];
	
	CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	anim.path = trackPath.CGPath;
	anim.rotationMode = kCAAnimationRotateAuto;
	anim.repeatCount = HUGE_VALF;
	anim.duration = 8.0;
	[car addAnimation:anim forKey:@"race"];
    
    CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	anim2.path = trackPath2.CGPath;
	anim2.rotationMode = kCAAnimationRotateAuto;
	anim2.repeatCount = HUGE_VALF;
	anim2.duration = 8.0;
    [car2 addAnimation:anim2 forKey:@"race"];
    
    //////////////////////////////////////
    
    UIImage *image = [UIImage imageNamed:@"butterfly.png"];
	CALayer *layer = [CALayer layer];
	layer.contents = (id)image.CGImage;
	layer.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
	layer.position = CGPointMake(160, 200);
    
	// Shrink down to 50% (and 80% height) of its original value
	layer.transform = CATransform3DMakeScale(0.50, 0.80, 1);
	
	//[self.view.layer addSublayer:layer];
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animation.autoreverses = YES;
	animation.duration = 0.07;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.repeatCount = HUGE_VALF;
	[car addAnimation:animation forKey:@"pulseAnimation"];
    [car2 addAnimation:animation forKey:@"pulseAnimation"];
    
    /*
    UIBezierPath *trackPath2 = [UIBezierPath bezierPath];
	[trackPath2 addCurveToPoint:P(300, 120)
				 controlPoint1:P(320, 0)
				 controlPoint2:P(300, 80)];
	[trackPath2 addCurveToPoint:P(180, 380)
				 controlPoint1:P(100, 300)
				 controlPoint2:P(200, 480)];
	[trackPath2 addCurveToPoint:P(140, 300)
				 controlPoint1:P(0, 300)
				 controlPoint2:P(200, 220)];
	//[trackPath addCurveToPoint:P(210, 200)
	//			 controlPoint1:P(30, 420)
	//			 controlPoint2:P(280, 300)];
	//[trackPath addCurveToPoint:P(70, 110)
	//			 controlPoint1:P(110, 80)
	//			 controlPoint2:P(110, 120)];
	[trackPath2 addCurveToPoint:P(160, 25)
				 controlPoint1:P(0, 160)
				 controlPoint2:P(0, 40)];
    
	CALayer *car2 = [CALayer layer];
	car2.bounds = CGRectMake(0, 0, 30.0, 30.0);
	car2.position = Pb(160, 25);
	car2.contents = (id)([UIImage imageNamed:@"StarDoubleMid.png"].CGImage);
	[self.view.layer addSublayer:car2];
	
	CAKeyframeAnimation *anim2 = [CAKeyframeAnimation animationWithKeyPath:@"position1"];
	anim2.path = trackPath2.CGPath;
	anim2.rotationMode = kCAAnimationRotateAuto;
	anim2.repeatCount = HUGE_VALF;
	anim2.duration = 10.0;
	[car2 addAnimation:anim2 forKey:@"race1"];
    
     
    //----
     
     
    UIImage *cloudImage2 = [UIImage imageNamed:@"butterfly.png"];
    
    CALayer *cloud2 = [CALayer layer];
	cloud2.contents = (id)cloudImage2.CGImage;
	cloud2.bounds = CGRectMake(0, 0, cloudImage2.size.width, cloudImage2.size.height);
	cloud2.position = CGPointMake(self.view.bounds.size.width / 0.5,
								 cloudImage2.size.height / 0.5);
	[self.view.layer addSublayer:cloud2];
	
	CGPoint startPt2 = CGPointMake(self.view.bounds.size.width + cloud2.bounds.size.width / 3,
								  cloud2.position.y);
	CGPoint endPt2 = CGPointMake(cloud2.bounds.size.width / -3,
								cloud2.position.y);
    
	CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"position"];
	anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	anim2.fromValue = [NSValue valueWithCGPoint:startPt2];
	anim2.toValue = [NSValue valueWithCGPoint:endPt2];
	anim2.repeatCount = HUGE_VALF;
	anim2.duration = 10.0;
	[cloud2 addAnimation:anim2 forKey:@"position"];
    */
    //
    
}

- (void)viewWillAppear
{
    onButton.hidden = NO;
    offButton.hidden = YES;
    
    onView.hidden = YES;
    offView.hidden = NO;
}

- (void)viewDidUnload
{
    onButton.hidden = NO;
    offButton.hidden = YES;
    
    onView.hidden = YES;
    offView.hidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
