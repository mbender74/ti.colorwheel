#import "TiUIView.h"
#import "TiUIViewProxy.h"
#import "TiColorwheelModule.h"
#import "TiColorwheelViewProxy.h"
#import <TitaniumKit/TiViewProxy.h>

@interface TiColorwheelView : TiUIView {    
    UIColorWell *colorwheel;
    UIColorPickerViewController *pickerController;
    BOOL touchStarted;
    UIView *customView;
#ifndef TI_USE_AUTOLAYOUT
  //In the rare case where the button is treated as a view group, we must have
  //an empty wrapper for -[parentViewForChild:]
  UIView *viewGroupWrapper;
#endif

}
@property(nonatomic,retain) TiViewProxy *containerViewController;
@property(nonatomic) bool hasReturnView;

-(id)showPickerController:(id)args;
-(void)hidePickerController:(id)args;

@end

