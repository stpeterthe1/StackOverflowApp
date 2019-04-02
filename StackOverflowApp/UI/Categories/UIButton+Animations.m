//
//  UIButton+Animations.m
//  StackOverflowApp
//
//  Created by Denis Rudoy on 4/1/19.
//  Copyright © 2019 Wheels. All rights reserved.
//

#import "UIButton+Animations.h"

@implementation UIButton(Animations)

-(void)shake{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.3;
    animation.values = @[ @(-8), @(6), @(-4), @(2), @(0)];
    [self.layer addAnimation:animation forKey:@"shake"];
}

@end
