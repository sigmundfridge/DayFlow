//
//  DFMultiDatePickerViewController.m
//  DayFlow
//
//  Created by Nick Jones on 12/11/2013.
//  Copyright (c) 2013 Radius. All rights reserved.
//

#import "DFMultiDatePickerViewController.h"

@interface DFMultiDatePickerViewController ()
@property(nonatomic, strong) UIToolbar *toolbar;
@end

@implementation DFMultiDatePickerViewController

-(UIToolbar*) toolbar {
    if(!_toolbar) {
        _toolbar = [[UIToolbar alloc]init];
    }
    return _toolbar;
}

-(void) viewDidLoad {
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
    [self.delegate datePickerViewController:self didSelectDates:self.datePickerView.selectedDates];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) selectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self.datePickerView collectionView:collection didSelectItemAtIndexPath:indexPath];
}

- (void) deselectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection deselectItemAtIndexPath:indexPath animated:YES];
    [self.datePickerView collectionView:collection didDeselectItemAtIndexPath:indexPath];
}


@end
