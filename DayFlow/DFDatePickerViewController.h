#import <UIKit/UIKit.h>
#import "DFDatePickerView.h"

@class DFDatePickerViewController;
@protocol DFDatePickerViewControllerDelegate

- (void) datePickerViewController:(DFDatePickerViewController *)controller didSelectDate:(NSDate *)date;
- (void) datePickerViewController:(DFDatePickerViewController *)controller didSelectDates:(NSArray *)dates;

@end

@interface DFDatePickerViewController : UIViewController

@property (nonatomic, readonly, strong) DFDatePickerView *datePickerView;
@property (nonatomic, readwrite, weak) id<DFDatePickerViewControllerDelegate> delegate;

-(id) initForMultipleDates:(BOOL) multiple;

@end
