#import "TiColorwheelView.h"
#import "TiUtils.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "Ti2DMatrix.h"

@implementation TiColorwheelView
 
UIColor *pickerSelectedColor;
bool scaled = NO;

float roundToTwo(float num)
{
    return round(100 * num) / 100;
}

- (UIColorWell *)colorwheel
{
 
  return colorwheel;
}


- (void)initializeState
{
    
    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){

    
    
  // Creates and keeps a reference to the view upon initialization
    if (@available(macCatalyst 14.0, *)) {
        
        CGFloat viewHeight;
        id viewProxyHeight = [self.proxy valueForUndefinedKey:@"height"];
        if (viewProxyHeight && ![viewProxyHeight isEqual:@"SIZE"]) {
            viewHeight = ceil([TiUtils dimensionValue:viewProxyHeight].value);
        }
        else if (viewProxyHeight && [viewProxyHeight isEqual:@"SIZE"]) {
            viewHeight = 38;
        }
        else {
            viewHeight = 38;
        }
        
        
        
        colorwheel = [[UIColorWell alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 38, 38)];


        
      //  [colorwheel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

       // colorwheel = [[UIColorWell alloc] init];

        
       // colorwheel = (UIColorWell *)[[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        
//        [self.proxy replaceValue:[NSNumber numberWithFloat:colorwheel.frame.size.width] forKey:@"width" notification:YES];
//        [self.proxy replaceValue:[NSNumber numberWithFloat:colorwheel.frame.size.height] forKey:@"height" notification:YES];

        
      //  colorwheel = [[UIColorWell alloc] initWithFrame:self.bounds];
     //   colorwheel = [[UIColorWell alloc] init];

        
        //self.frame = colorwheel.bounds;
        if ([self.proxy valueForKey:@"color"]){
            colorwheel.selectedColor = [[TiUtils colorValue:[self.proxy valueForKey:@"color"]] _color];
            pickerSelectedColor = colorwheel.selectedColor;
        }
        
        if ([self.proxy valueForKey:@"title"]){
            colorwheel.title = [TiUtils stringValue:[self.proxy valueForKey:@"title"]];
        }
        if ([self.proxy valueForKey:@"supportsAlpha"]){
            colorwheel.supportsAlpha = [TiUtils boolValue:[self.proxy valueForKey:@"supportsAlpha"] def:YES];
        }

        colorwheel.userInteractionEnabled = NO;
       // [colorwheel addTarget:self action:@selector(pickerDidChange:) forControlEvents:UIControlStateSelected];

        
        
//
//        [self.proxy layoutProperties]->width.type = poWidth.type;
//
//
//        LayoutConstraint *viewLayout = [self.proxy layoutProperties];
//        switch (viewLayout->height.type) {
//        case TiDimensionTypeDip:
//          size += viewLayout->height.value;
//          break;
//        case TiDimensionTypeAuto:
//          size += [viewProxy autoHeightForSize:[tableview bounds].size];
//          break;
//        default:
//          size += DEFAULT_SECTION_HEADERFOOTER_HEIGHT;
//          break;
//        }
//
//
        
        
//        CGRect wheelframe = self.bounds;
//        wheelframe.size.height = viewHeight;
//        wheelframe.size.width = viewHeight;
//        self.bounds = wheelframe;
        
        
       // colorwheel.clipsToBounds = YES;
       // colorwheel.translatesAutoresizingMaskIntoConstraints = NO;

        

        
        CGFloat factor = roundToTwo(viewHeight / colorwheel.frame.size.height);

        
//        NSLog(@"factor %f",factor);
//        NSLog(@"self.bounds.size.width %f",viewHeight);

        
//        NSArray *subviews = [colorwheel subviews];
//        if ([subviews count] > 0) {
//          // Obfuscate private class name
//          for (UIView *view in subviews) {
//              NSLog(@"[colorwheel for subviews].className %@",view.className);
//
//              //view.frame = colorwheel.bounds;
//          }
//        }
        
//
//
//
//        NSLayoutConstraint * c_1 =[NSLayoutConstraint constraintWithItem:self
//                                                               attribute:NSLayoutAttributeRight
//                                                               relatedBy:NSLayoutRelationEqual
//                                                                  toItem:colorwheel
//                                                               attribute:NSLayoutAttributeRight
//                                                              multiplier:1.0 constant:100];
//        NSLayoutConstraint * c_2 =[NSLayoutConstraint constraintWithItem:self
//                                                               attribute:NSLayoutAttributeTop
//                                                               relatedBy:NSLayoutRelationEqual
//                                                                  toItem:colorwheel
//                                                               attribute:NSLayoutAttributeTop
//                                                              multiplier:1.0 constant:-1*100];
//        NSLayoutConstraint * equal_w = [NSLayoutConstraint constraintWithItem:colorwheel
//                                                                    attribute:NSLayoutAttributeWidth
//                                                                    relatedBy:NSLayoutRelationEqual
//                                                                       toItem:nil
//                                                                    attribute:0
//                                                                   multiplier:1.0
//                                                                     constant:100];
//        NSLayoutConstraint * equal_h = [NSLayoutConstraint constraintWithItem:colorwheel
//                                                                    attribute:NSLayoutAttributeHeight
//                                                                    relatedBy:NSLayoutRelationEqual
//                                                                       toItem:nil
//                                                                    attribute:0
//                                                                   multiplier:1.0
//                                                                     constant:100];
//       // [self addConstraints:@[c_1,c_2]];
//        [colorwheel addConstraints:@[equal_w,equal_h]];
//
//
        
        
       // NSLog(@"[colorwheel subviews].firstObject.className %@",[colorwheel subviews].firstObject);
        colorwheel.center = self.center;
       // [TiUtils setView:colorwheel positionRect:self.bounds];
       // [colorwheel layoutSubviews];


        [self addSubview:colorwheel];
        
     //   if (viewHeight > 1){
            CGRect oldFrame = colorwheel.frame;
        
         //   NSLog(@"[colorwheel origin.x %f",colorwheel.bounds.origin.x);
         //   NSLog(@"[colorwheel origin.y %f",colorwheel.bounds.origin.y);

           
            if (factor > 1){
                scaled = YES;
                colorwheel.transform = CGAffineTransformMakeScale(factor, factor);
                CGRect newFrame = colorwheel.frame;

                CGFloat newFrameSize = ceilf(-(newFrame.size.width / 2) - (((newFrame.size.width / 2) - oldFrame.size.width)*2));
                
                int intnewFrameSize = (int) newFrameSize;
                
                if ( intnewFrameSize % 2 == 0) {
                  // remainder 0
                } else
                {
                    intnewFrameSize = intnewFrameSize - 1;
                }
                
                newFrame.origin.x = intnewFrameSize;
                newFrame.origin.y = intnewFrameSize;
//
//                NSLog(@"[colorwheel roundToTwo(oldFrame.origin.x/factor) %f",roundToTwo(oldFrame.origin.x/factor));

                colorwheel.frame = newFrame;
                
               // NSLog(@"[colorwheel after origin.x %f",colorwheel.frame.origin.x);
              //  NSLog(@"[colorwheel after origin.y %f",colorwheel.frame.origin.y);
            }
    
           
      //  }
//        newFrame.origin.x =
        
//        if (factor > 1){
//           // colorwheel.center = CGPointMake(0.5, 0.5);
//           // CGPoint center = colorwheel.center;
//           [colorwheel layer].anchorPoint = CGPointMake([TiUtils floatValue:[self.proxy valueForKey:@"anchor"]], [TiUtils floatValue:[self.proxy valueForKey:@"anchor"]]);
//
//           // colorwheel.translatesAutoresizingMaskIntoConstraints = YES;
//
//           // [self setAnchorPoint:CGPointMake(0.0, 0.0) forView:colorwheel];
//
//           // factor = factor + 0.2;
//
//            NSLog(@"factor %f",factor);
//
//            CGFloat sx = factor;
//            CGFloat sy = factor;
//            CGFloat w = colorwheel.frame.size.width;
//            CGFloat h = colorwheel.frame.size.height;
//
//
//            NSLog(@"w %f",w);
//
//
//            CGFloat goodSx = ceilf(w * sx)/w;
//            CGFloat goodSy = ceilf(h * sx)/h;
//
//            CGAffineTransform t = CGAffineTransformMakeScale(goodSx, goodSy);
////
////            //CGAffineTransform transform = CGAffineTransformMakeTranslation(0.0f, -shift);
////          //  Ti2DMatrix * matrix = [[Ti2DMatrix alloc] initWithMatrix:t];
////
////
////           // CGAffineTransform t = CGAffineTransformMakeScale(goodSx, goodSy);
////
////           // CGAffineTransform translate = CGAffineTransformMakeTranslation(-goodSx, -goodSy);
////            //colorwheel.transform = CGAffineTransformConcat(translate, t);
////            colorwheel.transform = t;
////
////            NSLog(@"transform ");
////          //  [self setTransform_:matrix];
////
////
////           // colorwheel.transform = [self scaleTransform:colorwheel scaledBy:CGPointMake(factor, factor)  aroundAnchorPoint:CGPointMake(0.0, 0.0) ];
////
////            colorwheel.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
////           // [colorwheel layer].anchorPoint = CGPointMake(0.0, 0.0);
//
//        }

        
        
//        self.frame = colorwheel.bounds;

//        colorwheel.sizeToFit
        
        
       // colorwheel.center = CGPointMake(selfbounds.size.width, selfbounds.size.height);

        
    } else {
        // Fallback on earlier versions
    }
  }
  [super initializeState];
}

