//
//  DFMultiDatePickerView.h
//  DayFlow
//
//  Created by Nick Jones on 12/11/2013.
//  Copyright (c) 2013 Radius. All rights reserved.
//

#import "DFDatePickerView.h"

@interface DFMultiDatePickerView : DFDatePickerView

@property (nonatomic, strong) NSMutableArray *selectedDates;

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
-(void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath: (NSIndexPath *)indexPath;

@end
