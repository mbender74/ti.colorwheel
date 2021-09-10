#import "TiColorwheelView.h"
#import "TiColorwheelViewProxy.h"
#import "TiUIViewProxy.h"
#import "TiUtils.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "Ti2DMatrix.h"
#import <TitaniumKit/TiProxy.h>

@implementation TiColorwheelView
 
UIColor *pickerSelectedColor;
bool hasSelectedColor = NO;
bool isOpen = NO;

float roundToTwo(float num)
{
    return round(100 * num) / 100;
}

- (UIColorWell *)colorwheel
{
    if (@available(macCatalyst 14.0, *)) {
        return colorwheel;
    }
    else {
        return nil;
    }
}

- (UIView *)customview
{
    return customView;
}



- (void)initializeState
{
    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){

          // Creates and keeps a reference to the view upon initialization
            if (@available(macCatalyst 14.0, *)) {
                
//                CGRect selfFrame = self.bounds;
//                selfFrame.size.width = 44;
//                selfFrame.size.height = 44;
//                self.frame = selfFrame;
//
//                [self.proxy replaceValue:[NSNumber numberWithInteger: 44] forKey:@"height" notification:YES];
//
//                [self.proxy replaceValue:[NSNumber numberWithInteger: 44] forKey:@"width" notification:YES];

  //              colorwheel = [[UIColorWell alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 50, 50)];

                
                colorwheel = [[UIColorWell alloc] initWithFrame:self.bounds];
                
                //colorwheel = [[UIColorWell alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 50, 50)];

                colorwheel.clipsToBounds = YES;
                colorwheel.userInteractionEnabled = NO;

//                [colorwheel setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

                if ([self.proxy valueForKey:@"selectedColor"]){
                    colorwheel.selectedColor = [[TiUtils colorValue:[self.proxy valueForKey:@"selectedColor"]] _color];
                    pickerSelectedColor = colorwheel.selectedColor;
                }
                
                if ([self.proxy valueForKey:@"title"]){
                    colorwheel.title = [TiUtils stringValue:[self.proxy valueForKey:@"title"]];
                }
                if ([self.proxy valueForKey:@"supportsAlpha"]){
                    colorwheel.supportsAlpha = [TiUtils boolValue:[self.proxy valueForKey:@"supportsAlpha"] def:YES];
                }
                
//                UIView* maskView = [[UIView alloc] initWithFrame:self.bounds];
//                maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//                maskView.clipsToBounds = NO;
//
//                maskView.userInteractionEnabled = NO;
//
//               // [colorwheel addTarget:self action:@selector(pickerDidChangeSelection:) forControlEvents:UIControlEventValueChanged];
//
//                [maskView addSubview:colorwheel];
//                [self addSubview:maskView];
//
//                [self bringSubviewToFront:maskView];
//
                
                [self addSubview:colorwheel];

                
            } else {
                
                // Fallback on earlier versions
            }
    }
    else {
        
        if ([self.proxy valueForKey:@"customView"]){
            TiUIViewProxy *customViewProxy = [self.proxy valueForKey:@"customView"];
            if (customViewProxy != nil){
                customView = customViewProxy.view;
                customView.clipsToBounds = NO;
                customView.userInteractionEnabled = NO;
                //customView.frame = self.bounds;
                [self addSubview:customView];
            }
        }
        

        
      //  #define NO_SYSTEM_BUTTON = true;
//        UIView* maskView = [[UIView alloc] initWithFrame:self.bounds];
//        maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        maskView.clipsToBounds = NO;
//
//        maskView.userInteractionEnabled = NO;
//
//       // [colorwheel addTarget:self action:@selector(pickerDidChangeSelection:) forControlEvents:UIControlEventValueChanged];
//
//        [maskView addSubview:colorwheel];
//        [self addSubview:maskView];
//
//        [self bringSubviewToFront:maskView];
    }
    
    self.userInteractionEnabled = YES;

    
  [super initializeState];
}


//#ifndef TI_USE_AUTOLAYOUT
//- (UIView *)viewGroupWrapper
//{
//  if (viewGroupWrapper == nil) {
//    viewGroupWrapper = [[UIView alloc] initWithFrame:[self bounds]];
//    [viewGroupWrapper setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
//  }
//  if (colorwheel != [viewGroupWrapper superview]) {
//    if (colorwheel != nil) {
//      [viewGroupWrapper setFrame:[colorwheel bounds]];
//      [colorwheel addSubview:viewGroupWrapper];
//    } else {
//      [viewGroupWrapper removeFromSuperview];
//    }
//  }
//  return viewGroupWrapper;
//}
//#endif

