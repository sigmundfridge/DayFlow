//
//  DFMultiDatePickerView.m
//  DayFlow
//
//  Created by Nick Jones on 12/11/2013.
//  Copyright (c) 2013 Radius. All rights reserved.
//

#import "DFMultiDatePickerView.h"
#import "DayFlow.h"
#import "DFDatePickerCollectionView.h"
#import "DFDatePickerDayCell.h"
#import "DFDatePickerMonthHeader.h"
#import "DFDatePickerView.h"
#import "NSCalendar+DFAdditions.h"

@interface DFMultiDatePickerView () <DFDatePickerCollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, readonly, strong) NSCalendar *calendar;
@property (nonatomic, readonly, assign) DFDatePickerDate fromDate;
@property (nonatomic, readonly, assign) DFDatePickerDate toDate;
@property (nonatomic, readonly, strong) UICollectionView *collectionView;
@property (nonatomic, readonly, strong) UICollectionViewFlowLayout *collectionViewLayout;
@end

@implementation DFMultiDatePickerView

@synthesize calendar = _calendar;
@synthesize fromDate = _fromDate;
@synthesize toDate = _toDate;
@synthesize collectionView = _collectionView;
@synthesize collectionViewLayout = _collectionViewLayout;

-(NSMutableArray*) selectedDates {
    if(!_selectedDates) {
        _selectedDates = [[NSMutableArray alloc]initWithArray:nil];
    }
    return _selectedDates;
}

- (UICollectionView *) collectionView {
    if(!_collectionView) {
        _collectionView = [super collectionView];
        _collectionView.allowsMultipleSelection = YES;
    }
    return _collectionView;
}

- (DFDatePickerDayCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	DFDatePickerDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DFDatePickerViewCellIdentifier forIndexPath:indexPath];
	
	NSDate *firstDayInMonth = [self dateForFirstDayInSection:indexPath.section];
	DFDatePickerDate firstDayPickerDate = [self pickerDateFromDate:firstDayInMonth];
	NSUInteger weekday = [self.calendar components:NSWeekdayCalendarUnit fromDate:firstDayInMonth].weekday;
	
	NSDate *cellDate = [self.calendar dateByAddingComponents:((^{
		NSDateComponents *dateComponents = [NSDateComponents new];
		dateComponents.day = indexPath.item - (weekday - 1);
		return dateComponents;
	})()) toDate:firstDayInMonth options:0];
	DFDatePickerDate cellPickerDate = [self pickerDateFromDate:cellDate];
	
	cell.date = cellPickerDate;
	cell.enabled = ((firstDayPickerDate.year == cellPickerDate.year) && (firstDayPickerDate.month == cellPickerDate.month));
	cell.selected = [self.selectedDates containsObject:cellDate];
	
	return cell;
	
}

-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath: (NSIndexPath *)indexPath {
	DFDatePickerDayCell *cell = ((DFDatePickerDayCell *)[collectionView cellForItemAtIndexPath:indexPath]);
    NSDate *date = [self.calendar dateFromComponents:[self dateComponentsFromPickerDate:cell.date]];
    [self.selectedDates removeObject:date];
    //    NSLog(@"Rem: %@", date);
    //    NSLog(@"ARRAy: %@", self.selectedDates);
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
	DFDatePickerDayCell *cell = ((DFDatePickerDayCell *)[collectionView cellForItemAtIndexPath:indexPath]);
    NSDate *date = [self.calendar dateFromComponents:[self dateComponentsFromPickerDate:cell.date]];
    [self.selectedDates addObject:date];
    //    NSLog(@"ADD: %@", self.selectedDates);
}



@end
