# MultiDayFlow

iOS Date Picker + Infinite Scrolling + multiple day selection

## Play

A (unfinished) version of Evadne Wu's Dayflow (Look at the [Sample App](https://github.com/evadne/DayFlow-Sample)) that allows multiple days to be selected.

## Use

For single day selection see [Evadne Wu's page](https://github.com/evadne/DayFlow). This is my ongoing attempt to add multiple day functionality. There is a new protocol method 
	- (void) datePickerViewController:(DFDatePickerViewController *)controller didSelectDates:(NSArray *)dates;

To initialise the controller for multiple selection, use:
	DFDatePickerViewController *picker = [[DFDatePickerViewController alloc ] initForMultipleDates:YES];

Otherwise for single date selection you can init it the normal way or with 
	DFDatePickerViewController *picker = [[DFDatePickerViewController alloc ] initForMultipleDates:NO];

This is definitely a WORK IN PROGRESS.

## Licensing

This project is in the public domain.  You can embed it in works for hire or use it for evil.  Attribution by linking to the [project page](https://github.com/evadne/DayFlow) and chocolate delivery is appreciated.

## Credits

*	[Evadne Wu](http://radi.ws)
*   [Nick Jones](http://sigfrid.co.uk)
