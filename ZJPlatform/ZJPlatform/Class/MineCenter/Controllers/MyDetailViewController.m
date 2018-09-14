//
//  MyDetailViewController.m
//  dragonlion
//
//  Created by sostag on 2017/6/7.
//  Copyright © 2017年 sostag. All rights reserved.
//






#import "MyDetailViewController.h"
#import "QBImagePickerController.h"
#import "UIImageView+WebCache.h"
#import "UploadManager.h"
#import "ChangePwdViewController.h"

//#import "RegisterViewController.h"

@interface MyDetailViewController ()<UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,QBImagePickerControllerDelegate>
{
     IBOutlet UITableViewCell *sexCell;

     IBOutlet UIButton *manBtn;
    IBOutlet UIButton *womanBtn;

    
    UITextField *nameTextField;
    UITextField *emailTextField;
    
    BOOL flag;
}

@property (nonatomic,strong) UIImageView *headerimgView;

@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sexCell.textLabel.font =  Font(15);
    sexCell.textLabel.textColor = [UIColor colorWithHexString:@"7a7a7a"];
    sexCell.textLabel.text = @"我的性别";
    
    [self createBackBtn];
    [self setTitleView:@"个人信息"];
    [self createRightWithTitle:@"保存"];

    flag = NO;
    
    
    if ([[self.userDict objectForKey:@"type"] integerValue] == 1) {
        manBtn.selected = YES;
    }else{
        womanBtn.selected = YES;
    }
  
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadFinish:) name:kNotification_UploadFileFinish object:nil];
    

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 54)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, 10, MainScreenWidth - 30, 44);
    [btn setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    btn.titleLabel.font = Font(15);
    [btn setBackgroundColor:MainBlueColor];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    [view addSubview:btn];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.tableView.tableFooterView = view;
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)logout{
    SHOW_HUD;
    [Utility removeForkey:KUID];
    [Utility removeForkey:PASSWORD];
    [Utility removeForkey:LoginType];
    [Utility removeForkey:DeriverID];
    [Utility deleteCookies];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_LOGIN_OUT object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    HIDDEN_HUD;
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)clickRightBtn{
    if (nameTextField.text.length == 0) {
        [Toast showWithText:@"用户名不能为空"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (flag == YES) {
        [[UploadManager sharedInstance] uploadFileWithImgs:@[self.headerimgView.image]];
    }else{
    
        [self saveUserInformation:nil];
    }
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

-(void)uploadFinish:(NSNotification *)notification{
    if ([notification.object isKindOfClass:[NSArray class]]) {
        NSArray *fileIds = [NSArray arrayWithArray:notification.object];
        [self saveUserInformation:fileIds];
        
    }else{
        [MBProgressHUD hideAllHUDsForView:[[UIApplication sharedApplication] keyWindow] animated:YES];
        [Toast showWithText:@"上传图片失败"];
        
    }
}

-(void)saveUserInformation:(NSArray *)array{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  
    if ([array count]) {
        [dict setObject:[array lastObject] forKey:@"portrait"];
    }else{
        if ([Utility isNotBlank:[self.userDict objectForKey:@"headPortrait"]]) {
            [dict setObject:[self.userDict objectForKey:@"headPortrait"] forKey:@"portrait"];
        }
    }
    
    if ([Utility isNotBlank:nameTextField.text]) {
        [dict setObject:nameTextField.text forKey:@"perfectNickname"];
    }else{
        [dict setObject:@"" forKey:@"perfectNickname"];
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",ProxyUrl,kRequest_student_updateStudent];
    WS(weakSelf);
    [[NetworkManager shareNetworkingManager] requestWithMethod:@"POST"
                                                 headParameter:nil
                                                 bodyParameter:dict
                                                  relativePath:url
                                                       success:^(id responseObject) {
                                                           [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                                                           [Toast showWithText:@"修改成功"];
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Refresh_UserInfo object:nil];
                                                           [weakSelf.navigationController popViewControllerAnimated:YES];
                                                       } failure:^(NSString *errorMsg) {
                                                           [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
                                                       }];

}





-(void)showImage{
    
    UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [action showInView:self.view];
    
    
}

-(IBAction)clickSexBtn:(id)sender{
    if (manBtn == sender) {
        manBtn.selected = YES;
        womanBtn.selected = NO;
    }else{
        manBtn.selected = NO;
        womanBtn.selected = YES;
    }
}



#pragma mark -- acitonsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.videoQuality = UIImagePickerControllerQualityTypeLow;
            picker.delegate = self;
            picker.allowsEditing = NO;
            picker.videoMaximumDuration = 45.0f; // 45 seconds
            picker.mediaTypes = [NSArray arrayWithObjects:@"public.image", nil];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [[self navigationController] presentViewController:picker animated:YES completion:^{}];
            
        }
    }else if(buttonIndex ==1){
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        QBImagePickerController *imagePickerController = [QBImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.mediaType = QBImagePickerMediaTypeImage;

        imagePickerController.allowsMultipleSelection = NO;
        [self presentViewController:imagePickerController animated:YES completion:NULL];
        
    }
}



//UIImagePickerControllerFullResolutionImage 大
//UIImagePickerControllerOriginalImage 中

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if(picker.navigationController)
        [picker.navigationController dismissViewControllerAnimated:YES completion:nil];
    else
        [self dismissImagePickerController];
    
    if ([picker isKindOfClass:[QBImagePickerController class]]) {
        
        
    }else{
        
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
        
        //当选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            //先把图片转成NSData
            //     UIImage *imageNew = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            [self loadPicture:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
            
            
        }
    }
}


-(void)loadPicture:(UIImage *)img{
    self.headerimgView.image = [UIImage imageWithData:[Utility reSizeImageData:img maxImageSize:800 maxSizeWithKB:1024]];
    flag = YES;
}


- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    
    __block UIImage *image = nil;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    [[PHImageManager defaultManager] requestImageForAsset:[assets lastObject] targetSize:[UIScreen mainScreen].bounds.size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
        //设置图片
        image = result;
    }];
    
    
    while (image == nil) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    
    
    [self loadPicture:image];
    [self dismissImagePickerController];
}


- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController {
    [self dismissImagePickerController];
}




- (void)dismissImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}




#pragma mark -- tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self showImage];
    }else if(indexPath.section == 1){
        if (indexPath.row == 1) {
            ChangePwdViewController *vc = [[ChangePwdViewController alloc] initWithNibName:@"ChangePwdViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            
        }
        
        
        //        RegisterViewController *vc = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
//        vc.isChangeMobile = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (row == 0 && section == 0) {
        static NSString *cellid = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            cell.textLabel.font = Font(15);
            cell.textLabel.textColor = [UIColor colorWithHexString:@"7a7a7a"];
            cell.textLabel.text = @"我的头像";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(MainScreenWidth - 40 - 40, 8, 40, 40)];
            
            imgView.layer.masksToBounds = YES;
            imgView.layer.cornerRadius = 20;
            imgView.image = [UIImage imageNamed:@"head_default.png"];
            [cell.contentView addSubview:imgView];
            imgView.tag = 11;
            self.headerimgView = imgView;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(MainScreenWidth - 200 - 30, 0, 200 , 50)];
            nameTextField.placeholder = @"请输入用户名";
            nameTextField.textAlignment = NSTextAlignmentRight;
            nameTextField.font = Font(15);
            nameTextField.textColor = [UIColor colorWithHexString:@"7a7a7a"];
            
            
            
            emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(MainScreenWidth - 200 - 30, 0, 200 , 50)];
            emailTextField.placeholder = @"请输入您的真实姓名";
            emailTextField.textAlignment = NSTextAlignmentRight;
            emailTextField.font = Font(15);
            emailTextField.textColor = [UIColor colorWithHexString:@"7a7a7a"];
            
            
        }
        UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:11];
        
        if ([Utility isNotBlank:[self.userDict objectForKey:@"headPortrait"]]) {
            [imgView sd_setImageWithURL:[NSURL URLWithString:[self.userDict objectForKey:@"headPortrait"]]];
        }else{
            [imgView setImage:[UIImage imageNamed:@"head_default"]];
            
        }
        return cell;
    }else if (row == 2 && section == 0) {
        return sexCell;
    }else if(section == 0){
        
        static NSString *cellid = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
            cell.textLabel.font = Font(15);
            cell.textLabel.textColor = [UIColor colorWithHexString:@"7a7a7a"];
            cell.detailTextLabel.font = Font(15);
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"282828"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (row == 1 && section == 0) {
            cell.textLabel.text = @"用户名";
            [cell.contentView addSubview:nameTextField];
            if ([Utility isNotBlank: [self.userDict objectForKey:@"nickname"]]) {
                nameTextField.text = [self.userDict objectForKey:@"nickname"];
            }
            
        }else if(row == 3 && section == 0){
            cell.textLabel.text = @"邮箱";
            [cell.contentView addSubview:emailTextField];
            if ([Utility isNotBlank: [self.userDict objectForKey:@"trueName"]]) {
                emailTextField.text = [self.userDict objectForKey:@"trueName"];
            }
            
        }
        return cell;
    }

    static NSString *cellid = @"cell3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        cell.textLabel.font = Font(15);
        cell.textLabel.textColor = [UIColor colorWithHexString:@"7a7a7a"];
        cell.detailTextLabel.font = Font(15);
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"282828"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (section == 1 && row == 0) {
        cell.textLabel.text = @"更换手机号";
    }else{
        cell.textLabel.text = @"修改登录密码";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 13;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 55;
    }
        return 50;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}




@end
