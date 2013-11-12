//
//  DFMultiDatePickerViewController.h
//  DayFlow
//
//  Created by Nick Jones on 12/11/2013.
//  Copyright (c) 2013 Radius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFDatePickerView.h"
#import "DFDatePickerViewController.h"

@interface DFMultiDatePickerViewController : UIViewController

@property (nonatomic, readonly, strong) DFDatePickerView *datePickerView;
@property (nonatomic, readwrite, weak) id<DFDatePickerViewControllerDelegate> delegate;

@end
