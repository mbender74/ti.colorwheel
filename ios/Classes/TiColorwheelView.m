#import "TiColorwheelView.h"
#import "TiUtils.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"

@implementation TiColorwheelView
 
UIColor *pickerSelectedColor;

- (void)initializeState
{
  // Creates and keeps a reference to the view upon initialization
    if (@available(macCatalyst 14.0, *)) {
        colorwheel = [[UIColorWell alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.frame = colorwheel.bounds;
        colorwheel.center = self.center;
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
      //  [colorwheel addTarget:self action:@selector(pickerDidChangeSelection:) forControlEvents:UIControlEventTouchUpInside];

    } else {
        // Fallback on earlier versions
    }
  [self addSubview:colorwheel];
  [super initializeState];
}
 
- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
  // Sets the size and position of the view
  [TiUtils setView:colorwheel positionRect:bounds];
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


-(void)pickerDidChangeSelection:(id) obj {
    NSLog(@"pickerDidChangeSelection ");

    
    [[self proxy] fireEvent:@"selection" withObject:@{
        @"color": [self hexStringFromColor:colorwheel.selectedColor]
    }];
}


#pragma Public APIs

-(void)showPicker:(id) obj {
    NSLog(@"presentPickerController ");
    if (@available(macCatalyst 14.0, *)) {
        pickerController = [[UIColorPickerViewController alloc] init];
        
        pickerController.presentationController.delegate = self;

        if ([self.proxy valueForKey:@"color"]){
            pickerController.selectedColor = [[TiUtils colorValue:[self.proxy valueForKey:@"color"]] _color];
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
        if (colorwheel.selectedColor == [[TiUtils colorValue:[self.proxy valueForKey:@"color"]] _color]){
            [self.proxy fireEvent:@"cancel" withObject:nil];
        }
    }
    else if (pickerSelectedColor == nil){
        [self.proxy fireEvent:@"cancel" withObject:nil];

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
    NSLog(@"colorPickerViewControllerDidSelectColor ");

    colorwheel.selectedColor = colorPicker.selectedColor;
    pickerSelectedColor = colorPicker.selectedColor;
    [[self proxy] fireEvent:@"selection" withObject:@{
        @"color": [self hexStringFromColor:colorPicker.selectedColor]
    }];

}

@end
