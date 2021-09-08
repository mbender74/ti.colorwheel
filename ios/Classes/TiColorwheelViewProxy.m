#import "TiColorwheelViewProxy.h"
#import "TiColorwheelView.h"

@implementation TiColorwheelViewProxy


//- (UIViewAutoresizing)verifyAutoresizing:(UIViewAutoresizing)suggestedResizing
//{
//  return suggestedResizing & ~(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
//}

#ifndef USE_VIEW_FOR_UI_METHOD
#define USE_VIEW_FOR_UI_METHOD(methodname)\
-(void)methodname:(id)args\
{\
[self makeViewPerformSelector:@selector(methodname:) withObject:args createIfNeeded:YES waitUntilDone:NO];\
}
#endif

USE_VIEW_FOR_UI_METHOD(showPicker);

//USE_VIEW_FOR_VERIFY_HEIGHT
//USE_VIEW_FOR_VERIFY_WIDTH
//
//#ifndef TI_USE_AUTOLAYOUT
//- (TiDimension)defaultAutoWidthBehavior:(id)unused
//{
//  return TiDimensionAutoSize;
//}
//- (TiDimension)defaultAutoHeightBehavior:(id)unused
//{
//  return TiDimensionAutoSize;
//}
//#endif


@end
