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
    CGSize dimensions = [self currentSize];
    double toolbarHeight = 44;
    self.toolbar = [[UIToolbar alloc] init];
    self.toolbar.frame = CGRectMake(0 ,0, dimensions.width, toolbarHeight);
    self.toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    self.toolbar.items = [NSArray arrayWithObjects:save, cancel, nil];
    
    [self.view addSubview:self.toolbar];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.toolbar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:0.0 constant:44.0]];
    
}

- (CGSize) currentSize{
    return [self sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation))
        size = CGSizeMake(size.height, size.width);
    if (application.statusBarHidden == NO)
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    return size;
}


- (void)cancel:(id)sender {
    [self.delegate cancelledDatePickerViewController:self];
}

-(void) save:(id) sender {
    [self.delegate datePickerViewController:self didSelectDates:[self.datePickerView.selectedDates copy]];
}

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
