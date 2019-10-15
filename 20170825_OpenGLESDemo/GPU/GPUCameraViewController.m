//
//  GPUCameraViewController.m
//  20170825_OpenGLESDemo
//
//  Created by qinshaoqing on 2019/10/13.
//  Copyright © 2019 shaoqiu. All rights reserved.
//

#import "GPUCameraViewController.h"
#import <ReactiveObjC.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface GPUCameraViewController (){
    GPUImageStillCamera *stillCamera;
    GPUImageOutput<GPUImageInput> *filter, *secondFilter, *terminalFilter;
    UISlider *filterSettingsSlider;
    UIButton *photoCaptureButton;
    
    GPUImagePicture *memoryPressurePicture1, *memoryPressurePicture2;
}

@end

@implementation GPUCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //第一步：创建预览View 即必须的GPUImageView
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:mainScreenFrame];
    primaryView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
//    第二步：创建滤镜 即这里我们使用的 GPUImageSketchFilter(黑白反色)
    GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];

    
    //第三步：创建Camera 即我们要用到的GPUImageStillCamera

    GPUImageStillCamera *stillCamera = [[GPUImageStillCamera alloc] init];
    //设置相机方向
    stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    
//    第四步： addTarget 并开始处理startCameraCapture
    [stillCamera addTarget:filter];
    [filter addTarget:primaryView];
    [stillCamera startCameraCapture];

//    第五步：添加一个按钮photoCaptureButton，当按钮点击的时候进行以下处理，保存图片到相册
    photoCaptureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    photoCaptureButton.frame = CGRectMake(round(mainScreenFrame.size.width / 2.0 - 150.0 / 2.0), mainScreenFrame.size.height - 90.0, 150.0, 40.0);
    [photoCaptureButton setTitle:@"Capture Photo" forState:UIControlStateNormal];
    photoCaptureButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [photoCaptureButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [photoCaptureButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [primaryView addSubview:photoCaptureButton];

    self.view = primaryView;
}

- (void)takePhoto:(id)sender;
{
    [photoCaptureButton setEnabled:NO];
    
    [stillCamera capturePhotoAsJPEGProcessedUpToFilter:filter withCompletionHandler:^(NSData *processedJPEG, NSError *error){

        // Save to assets library
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        
        [library writeImageDataToSavedPhotosAlbum:processedJPEG metadata:stillCamera.currentCaptureMetadata completionBlock:^(NSURL *assetURL, NSError *error2)
         {
             if (error2) {
                 NSLog(@"ERROR: the image failed to be written");
             }
             else {
                 NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
             }
             
             runOnMainQueueWithoutDeadlocking(^{
                 [photoCaptureButton setEnabled:YES];
             });
         }];
    }];
}


@end