//-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
//{
//
//    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
//        [TiUtils setView:colorwheel positionRect:bounds];
//    }
//
////    for (UIView *child in [self subviews])
////    {
////        [TiUtils setView:child positionRect:bounds];
////    }
//
//    [super frameSizeChanged:frame bounds:bounds];
//}


- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
        [TiUtils setView:colorwheel positionRect:bounds];
    }
    else {
        if (customView != nil){
            [TiUtils setView:customView positionRect:bounds];
        }
    }
  [super frameSizeChanged:frame bounds:bounds];
  [self setCenter:[self center]];
}
//
- (void)setCenter:(CGPoint)center
{
  CGSize ourSize = [self bounds].size;
  CGPoint ourAnchor = [[self layer] anchorPoint];
  CGFloat originx = center.x - (ourSize.width * ourAnchor.x);
  CGFloat originy = center.y - (ourSize.height * ourAnchor.y);

  center.x -= originx - floorf(originx);
  center.y -= originy - floorf(originy);

  [super setCenter:center];
}


- (void)setColor_:(id)color
{
  // Assigns the view's background color
    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
        colorwheel.selectedColor = [[TiUtils colorValue:color] _color];
    }
}
- (void)setSupportsAlpha_:(id)arg
{
  // Assigns the view's background color
    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
        colorwheel.supportsAlpha = [TiUtils boolValue:arg];
    }
}

- (void)setTitle_:(id)title
{
  // Assigns the view's background color
    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
        colorwheel.title = [TiUtils stringValue:title];
    }
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

- (CGFloat)verifyWidth:(CGFloat)suggestedWidth
{
    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
//        return 38;
        return [[self colorwheel] sizeThatFits:CGSizeZero].width;
    }
    else {
     //   return self.bounds.size.width;
        return [[self customview] sizeThatFits:CGSizeZero].width;
    }
//  return [[self colorwheel] sizeThatFits:CGSizeZero].width;
}

- (CGFloat)verifyHeight:(CGFloat)suggestedHeight
{
    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
//        return 38;
        return [[self colorwheel] sizeThatFits:CGSizeZero].height;
    }
    else {
        //return self.bounds.size.height;
        return [[self customview] sizeThatFits:CGSizeZero].height;
    }
//  return [[self colorwheel] sizeThatFits:CGSizeZero].height;
}
//#ifndef NO_SYSTEM_BUTTON
//
USE_PROXY_FOR_VERIFY_AUTORESIZING
//
//#endif

//
//-(void)pickerDidChangeSelection:(id) obj {
//    NSLog(@"pickerDidChangeSelection ");
//
//
//    [[self proxy] fireEvent:@"selection" withObject:@{
//        @"color": [self hexStringFromColor:colorwheel.selectedColor]
//    }];
//}




#pragma Public APIs

//-(void)setWidth_:(id)width_
//{
//    
//    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
//        width = TiDimensionFromObject([NSNumber numberWithInteger: 44]);
//        [self updateContentMode];
//
//    }
//    else {
//        width = TiDimensionFromObject(width_);
//    }
//}
//
//-(void)setHeight_:(id)height_
//{
//    if ([TiUtils boolValue:[self.proxy valueForKey:@"systemButton"] def:YES]){
//        height = TiDimensionFromObject([NSNumber numberWithInteger: 44]);
//        [self updateContentMode];
//
//    }
//    else {
//        height = TiDimensionFromObject(height_);
//    }
//}


-(void)hidePicker:(id)args {
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);

    if (self.hasReturnView == NO){
        TiThreadPerformOnMainThread(
         ^{
             [self->pickerController dismissViewControllerAnimated:[TiUtils boolValue:[args valueForKey:@"animated"] def:YES] completion:^{
                self.userInteractionEnabled = YES;
                hasSelectedColor = NO;
                isOpen = NO;
                pickerSelectedColor = nil;
                self.hasReturnView = NO;
            }];
         },
         YES);
    }
    else {
        
        TiThreadPerformOnMainThread(
         ^{
             [self.containerViewController windowWillClose];

             if ([TiUtils boolValue:[args valueForKey:@"animated"] def:NO] == YES){
                 //NSLog(@"hidePicker View animated");
                 [UIView animateWithDuration:0.2
                                  animations:^{
                                    self.containerViewController.view.alpha = 0.0;
                                     [self.proxy fireEvent:@"hide" withObject:nil];
                                     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                            //NSLog(@"did hidePicker View animated");

                                         [[self.containerViewController view] removeFromSuperview];
                                          [self.containerViewController windowDidClose];
                                          self.hasReturnView = NO;
                                          self.containerViewController.view = nil;
                                          self.containerViewController = nil;
                                     });
                 }];
             }
             else {
                 [self.proxy fireEvent:@"hide" withObject:nil];
                 [[self.containerViewController view] removeFromSuperview];
                 [self.containerViewController windowDidClose];
                  self.hasReturnView = NO;
                  self.containerViewController.view = nil;
                  self.containerViewController = nil;

             }

             
             
                 self.userInteractionEnabled = YES;
                 hasSelectedColor = NO;
                 isOpen = NO;
                 pickerSelectedColor = nil;
                 

         
         },
         YES);
        
        
            
    }
  //  NSLog(@"hidePicker View ");