//- (void)layoutSubviews
//{
//    CGAffineTransform transform = CGAffineTransformMakeScale(1.0/1.2, 1.0/1.2);
//
//    for(UIView *view in self.subviews){
//        view.transform = transform;
//    }
//}

//-(CGAffineTransform)scaleTransform:(UIView *)view scaledBy:(CGPoint)scale  aroundAnchorPoint:(CGPoint )relativeAnchorPoint {
//
//    CGRect bounds = view.bounds;
//    
//    CGPoint anchorPoint = CGPointMake(bounds.size.width * relativeAnchorPoint.x, bounds.size.height * relativeAnchorPoint.y);
//    
//    
//    CGAffineTransform t = CGAffineTransformMakeScale(scale.x, scale.y);
//    
//    
//    CGAffineTransform translate = CGAffineTransformMakeTranslation(anchorPoint.x, anchorPoint.y);
//    
//    CGAffineTransform scaleTrans = CGAffineTransformMakeScale(scale.x, scale.y);
//    
//    CGAffineTransform translate2 = CGAffineTransformMakeTranslation(-anchorPoint.x, -anchorPoint.y);
//
//    CGAffineTransform transformView =  CGAffineTransformConcat(translate, scaleTrans);
//    CGAffineTransform transformView2 =  CGAffineTransformConcat(transformView, translate2);
//
//    return transformView2;
//    
//}
//
//
//
//-(void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
//{
//    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
//                                   view.bounds.size.height * anchorPoint.y);
//    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
//                                   view.bounds.size.height * view.layer.anchorPoint.y);
//
//    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
//    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
//
//    CGPoint position = view.layer.position;
//
//    position.x -= oldPoint.x;
//    position.x += newPoint.x;
//
//    position.y -= oldPoint.y;
//    position.y += newPoint.y;
//
//    view.layer.position = position;
//    view.layer.anchorPoint = anchorPoint;
//}
//

//- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
//{
//  [super frameSizeChanged:frame bounds:bounds];
//  [self setCenter:[self center]];
//}
//
//- (void)setCenter:(CGPoint)center
//{
//  CGSize ourSize = [self bounds].size;
//  CGPoint ourAnchor = [[self layer] anchorPoint];
//  CGFloat originx = center.x - (ourSize.width * ourAnchor.x);
//  CGFloat originy = center.y - (ourSize.height * ourAnchor.y);
//
//  center.x -= originx - floorf(originx);
//  center.y -= originy - floorf(originy);
//
//  [super setCenter:center];
//}


- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
  //  NSLog(@"frameSizeChanged ");
    if (scaled == NO){
        [TiUtils setView:colorwheel positionRect:bounds];
    }
}

- (void)setColor_:(id)color
{
  // Assigns the view's background color
    colorwheel.selectedColor = [[TiUtils colorValue:color] _color];
}
- (void)setSupportsAlpha_:(id)arg
{
  // Assigns the view's background color
    colorwheel.supportsAlpha = [TiUtils boolValue:arg];
}

- (void)setTitle_:(id)title
{
  // Assigns the view's background color
    colorwheel.title = [TiUtils stringValue:title];
}


// CREDITS: http://stackoverflow.com/a/26341062/5537752
- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}

