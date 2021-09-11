#import "TiColorwheelViewProxy.h"
#import "TiColorwheelView.h"
#import <TitaniumKit/TiProxy.h>


@implementation TiColorwheelViewProxy

- (UIViewAutoresizing)verifyAutoresizing:(UIViewAutoresizing)suggestedResizing
{
  return suggestedResizing & ~(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
}


- (TiColorwheelView*)pickerView
{
    return (TiColorwheelView*)self.view;
}

-(id)showPicker:(id)args
{
    //NSLog(@"showPickerController ");

    return [self.pickerView showPickerController:args];
}
-(void)hidePicker:(id)args
{
    [self.pickerView hidePickerController:args];
}


USE_VIEW_FOR_VERIFY_HEIGHT
USE_VIEW_FOR_VERIFY_WIDTH

#ifndef TI_USE_AUTOLAYOUT
- (TiDimension)defaultAutoWidthBehavior:(id)unused
{
  return TiDimensionAutoSize;
}
- (TiDimension)defaultAutoHeightBehavior:(id)unused
{
  return TiDimensionAutoSize;
}
#endif


@end
