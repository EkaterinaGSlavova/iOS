//
//  GradientView.m
//  StoreSearch
//
//  Created by Ekaterina on 9/18/15.
//  Copyright (c) 2015 Ekaterina. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //1. create two C-style arrays that contain the “color stops” for the gradient.
    const CGFloat components[8] = {0.0f, 0.0f, 0.0f, 0.3f, 0.0f, 0.0f, 0.0f, 0.7f};
    const CGFloat locations[2] = {0.0f, 1.0f};
    
    //2. Creating the gradient
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, 2);
    CGColorSpaceRelease(space);
    
    //3. Setting the dimentions for the drawing. By doing self.bound the dimentions are not harcoded
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGPoint point = CGPointMake(x, y);
    CGFloat radius = MAX(x, y);
    
    //4. Draw the figure
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(context, gradient, point, 0, point, radius, kCGGradientDrawsAfterEndLocation);
    
    //5. Release the gradient
    CGGradientRelease(gradient);
    
}

- (void)dealloc {
    NSLog(@"dealloc %@", self);
}
@end
