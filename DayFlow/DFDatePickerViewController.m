#import "DFDatePickerViewController.h"

@interface DFDatePickerViewController ()
@property (nonatomic, readonly) BOOL multipleDates;
@property(nonatomic, strong) UIToolbar *toolbar;
@end


@implementation DFDatePickerViewController
@synthesize datePickerView = _datePickerView;

-(id) init {
    self = [super init];
    if(self) {
        _multipleDates = NO;
    }
    return self;
}

-(id) initForMultipleDates:(BOOL) multiple {
    self = [self init];
    if(self) {
        _multipleDates = multiple;
    }
    return self;
}

- (void) viewDidLoad {
	[super viewDidLoad];
	[self.view addSubview:self.datePickerView];
    if(self.multipleDates) [self addMultiDateToolbar];
}

- (DFDatePickerView *) datePickerView {
	if (!_datePickerView) {
		_datePickerView = [DFDatePickerView new];
        _datePickerView.multiSelect = self.multipleDates;
		_datePickerView.frame = self.view.bounds;
		_datePickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	}
	return _datePickerView;
}

-(UIToolbar*) toolbar {
    if(!_toolbar) {
        _toolbar = [[UIToolbar alloc]init];
    }
    return _toolbar;
}

-(void) addMultiDateToolbar {
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    self.toolbar.items = [NSArray arrayWithObjects:save, cancel, nil];
}

- (void)cancel:(id)sender {
    // Dismiss View Controller
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) save:(id) sender {
    //    NSManagedObjectContext *localContext = [NSManagedObjectContext MR_defaultContext];
    //    [localContext MR_saveToPersistentStoreAndWait];
    [self.delegate datePickerViewController:self didSelectDates:[self.datePickerView.selectedDates copy]];
    [self.navigationController popViewControllerAnimated:YES];
}

/*- (void) selectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
 {
 [collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
 [self.datePickerView collectionView:collection didSelectItemAtIndexPath:indexPath];
 }
 
 - (void) deselectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
 {
 [collection deselectItemAtIndexPath:indexPath animated:YES];
 [self.datePickerView collectionView:collection didDeselectItemAtIndexPath:indexPath];
 }
 */

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self addObserver:self forKeyPath:@"datePickerView.selectedDate" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:(void *)self];
}

- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self removeObserver:self forKeyPath:@"datePickerView.selectedDate" context:(void *)self];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"datePickerView.selectedDate"]) {
		NSDate *toDate = change[NSKeyValueChangeNewKey];
		if ([toDate isKindOfClass:[NSDate class]]) {
			//	toDate might be NSNull
			[self.delegate datePickerViewController:self didSelectDate:toDate];
		}
	}
}

@end
