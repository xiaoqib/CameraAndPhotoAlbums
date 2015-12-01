//
//  ViewController.m
//  CameraAndPhotoAlbums
//
//  Created by 陳升琪 on 15/11/30.
//  Copyright © 2015年 陳升琪. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIButton *cameraButton;
@property (nonatomic,strong) UIButton *photoAlbumsButton;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.cameraButton = [[UIButton alloc]init];
    self.cameraButton.backgroundColor = [UIColor redColor];
    [self.cameraButton setTitle:@"相机" forState:UIControlStateNormal];
    [self.cameraButton addTarget:self action:@selector(cameraAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cameraButton];
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(40);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.width.equalTo(@(50));
        make.height.equalTo(@(30));
    }];
    
    self.photoAlbumsButton = [[UIButton alloc]init];
    self.photoAlbumsButton.backgroundColor = [UIColor grayColor];
    [self.photoAlbumsButton setTitle:@"相册" forState:UIControlStateNormal];
    [self.photoAlbumsButton addTarget:self action:@selector(photoAlbumsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.photoAlbumsButton];
    [self.photoAlbumsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cameraButton.mas_bottom).with.offset(10);
        make.left.equalTo(self.cameraButton.mas_left);
        make.width.equalTo(@(50));
        make.height.equalTo(@(30));
    }];
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoAlbumsButton.mas_bottom).with.offset(10);
        make.left.equalTo(self.photoAlbumsButton.mas_left);
        make.width.equalTo(@(200));
        make.height.equalTo(@(200));
    }];
    
}

-(void)cameraAction {
    // 启动相机
    NSLog(@"启动相机的点击事件");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//如果没相机设备直接设定为相片库
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)photoAlbumsAction {
    // 打开相册
    NSLog(@"打开相册的点击事件");
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = NO;
    [pickerImage setModalTransitionStyle:UIModalTransitionStyleCoverVertical];//转变风格使用哪种风格
    [self presentViewController:pickerImage animated:YES completion:nil];
}

#pragma mark Picker Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //点了Use Photo
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        //保存拍摄的照片
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        //获取相册中的照片
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];;
        [self.imageView setImage:image];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //取消相机后 to do
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
