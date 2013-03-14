//
//  EditMailViewController.m
//  myjam
//
//  Created by ME-Tech Mac User 2 on 2/19/13.
//  Copyright (c) 2013 me-tech. All rights reserved.
//

#import "EditMailViewController.h"
#import "UJliteProfileViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "CustomAlertView.h"
#import "ASIWrapper.h"
#import "FontLabel.h"

#define kFrameHeightOnKeyboardUp 499.0f

@interface EditMailViewController ()

@end

@implementation EditMailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //TITLE
        self.title = @"Settings";
        FontLabel *titleView = [[FontLabel alloc] initWithFrame:CGRectZero fontName:@"jambu-font.otf" pointSize:22];
        titleView.text = self.title;
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.backgroundColor = [UIColor clearColor];
        titleView.textColor = [UIColor whiteColor];
        [titleView sizeToFit];
        self.navigationItem.titleView = titleView;
        [titleView release];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init scrollview
    self.scroller = (TPKeyboardAvoidingScrollView *)self.view;
    [self.scroller setContentSize:CGSizeMake(self.contentView.frame.size.width, kFrameHeightOnKeyboardUp+44)];
    [self.scroller addSubview:self.contentView];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"city :%@",self.city);
    //set textField data
    self.addressTextField.text = self.address;
    self.cityTextField.text = self.city;
    self.postcodeTextField.text = self.postcode;
    if (![self.state isKindOfClass:[NSNull class]]) {
        self.stateTextField.text = self.state;
    } else {
        self.stateTextField.text = @"";
    }
    if (![self.country isKindOfClass:[NSNull class]]) {
        self.countryTextField.text = self.country;
    } else {
        self.countryTextField.text = @"";
    }

    // textfield delegate
    self.addressTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.postcodeTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.countryTextField.delegate = self;
    
    self.contentView.frame = CGRectMake(0, 0.0f, self.contentView.frame.size.width, kFrameHeightOnKeyboardUp+44);
    
    [self.saveChangeButton addTarget:self action:@selector(checkSaveChangeAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton addTarget:self action:@selector(deleteAddress) forControlEvents:UIControlEventTouchUpInside];
    
    self.dictStates = [[NSMutableDictionary alloc] init];
    self.dictCountries = [[NSMutableDictionary alloc] init];
    // Setup pickerview
    self.statePickerView = [[UIPickerView alloc] init];
    self.countryPickerView = [[UIPickerView alloc] init];
    // Set pickerview delegate
    self.statePickerView.delegate = self;
    self.countryPickerView.delegate = self;
    self.statePickerView.dataSource = self;
    self.countryPickerView.dataSource = self;
    // Set the picker's frame.
    self.statePickerView.showsSelectionIndicator = YES;
    self.countryPickerView.showsSelectionIndicator = YES;
    // Set tag
    self.statePickerView.tag = 1;
    self.countryPickerView.tag = 2;
    
    // Toolbar for pickerView
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolbar.barStyle = UIBarStyleBlack;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked:)];
    
    UIBarButtonItem *spacer = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    
    [toolbar setItems:[NSArray arrayWithObjects: spacer, doneButton, nil]];
    
    self.stateTextField.inputAccessoryView = toolbar;
    self.countryTextField.inputAccessoryView = toolbar;
    //set list of pickerView
    self.stateTextField.inputView = self.statePickerView;
    self.countryTextField.inputView = self.countryPickerView;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (![self.stateArray count] || ![self.countryArray count]) {
        [self setupCategoryList];
    }
    NSLog(@"vda");
}