//    [[self presentingViewController] dismissViewControllerAnimated:NO completion:nil]
}

-(id)showPicker:(id)args {
    ENSURE_SINGLE_ARG_OR_NIL(args, NSDictionary);

    if (@available(macCatalyst 14.0, *)) {
        if (isOpen == NO){

                isOpen = YES;
                self.userInteractionEnabled = NO;

                
                hasSelectedColor = NO;
                
                if ([TiUtils boolValue:[args valueForKey:@"returnView"] def:NO] == NO){
                    pickerController = [[UIColorPickerViewController alloc] init];

                    pickerController.preferredContentSize = pickerController.view.bounds.size;
            //        pickerController.modalPresentationStyle
                    
                    pickerController.modalPresentationStyle = UIModalPresentationPopover;

                    
                    UIPopoverPresentationController *thePresentationController = [pickerController popoverPresentationController];
                    
                    if (self != nil && (self.window != nil)) {
                        thePresentationController.sourceView = self;
                        thePresentationController.sourceRect = (CGRectEqualToRect(CGRectZero, CGRectZero) ? [self bounds] : CGRectZero);
                    }
                    
                }
                else {
                    pickerController = [[UIColorPickerViewController alloc] init];
                }
            
                pickerController.presentationController.delegate = self;
                pickerController.delegate = self;

                    
                    
                if ([self.proxy valueForKey:@"selectedColor"] || (colorwheel!=nil && colorwheel.selectedColor != nil)){
                    if (colorwheel!=nil && colorwheel.selectedColor != nil) {
                        pickerController.selectedColor = colorwheel.selectedColor;
                        pickerSelectedColor = pickerController.selectedColor;
                    }
                    else if ([self.proxy valueForKey:@"selectedColor"]){
                        pickerController.selectedColor = [[TiUtils colorValue:[self.proxy valueForKey:@"selectedColor"]] _color];
                        pickerSelectedColor = pickerController.selectedColor;
                    }
                    else {
                        pickerSelectedColor = nil;
                    }
                }
                if ([self.proxy valueForKey:@"title"]){
                    pickerController.title = [TiUtils stringValue:[self.proxy valueForKey:@"title"]];
                }
                if ([self.proxy valueForKey:@"supportsAlpha"]){
                    pickerController.supportsAlpha = [TiUtils boolValue:[self.proxy valueForKey:@"supportsAlpha"] def:YES];
                }
                
                
                if ([self.proxy valueForKey:@"tintColor"]){
                    
                    UINavigationBar *navBar = [[pickerController navigationController] navigationBar];
                              [navBar setTintColor:[[TiUtils colorValue:[self.proxy valueForKey:@"tintColor"]] _color]];
                    
                    [[pickerController view] setTintColor:[[TiUtils colorValue:[self.proxy valueForKey:@"tintColor"]] _color]];

                }
        //        if ([self.proxy valueForKey:@"translucent"]){
        //
        //            UINavigationBar *navBar = [[pickerController navigationController] navigationBar];
        //
        //            navBar.translucent = [TiUtils boolValue:[self.proxy valueForKey:@"translucent"] def:NO];
        //
        //        }
        //        if ([self.proxy valueForKey:@"colorPickerBackgroundColor"]){
        //            pickerController.navigationController.view.backgroundColor = [[TiUtils colorValue:[self.proxy valueForKey:@"colorPickerBackgroundColor"]] _color];
        //        }
        //
                
                
                if ([TiUtils boolValue:[args valueForKey:@"returnView"] def:NO] == NO){
                    [[TiApp app] controller].modalPresentationStyle = UIModalPresentationCurrentContext;

                        self.hasReturnView = NO;

                       [[[TiApp app] controller] presentViewController:pickerController animated:[TiUtils boolValue:[self.proxy valueForKey:@"animated"] def:YES] completion:^{
                       }];
                    return nil;
                }
                else {

                    
                    if ([args valueForKey:@"containerViewForController"]){
                        self.hasReturnView = YES;
                        self.containerViewController = [args valueForKey:@"containerViewForController"];
                        
                        pickerController.view.layer.cornerRadius = 12;
                        pickerController.view.layer.masksToBounds = true;
                        pickerController.view.clipsToBounds = YES;

                       // pickerController.preferredContentSize = self.containerViewController.view.bounds.size;

                        
                        //pickerController.view.frame = self.containerViewController.view.bounds;
                        
//                        CGRect newFrame = self.containerViewController.view.bounds;
//                        newFrame.size.height = 400;
//                        newFrame.origin.y = 200;
//
//                        pickerController.view.frame = newFrame;
//
                        
                        
                        [pickerController.view sizeToFit];
                        //pickerController.view.translatesAutoresizingMaskIntoConstraints = NO;
                        
                        [self.containerViewController.view addSubview:pickerController.view];
                       // pickerController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

                        [self.containerViewController contentsWillChange];
                        
                        return self.containerViewController;
                    }
                    else {
                        return nil;
                    }
                }
                
        //        self. presentViewController
        //
        //        [[TiApp app] showModalController:pickerController animated:[TiUtils boolValue:[self.proxy valueForKey:@"animated"] def:YES]];

        
        }
        else {
            // already open
            return nil;
        }
        
    } else {
        // Fallback on earlier versions
        return nil;
    }
  //}
}



