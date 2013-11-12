#import <UIKit/UIKit.h>

@interface DFDatePickerView : UIView

- (instancetype) initWithCalendar:(NSCalendar *)calendar;

@property (nonatomic, readwrite, strong) NSDate *selectedDate;
@property (nonatomic, readwrite, strong) NSMutableArray *selectedDates;
@property (nonatomic, readwrite) BOOL multiSelect;

@end
