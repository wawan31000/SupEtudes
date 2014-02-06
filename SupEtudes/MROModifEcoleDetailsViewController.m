//
//  MROModifEcoleDetailsViewController.m
//  SupEtudes
//
//  Created by Developer on 20/01/14.
//  Copyright (c) 2014 Maxime Roch. All rights reserved.
//

#import "MROModifEcoleDetailsViewController.h"

@interface MROModifEcoleDetailsViewController ()

@end

@implementation MROModifEcoleDetailsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    _typeInfo = [NSArray arrayWithObjects:@"Avantage",@"Inconvenient", nil];
    NSSet * a = [_information.avantages copy];
    _avantages = a.allObjects;
    NSSet * i = [_information.inconvenients copy];
    _inconvenients = i.allObjects;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


////////////////////////////////////////////
// Gestion Table View -- Liste des domaines
///////////////////////////////////////////
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"Avantages";
    }
    else
    {
        return @"Inconvenients";
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"EcoleAI";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = @"test";
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger nbRows = 0;
    if(section == 0) nbRows = [_avantages count];
    else nbRows = [_inconvenients count];
    return nbRows;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row);
}

- (IBAction)AddInformation:(id)sender {
    CustomIOS7AlertView * alertView = [[CustomIOS7AlertView alloc]init];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(70, 10, 270, 20)];
    [title setText:@"Nouvelle Information"];
    [view addSubview:title];
    
    _infoName = [[UITextField alloc]initWithFrame:CGRectMake(15, 60, 270, 40)];
    _infoName.borderStyle = UITextBorderStyleRoundedRect;
    _infoName.autocorrectionType = UITextAutocorrectionTypeNo;
    _infoName.keyboardType = UIKeyboardTypeDefault;
    _infoName.returnKeyType = UIReturnKeyDone;
    _infoName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _infoName.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:_infoName];
    
     _pw = [[UIPickerView alloc]initWithFrame:CGRectMake(15, 70, 270, 100)];
    _pw.showsSelectionIndicator = YES;
    _pw.hidden = NO;
    _pw.delegate = self;
    [view addSubview:_pw];
    [alertView setContainerView:view];
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Annuler", @"Enregistrer", nil]];
    [alertView setDelegate:self];
    [alertView setUseMotionEffects:true];
    [alertView show];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return (NSString *)[_typeInfo objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

-(void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Button Custom : %d",buttonIndex);
    [alertView close];
}

@end