//
//[self.proxy replaceValue:[self hexStringFromColor:colorPicker.selectedColor] forKey:@"selectedColor" notification:NO];


#pragma mark Delegates

- (void)presentationControllerDidDismiss:(UIPresentationController *)presentationController
{

    if ([self.proxy valueForKey:@"selectedColor"]){
        if (colorwheel != nil){
            if (colorwheel.selectedColor == [[TiUtils colorValue:[self.proxy valueForKey:@"selectedColor"]] _color] && hasSelectedColor == NO){
                [self.proxy fireEvent:@"cancel" withObject:nil];
            }
        }
        else {
            if (hasSelectedColor == NO){
                [self.proxy fireEvent:@"cancel" withObject:nil];
            }
        }
    }
    else{
        [self.proxy fireEvent:@"cancel" withObject:nil];
    }
    pickerSelectedColor = nil;
    isOpen = NO;
    self.userInteractionEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.proxy fireEvent:@"closed" withObject:nil];
    });
}


-(void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)colorPicker
{
    if ([self.proxy valueForKey:@"selectedColor"]){
        if (colorwheel != nil){
            if ([colorwheel.selectedColor isEqual:colorPicker.selectedColor] && hasSelectedColor == NO){
                [self.proxy fireEvent:@"cancel" withObject:nil];
            }
        }
        else {
            if ([[[TiUtils colorValue:[self.proxy valueForKey:@"selectedColor"]] _color] isEqual:colorPicker.selectedColor] && hasSelectedColor == NO){
                [self.proxy fireEvent:@"cancel" withObject:nil];
            }
        }
    }
    else {
        [self.proxy fireEvent:@"cancel" withObject:nil];
    }
    pickerSelectedColor = nil;
    isOpen = NO;
    self.userInteractionEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.proxy fireEvent:@"closed" withObject:nil];
    });
}

-(void)colorPickerViewControllerDidSelectColor:(UIColorPickerViewController *)colorPicker
{

    if ([pickerSelectedColor isEqual:colorPicker.selectedColor]){
        return;
    }
    else {
        pickerSelectedColor = colorPicker.selectedColor;
        hasSelectedColor = YES;
        if (self->colorwheel != nil){
            [self->colorwheel setSelectedColor:colorPicker.selectedColor];
        }
        [[self proxy] fireEvent:@"selection" withObject:@{
            @"color": [self hexStringFromColor:colorPicker.selectedColor]
        }];
        
        if ([self.proxy valueForKey:@"selectedColor"]){
            [self.proxy replaceValue:[self hexStringFromColor:colorPicker.selectedColor] forKey:@"selectedColor" notification:NO];
        }
        else {
            [self.proxy setValue:[self hexStringFromColor:colorPicker.selectedColor] forUndefinedKey:@"selectedColor"];
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        pickerSelectedColor = nil;
    });
}

@end

