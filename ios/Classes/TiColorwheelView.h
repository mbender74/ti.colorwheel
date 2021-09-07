#import "TiUIView.h"

@interface TiColorwheelView: TiUIView {
    UIColorWell *colorwheel;
    UIColorPickerViewController *pickerController;
}

-(void)showPicker:(id)obj;

@end
