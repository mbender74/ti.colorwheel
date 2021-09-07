#import "TiColorwheelViewProxy.h"
#import "TiColorwheelView.h"

@implementation TiColorwheelViewProxy


#ifndef USE_VIEW_FOR_UI_METHOD
#define USE_VIEW_FOR_UI_METHOD(methodname)\
-(void)methodname:(id)args\
{\
[self makeViewPerformSelector:@selector(methodname:) withObject:args createIfNeeded:YES waitUntilDone:NO];\
}
#endif

USE_VIEW_FOR_UI_METHOD(showPicker);

@end