//- (CGFloat)verifyWidth:(CGFloat)suggestedWidth
//{
//  return [[self colorwheel] sizeThatFits:CGSizeZero].width;
//}
//
//- (CGFloat)verifyHeight:(CGFloat)suggestedHeight
//{
//  return [[self colorwheel] sizeThatFits:CGSizeZero].height;
//}
//
//USE_PROXY_FOR_VERIFY_AUTORESIZING


//-(void)pickerDidChangeSelection:(id) obj {
//    NSLog(@"pickerDidChangeSelection ");
//
//
//    [[self proxy] fireEvent:@"selection" withObject:@{
//        @"color": [self hexStringFromColor:colorwheel.selectedColor]
//    }];
//}


-(void)pickerDidChange:(id) obj {
   // NSLog(@"pickerDidChangeSelection ");
}


#pragma Public APIs

-(void)showPicker:(id) obj {
   // NSLog(@"presentPickerController ");
    if (@available(macCatalyst 14.0, *)) {
        pickerController = [[UIColorPickerViewController alloc] init];
        
        pickerController.presentationController.delegate = self;

        if ([self.proxy valueForKey:@"color"]){
            pickerController.selectedColor = [[TiUtils colorValue:[self.proxy valueForKey:@"color"]] _color];
            pickerSelectedColor = pickerController.selectedColor;
        }
        if ([self.proxy valueForKey:@"title"]){
            pickerController.title = [TiUtils stringValue:[self.proxy valueForKey:@"title"]];
        }
        if ([self.proxy valueForKey:@"supportsAlpha"]){
            pickerController.supportsAlpha = [TiUtils boolValue:[self.proxy valueForKey:@"supportsAlpha"] def:YES];
        }
        
        pickerController.delegate = self;
        
        
        [[TiApp app] showModalController:pickerController animated:[TiUtils boolValue:[self.proxy valueForKey:@"animated"] def:YES]];

        
    } else {
        // Fallback on earlier versions
    }
}







#pragma mark Delegates

- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController
{
  //  NSLog(@"[ERROR] presentationControllerDidDismiss because cancel :");

    if ([self.proxy valueForKey:@"color"]){
        if (colorwheel != nil){
            if (colorwheel.selectedColor == [[TiUtils colorValue:[self.proxy valueForKey:@"color"]] _color]){
                [self.proxy fireEvent:@"cancel" withObject:nil];
            }
        }
        if (pickerSelectedColor == nil){
            [self.proxy fireEvent:@"cancel" withObject:nil];
        }
    }
    else{
        if (pickerSelectedColor == nil){
            [self.proxy fireEvent:@"cancel" withObject:nil];
        }
    }
    [self.proxy fireEvent:@"closed" withObject:nil];

}


-(void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)colorPicker
{
    if ([self.proxy valueForKey:@"color"]){
        if (colorPicker.selectedColor == [[TiUtils colorValue:[self.proxy valueForKey:@"color"]] _color]){
            [self.proxy fireEvent:@"cancel" withObject:nil];
        }
    }
    else if (pickerSelectedColor == nil){
        [self.proxy fireEvent:@"cancel" withObject:nil];
    }

    [self.proxy fireEvent:@"closed" withObject:nil];
}

-(void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)colorPicker
{
    if ([pickerSelectedColor isEqual:colorPicker.selectedColor]){
       // NSLog(@"colorPickerViewControllerDidSelectColor SAME ");

        if (colorwheel != nil){
            colorwheel.selectedColor = colorPicker.selectedColor;
        }
        pickerSelectedColor = colorPicker.selectedColor;
        
        [[self proxy] fireEvent:@"selection" withObject:@{
            @"color": [self hexStringFromColor:colorPicker.selectedColor]
        }];
        
        return;
    }
    else {
      //  NSLog(@"colorPickerViewControllerDidSelectColor ");

        if (colorwheel != nil){
            colorwheel.selectedColor = colorPicker.selectedColor;
        }
        pickerSelectedColor = colorPicker.selectedColor;
        
        [[self proxy] fireEvent:@"selection" withObject:@{
            @"color": [self hexStringFromColor:colorPicker.selectedColor]
        }];
    }

}

@end
