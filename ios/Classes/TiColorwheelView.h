#import "TiUIView.h"

@interface TiColorwheelView : TiUIView <LayoutAutosizing> {
    UIColorWell *colorwheel;
    UIColorPickerViewController *pickerController;
}

-(void)showPicker:(id)obj;

@end