- (void)setupCategoryList
{
    // Init the category data
    [self getStateCountryFromAPI];
    // Set list for pickerView
    NSLog(@"%@", self.dictStates);
    if (![self.dictStates isEqual: [NSNull null]]) {
    self.stateArray = [[NSMutableArray alloc] initWithArray:[self.dictStates allKeys]];
    [self.stateArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    self.countryArray = [[NSMutableArray alloc] initWithArray:[self.dictCountries allKeys]];
    [self.countryArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    
}

#pragma mark -
#pragma mark PickerView action button

- (void)getStateCountryFromAPI
{
    NSString *flag = @"GET_STATES_COUNTRY";
    NSString *urlString = [NSString stringWithFormat:@"%@/api/settings_jambulite_profile.php?token=%@",APP_API_URL,[[[NSUserDefaults standardUserDefaults] objectForKey:@"tokenString"]mutableCopy]];
    
    NSString *dataContent = [NSString stringWithFormat:@"{\"flag\":\"%@\"}",flag];
    
    NSString *response = [ASIWrapper requestPostJSONWithStringURL:urlString andDataContent:dataContent];
    NSDictionary *resultsDictionary = [[response objectFromJSONString] mutableCopy];
    NSDictionary *states;
    NSDictionary *countries;
    NSLog(@"resp: %@",response);
    if([resultsDictionary count])
    {
        NSString *status = [resultsDictionary objectForKey:@"status"];
        
        if ([status isEqualToString:@"ok"])
        {
            states = [resultsDictionary objectForKey:@"states2"];
            for (id row in states) {
                [self.dictStates setObject:[row objectForKey:@"state_id"] forKey:[row objectForKey:@"state_name"]];
            }
            countries = [resultsDictionary objectForKey:@"countries2"];
            for (id row in countries) {
                [self.dictCountries setObject:[row objectForKey:@"country_id"] forKey:[row objectForKey:@"country_name"]];
            }
//            self.stateArray = [resultsDictionary objectForKey:@"states"];
//            self.countryArray = [resultsDictionary objectForKey:@"countries"];
//            NSLog(@"state :%@\ncountry :%@",self.stateArray,self.countryArray);
            
        }else{
            CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Create Failed" message:@"Connection failure. Please try again later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            alert.tag = kAlertNoConnection;
            [alert show];
            [alert release];
        
        }
        
    }
}

- (IBAction)pickerDoneClicked:(id)sender
{
    NSLog(@"curr :%d",self.currTag);
    if (self.currTag == 1) {
        if (![self.stateTextField.text length]) {
            self.stateTextField.text = [self.stateArray objectAtIndex:0];
        }
        self.stateId = [self.dictStates objectForKey:self.stateTextField.text];
        [self.stateTextField resignFirstResponder];
    } else if (self.currTag == 2) {
        if (![self.countryTextField.text length]) {
            self.countryTextField.text = [self.countryArray objectAtIndex:0];
        }
        self.countryId = [self.dictCountries objectForKey:self.countryTextField.text];
        [self.countryTextField resignFirstResponder];
    }
    //    self.countryTextField.text = [self.stateArray objectForKey:self.stateTextField.text];
    //    [self.stateTextField resignFirstResponder];
    //    NSLog(@"ID :%@",self.categoryId);
}

#pragma mark -
#pragma mark saveAddress

- (void)checkSaveChangeAddress
{
    [self.view endEditing:YES];
    
    if ([self.addressTextField.text length] == 0) {
        reqFieldName = @"Address";
        [self triggerRequiredAlert];
    }
//    else if ([self.cityTextField.text length] == 0)
//    {
//        reqFieldName = @"City";
//        [self triggerRequiredAlert];
//    }
    else if ([self.postcodeTextField.text length] == 0)
    {
        reqFieldName = @"Postcode";
        [self triggerRequiredAlert];
    }
    else if ([self.stateTextField.text length] == 0)
    {
        reqFieldName = @"State";
        [self triggerRequiredAlert];
    }
    else if ([self.countryTextField.text length] == 0)
    {
        reqFieldName = @"Country";
        [self triggerRequiredAlert];
    }
    else {
        //save address
        [self performSelector:@selector(saveChangeAddress) withObject:nil afterDelay:0.5];
    }
}

- (void)triggerRequiredAlert
{
    NSString *reqMsg = [NSString stringWithFormat:@"%@ is required.",reqFieldName];
    
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Address Profile" message:reqMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)saveChangeAddress
{
    [self.view endEditing:YES];
    
    // If OK, go to alertview delegate
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Save Change Address" message:@"Press OK to continue." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert.tag = 20;
    [alert show];
    [alert release];
}

- (void)processSaveChangeAddress
{
    if (self.stateId == NULL) {
        self.stateId = [self.dictStates objectForKey:self.stateTextField.text];
    }
    if (self.countryId == NULL) {
        self.countryId = [self.dictCountries objectForKey:self.countryTextField.text];
    }
    NSString *flag = @"EDIT_ADDRESS2";
    NSString *urlString = [NSString stringWithFormat:@"%@/api/settings_jambulite_profile.php?token=%@",APP_API_URL,[[[NSUserDefaults standardUserDefaults] objectForKey:@"tokenString"]mutableCopy]];
    
    NSString *dataContent = [NSString stringWithFormat:@"{\"flag\":\"%@\",\"addressId\":\"%@\",\"address\":\"%@\",\"city\":\"%@\",\"postcode\":\"%@\",\"state_id\":\"%@\",\"country_id\":\"%@\"}",
                             flag,
                             self.addressId,
                             self.addressTextField.text,
                             self.cityTextField.text,
                             self.postcodeTextField.text,
                             self.stateId,
                             self.countryId];
    
    NSString *response = [ASIWrapper requestPostJSONWithStringURL:urlString andDataContent:dataContent];
    NSLog(@"abc: %@, def:%@",dataContent, response);
    NSDictionary *resultsDictionary = [[response objectFromJSONString] mutableCopy];
    
    if([resultsDictionary count])
    {
        NSString *status = [resultsDictionary objectForKey:@"status"];
        NSString *msg = [resultsDictionary objectForKey:@"message"];
        
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Address Profile" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alert show];
        [alert release];
        
        if ([status isEqualToString:@"ok"]) {
            NSLog(@"Success submit address");
            UJliteProfileViewController *ujlite = [[UJliteProfileViewController alloc] init];
            [ujlite reloadView];
            [ujlite release];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    [DejalBezelActivityView removeViewAnimated:YES];
}

#pragma mark -
#pragma mark alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  
    if (alertView.tag == kAlertNoConnection) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (alertView.tag == kAlertSave) {
        if (buttonIndex == 1) {
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading ..." width:100];
            NSLog(@"deleted");
            [self performSelector:@selector(processDeleteAddress) withObject:nil afterDelay:0.0];
        }
    }else {
        if (buttonIndex == 1) {
            [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading ..." width:100];
            NSLog(@"changed");
            [self performSelector:@selector(processSaveChangeAddress) withObject:nil afterDelay:0.0];
        }
    }
    
}

- (void)deleteAddress
{
    [self.view endEditing:YES];
    
    // If OK, go to alertview delegate
    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Delete Address" message:@"Press OK to continue." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert.tag = kAlertSave;
    [alert show];
    [alert release];
}

- (void)processDeleteAddress
{
    NSString *flag = @"DEL_ADDRESS";
    NSString *urlString = [NSString stringWithFormat:@"%@/api/settings_jambulite_profile.php?token=%@",APP_API_URL,[[[NSUserDefaults standardUserDefaults] objectForKey:@"tokenString"]mutableCopy]];
    NSString *dataContent = [NSString stringWithFormat:@"{\"flag\":\"%@\",\"addressId\":\"%@\"}",
                             flag,self.addressId];
    
    NSString *response = [ASIWrapper requestPostJSONWithStringURL:urlString andDataContent:dataContent];
    NSLog(@"abc: %@, def:%@",dataContent, response);
    NSDictionary *resultsDictionary = [[response objectFromJSONString] mutableCopy];
    
    if([resultsDictionary count])
    {
        NSString *status = [resultsDictionary objectForKey:@"status"];
        NSString *msg = [resultsDictionary objectForKey:@"message"];
        
        CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Address Profile" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        if ([status isEqualToString:@"ok"]) {
            NSLog(@"Success delete address");
            UJliteProfileViewController *ujlite = [[UJliteProfileViewController alloc] init];
            [ujlite removeMailView];
            [ujlite reloadView];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    [DejalBezelActivityView removeViewAnimated:YES];
}

#pragma mark -
#pragma mark UIPickerView Delegate
// Number of components.
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return [self.stateArray count];
    }
    else
        return [self.countryArray count];
}

// Display each row's data.
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return [self.stateArray objectAtIndex: row];
    }
    else
        return [self.countryArray objectAtIndex: row];
}

// Do something with the selected row.
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"option selected %d", row);
    if (pickerView.tag == 1) {
        self.stateTextField.text = [self.stateArray objectAtIndex:row];
    }
    else
        self.countryTextField.text = [self.countryArray objectAtIndex:row];
}

#pragma mark -
#pragma mark textField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scroller setContentSize:CGSizeMake(self.contentView.frame.size.width, kFrameHeightOnKeyboardUp)];
    [self.scroller adjustOffsetToIdealIfNeeded];
    self.currTag = textField.tag;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.scroller setContentSize:CGSizeMake(self.contentView.frame.size.width, kFrameHeightOnKeyboardUp+44)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_addressId release];
    [_address release];
    [_city release];
    [_postcode release];
    [_state release];
    [_country release];
    [_addressTextField release];
    [_cityTextField release];
    [_postcodeTextField release];
    [_stateTextField release];
    [_countryTextField release];
    [_dictStates release];
    [_dictCountries release];
    [_stateId release];
    [_countryId release];
    [_saveChangeButton release];
    [_deleteButton release];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setAddressId:nil];
    [self setAddress:nil];
    [self setCity:nil];
    [self setPostcode:nil];
    [self setState:nil];
    [self setCountry:nil];
    [self setAddressTextField:nil];
    [self setCityTextField:nil];
    [self setPostcodeTextField:nil];
    [self setStateTextField:nil];
    [self setCountryTextField:nil];
    [self setDictStates:nil];
    [self setDictCountries:nil];
    [self setStateId:nil];
    [self setCountryId:nil];
    [self setSaveChangeButton:nil];
    [self setDeleteButton:nil];
    [super viewDidUnload];
}

@end
