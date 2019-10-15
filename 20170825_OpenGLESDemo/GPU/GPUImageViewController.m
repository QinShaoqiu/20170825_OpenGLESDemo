//
//  GPUImageViewController.m
//  20170825_OpenGLESDemo
//
//  Created by qinshaoqing on 2019/10/12.
//  Copyright © 2019 shaoqiu. All rights reserved.
//
/**
系统依赖库：
Foundation.framework

UIKit.framework

CoreGraphics.framework

CoreMedia.framework

CoreVideo.framework

OpenGLES.framework

AVFoundation.framework

QuartzCore.framework

GPUImage/Source文件下有iOS和Ma两个文件夹，根据需要删掉其中一个。项目是iOS的就删了Mac文件夹。


 
 GPUImageVideoCamera 视频拍摄；
 GPUImageStillCamera 图片拍摄，其实继承于GPUImageVideoCamera，所以GPUImageStillCamera既可以拍照也可以拍视频；
 GPUImageFilter 默认滤镜效果
 GPUImageMovieWriter录制写入 ；
 GPUImageView取景框；
 
*/


#import "GPUImageViewController.h"
#import "GPUImageCollectionViewCell.h"

#import <ReactiveObjC.h>



@interface GPUImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GPUImageViewController

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        
        NSArray *temp = @[@"原图",@"滤镜1",@"滤镜2",@"滤镜3",@"滤镜4",@"滤镜5",@"滤镜6",@"滤镜7",@"滤镜8",@"滤镜9",@"滤镜10",@"滤镜11",@"滤镜12",@"滤镜13",@"滤镜14",@"滤镜15",@"滤镜16",@"滤镜17",@"滤镜18",@"滤镜19",@"滤镜20"];
 
        _dataArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < temp.count; i++) {
            
            UIImage *image = [self getResultImage:i andImage:[UIImage imageNamed:@"p1"]];
            
            if (image) {
                [_dataArray addObject:image];
            }
        }
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
//    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"相机" forState:UIControlStateNormal];
    button.titleLabel.font = kFontRegular(15.5f);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;//右对齐
    [button sizeToFit];
    button.bounds = CGRectMake(0, 0, 70, 40);
    
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    
    //布局方式
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 30) / 3, ([UIScreen mainScreen].bounds.size.width - 30) / 3);   //item的大小
    flowLayout.minimumLineSpacing = 5;      //cell的最小行间距
    flowLayout.minimumInteritemSpacing = 5; //cell的最小列间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5); //设置senction的内边距
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];    //滑动方向
    
    //初始化collectionView,一定要用下面这个带布局方式参数的方法
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    
    //代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[GPUImageCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

#pragma mark -- UICollectionViewDataSource

//返回Items个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

//返回Cell显示内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    
    GPUImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (cell) {
        // [cell sizeToFit];
    }
    cell.imgView.image = self.dataArray[indexPath.row];
 
    return cell;
}

#pragma mark UICollectionView Delegate

//选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UIButton *temBtn = [[UIButton alloc] initWithFrame:(CGRect){0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height}];
    [temBtn setBackgroundImage:self.dataArray[indexPath.row] forState:UIControlStateNormal];

    [[temBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [temBtn removeFromSuperview];
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:temBtn];
}


- (UIImage *)getResultImage:(NSInteger)index andImage:(UIImage *)inputImage{
    
    switch (index) {
        case 0:
        {
            return inputImage;
        }
            break;
            
        case 1:
        {
            //红
            GPUImageRGBFilter *filter = [[GPUImageRGBFilter alloc] init];
            filter.red = 0.9;
            filter.green = 0.8;
            filter.blue = 0.9;
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;

        }
            break;
            
        case 2:
        {
            //蓝
            GPUImageRGBFilter *filter = [[GPUImageRGBFilter alloc] init];
            filter.red = 0.8;
            filter.green = 0.8;
            filter.blue = 0.9;
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;

        }
            break;
            
        case 3:
        {
            //绿
            GPUImageRGBFilter *filter = [[GPUImageRGBFilter alloc] init];
            filter.red = 0.8;
            filter.green = 0.9;
            filter.blue = 0.8;
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
        case 4:
        {
            //怀旧
            GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc] init];
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
            
        }
            break;
            
        case 5:
        {
            //朦胧加暗
            GPUImageHazeFilter *filter = [[GPUImageHazeFilter alloc] init];
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;

        }
            break;
            
        case 6:
        {
            //饱和
            GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init];
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
        case 7:
        {
            //亮度
            GPUImageBrightnessFilter *filter = [[GPUImageBrightnessFilter alloc] init];
            filter.brightness = 0.2;
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
        case 8:
        {
            //曝光度
            GPUImageExposureFilter *filter = [[GPUImageExposureFilter alloc] init];
            filter.exposure = 0.15;
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
           break;
            
        case 9:
        {
            //素描
            GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
        case 10:
        {
            //卡通
            GPUImageSmoothToonFilter *filter = [[GPUImageSmoothToonFilter alloc] init];
            filter.blurRadiusInPixels = 0.5;
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
            
        }
            break;
            
        case 11:
        {
            //效果：中间突出 四周暗(边缘阴影)
            
            GPUImageVignetteFilter *filter = [[GPUImageVignetteFilter alloc] init];
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
        case 12:
        {
            //效果：模糊
            
            GPUImageGaussianBlurFilter *filter = [[GPUImageGaussianBlurFilter alloc] init];
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
        case 13:
        {
            //效果：部分清晰的高斯模糊
            
            GPUImageGaussianSelectiveBlurFilter *filter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
            filter.blurRadiusInPixels = 5; // 模糊的程度 默认:5
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
        case 14:
        {
            //效果：伸展失真，哈哈镜
            
            GPUImageStretchDistortionFilter *filter = [[GPUImageStretchDistortionFilter alloc] init];
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
            
        case 15:
        {
            //效果：水晶球效果
            
            GPUImageGlassSphereFilter *filter = [[GPUImageGlassSphereFilter alloc] init];
            
            //设置要渲染的区域
            [filter forceProcessingAtSize:inputImage.size];
            [filter useNextFrameForImageCapture];
            
            //获取数据源
            GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
            
            //添加上滤镜
            [stillImageSource addTarget:filter];
            
            //开始渲染
            [stillImageSource processImage];
            
            //获取渲染后的图片
            UIImage *newImage = [filter imageFromCurrentFramebuffer];
            return newImage;
        }
            break;
            
               case 16:
               {
                   //效果：GPUImageThresholdSketchFilter
                   
                   GPUImageThresholdSketchFilter *filter = [[GPUImageThresholdSketchFilter alloc] init];
                   
                   //设置要渲染的区域
                   [filter forceProcessingAtSize:inputImage.size];
                   [filter useNextFrameForImageCapture];
                   
                   //获取数据源
                   GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
                   
                   //添加上滤镜
                   [stillImageSource addTarget:filter];
                   
                   //开始渲染
                   [stillImageSource processImage];
                   
                   //获取渲染后的图片
                   UIImage *newImage = [filter imageFromCurrentFramebuffer];
                   return newImage;
               }
                   break;

            case 17:
            {
                //效果：GPUImageToonFilter
                
                GPUImageToonFilter *filter = [[GPUImageToonFilter alloc] init];
                
                //设置要渲染的区域
                [filter forceProcessingAtSize:inputImage.size];
                [filter useNextFrameForImageCapture];
                
                //获取数据源
                GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
                
                //添加上滤镜
                [stillImageSource addTarget:filter];
                
                //开始渲染
                [stillImageSource processImage];
                
                //获取渲染后的图片
                UIImage *newImage = [filter imageFromCurrentFramebuffer];
                return newImage;
            }
                break;

       case 18:
       {
           //效果：GPUImageSmoothToonFilter
           
           GPUImageSmoothToonFilter *filter = [[GPUImageSmoothToonFilter alloc] init];
           
           //设置要渲染的区域
           [filter forceProcessingAtSize:inputImage.size];
           [filter useNextFrameForImageCapture];
           
           //获取数据源
           GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
           
           //添加上滤镜
           [stillImageSource addTarget:filter];
           
           //开始渲染
           [stillImageSource processImage];
           
           //获取渲染后的图片
           UIImage *newImage = [filter imageFromCurrentFramebuffer];
           return newImage;
       }
           break;
            

            case 19:
            {
                //效果：GPUImageSmoothToonFilter
                
                GPUImageMosaicFilter *filter = [[GPUImageMosaicFilter alloc] init];
                
                //设置要渲染的区域
                [filter forceProcessingAtSize:inputImage.size];
                [filter useNextFrameForImageCapture];
                
                //获取数据源
                GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
                
                //添加上滤镜
                [stillImageSource addTarget:filter];
                
                //开始渲染
                [stillImageSource processImage];
                
                //获取渲染后的图片
                UIImage *newImage = [filter imageFromCurrentFramebuffer];
                return newImage;
            }
                break;
        
            case 20:
            {
                //效果：GPUImageEmbossFilter
                
                GPUImageEmbossFilter *filter = [[GPUImageEmbossFilter alloc] init];
                
                //设置要渲染的区域
                [filter forceProcessingAtSize:inputImage.size];
                [filter useNextFrameForImageCapture];
                
                //获取数据源
                GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
                
                //添加上滤镜
                [stillImageSource addTarget:filter];
                
                //开始渲染
                [stillImageSource processImage];
                
                //获取渲染后的图片
                UIImage *newImage = [filter imageFromCurrentFramebuffer];
                return newImage;
            }
                break;
            
        default:
            
            break;
    }
    
    
    return inputImage;
}




/**
 

 - #import "GPUImageBrightnessFilter.h"                   //亮度
 #import "GPUImageExposureFilter.h"                  //曝光
 #import "GPUImageContrastFilter.h"                  //对比度
 #import "GPUImageSaturationFilter.h"                //饱和度
 #import "GPUImageGammaFilter.h"                     //伽马线
 #import "GPUImageColorInvertFilter.h"               //反色
 #import "GPUImageSepiaFilter.h"                     //褐色（怀旧）
 #import "GPUImageLevelsFilter.h"                    //色阶
 #import "GPUImageGrayscaleFilter.h"                 //灰度
 #import "GPUImageHistogramFilter.h"                 //色彩直方图，显示在图片上
 #import "GPUImageHistogramGenerator.h"              //色彩直方图
 #import "GPUImageRGBFilter.h"                       //RGB
 #import "GPUImageToneCurveFilter.h"                 //色调曲线
 #import "GPUImageMonochromeFilter.h"                //单色
 #import "GPUImageOpacityFilter.h"                   //不透明度
 #import "GPUImageHighlightShadowFilter.h"           //提亮阴影
 #import "GPUImageFalseColorFilter.h"                //色彩替换（替换亮部和暗部色彩）
 #import "GPUImageHueFilter.h"                       //色度
 #import "GPUImageChromaKeyFilter.h"                 //色度键
 #import "GPUImageWhiteBalanceFilter.h"              //白平横
 #import "GPUImageAverageColor.h"                    //像素平均色值
 #import "GPUImageSolidColorGenerator.h"             //纯色
 #import "GPUImageLuminosity.h"                      //亮度平均
 #import "GPUImageAverageLuminanceThresholdFilter.h" //像素色值亮度平均，图像黑白（有类似漫画效果）
 #import "GPUImageLookupFilter.h"                    //lookup 色彩调整
 #import "GPUImageAmatorkaFilter.h"                  //Amatorka lookup
 #import "GPUImageMissEtikateFilter.h"               //MissEtikate lookup
 #import "GPUImageSoftEleganceFilter.h"              //SoftElegance lookup
 
 #pragma mark - 图像处理 Handle Image
 #import "GPUImageCrosshairGenerator.h"              //十字
 #import "GPUImageLineGenerator.h"                   //线条
 #import "GPUImageTransformFilter.h"                 //形状变化
 #import "GPUImageCropFilter.h"                      //剪裁
 #import "GPUImageSharpenFilter.h"                   //锐化
 #import "GPUImageUnsharpMaskFilter.h"               //反遮罩锐化
 #import "GPUImageFastBlurFilter.h"                  //模糊
 #import "GPUImageGaussianBlurFilter.h"              //高斯模糊
 #import "GPUImageGaussianSelectiveBlurFilter.h"     //高斯模糊，选择部分清晰
 #import "GPUImageBoxBlurFilter.h"                   //盒状模糊
 #import "GPUImageTiltShiftFilter.h"                 //条纹模糊，中间清晰，上下两端模糊
 #import "GPUImageMedianFilter.h"                    //中间值，有种稍微模糊边缘的效果
 #import "GPUImageBilateralFilter.h"                 //双边模糊
 #import "GPUImageErosionFilter.h"                   //侵蚀边缘模糊，变黑白
 #import "GPUImageRGBErosionFilter.h"                //RGB侵蚀边缘模糊，有色彩
 #import "GPUImageDilationFilter.h"                  //扩展边缘模糊，变黑白
 #import "GPUImageRGBDilationFilter.h"               //RGB扩展边缘模糊，有色彩
 #import "GPUImageOpeningFilter.h"                   //黑白色调模糊
 #import "GPUImageRGBOpeningFilter.h"                //彩色模糊
 #import "GPUImageClosingFilter.h"                   //黑白色调模糊，暗色会被提亮
 #import "GPUImageRGBClosingFilter.h"                //彩色模糊，暗色会被提亮
 #import "GPUImageLanczosResamplingFilter.h"         //Lanczos重取样，模糊效果
 #import "GPUImageNonMaximumSuppressionFilter.h"     //非最大抑制，只显示亮度最高的像素，其他为黑
 #import "GPUImageThresholdedNonMaximumSuppressionFilter.h" //与上相比，像素丢失更多
 #import "GPUImageSobelEdgeDetectionFilter.h"        //Sobel边缘检测算法(白边，黑内容，有点漫画的反色效果)
 #import "GPUImageCannyEdgeDetectionFilter.h"        //Canny边缘检测算法（比上更强烈的黑白对比度）
 #import "GPUImageThresholdEdgeDetectionFilter.h"    //阈值边缘检测（效果与上差别不大）
 #import "GPUImagePrewittEdgeDetectionFilter.h"      //普瑞维特(Prewitt)边缘检测(效果与Sobel差不多，貌似更平滑)
 #import "GPUImageXYDerivativeFilter.h"              //XYDerivative边缘检测，画面以蓝色为主，绿色为边缘，带彩色
 #import "GPUImageHarrisCornerDetectionFilter.h"     //Harris角点检测，会有绿色小十字显示在图片角点处
 #import "GPUImageNobleCornerDetectionFilter.h"      //Noble角点检测，检测点更多
 #import "GPUImageShiTomasiFeatureDetectionFilter.h" //ShiTomasi角点检测，与上差别不大
 #import "GPUImageMotionDetector.h"                  //动作检测
 #import "GPUImageHoughTransformLineDetector.h"      //线条检测
 #import "GPUImageParallelCoordinateLineTransformFilter.h" //平行线检测
 #import "GPUImageLocalBinaryPatternFilter.h"        //图像黑白化，并有大量噪点
 #import "GPUImageLowPassFilter.h"                   //用于图像加亮
 #import "GPUImageHighPassFilter.h"                  //图像低于某值时显示为黑
 
 
 
 #pragma mark - 视觉效果 Visual Effect
 #import "GPUImageSketchFilter.h"                    //素描
 #import "GPUImageThresholdSketchFilter.h"           //阀值素描，形成有噪点的素描
 #import "GPUImageToonFilter.h"                      //卡通效果（黑色粗线描边）
 #import "GPUImageSmoothToonFilter.h"                //相比上面的效果更细腻，上面是粗旷的画风
 #import "GPUImageKuwaharaFilter.h"                  //桑原(Kuwahara)滤波,水粉画的模糊效果；处理时间比较长，慎用
 #import "GPUImageMosaicFilter.h"                    //黑白马赛克
 #import "GPUImagePixellateFilter.h"                 //像素化
 #import "GPUImagePolarPixellateFilter.h"            //同心圆像素化
 #import "GPUImageCrosshatchFilter.h"                //交叉线阴影，形成黑白网状画面
 #import "GPUImageColorPackingFilter.h"              //色彩丢失，模糊（类似监控摄像效果）
 
 #import "GPUImageVignetteFilter.h"                  //晕影，形成黑色圆形边缘，突出中间图像的效果
 #import "GPUImageSwirlFilter.h"                     //漩涡，中间形成卷曲的画面
 #import "GPUImageBulgeDistortionFilter.h"           //凸起失真，鱼眼效果
 #import "GPUImagePinchDistortionFilter.h"           //收缩失真，凹面镜
 #import "GPUImageStretchDistortionFilter.h"         //伸展失真，哈哈镜
 #import "GPUImageGlassSphereFilter.h"               //水晶球效果
 #import "GPUImageSphereRefractionFilter.h"          //球形折射，图形倒立
 
 #import "GPUImagePosterizeFilter.h"                 //色调分离，形成噪点效果
 #import "GPUImageCGAColorspaceFilter.h"             //CGA色彩滤镜，形成黑、浅蓝、紫色块的画面
 #import "GPUImagePerlinNoiseFilter.h"               //柏林噪点，花边噪点
 #import "GPUImage3x3ConvolutionFilter.h"            //3x3卷积，高亮大色块变黑，加亮边缘、线条等
 #import "GPUImageEmbossFilter.h"                    //浮雕效果，带有点3d的感觉
 #import "GPUImagePolkaDotFilter.h"                  //像素圆点花样
 #import "GPUImageHalftoneFilter.h"                  //点染,图像黑白化，由黑点构成原图的大致图形    #pragma mark - 混合模式 Blend
 
 #import "GPUImageMultiplyBlendFilter.h"             //通常用于创建阴影和深度效果
 #import "GPUImageNormalBlendFilter.h"               //正常
 #import "GPUImageAlphaBlendFilter.h"                //透明混合,通常用于在背景上应用前景的透明度
 #import "GPUImageDissolveBlendFilter.h"             //溶解
 #import "GPUImageOverlayBlendFilter.h"              //叠加,通常用于创建阴影效果
 #import "GPUImageDarkenBlendFilter.h"               //加深混合,通常用于重叠类型
 #import "GPUImageLightenBlendFilter.h"              //减淡混合,通常用于重叠类型
 #import "GPUImageSourceOverBlendFilter.h"           //源混合
 #import "GPUImageColorBurnBlendFilter.h"            //色彩加深混合
 #import "GPUImageColorDodgeBlendFilter.h"           //色彩减淡混合
 #import "GPUImageScreenBlendFilter.h"               //屏幕包裹,通常用于创建亮点和镜头眩光
 #import "GPUImageExclusionBlendFilter.h"            //排除混合
 #import "GPUImageDifferenceBlendFilter.h"           //差异混合,通常用于创建更多变动的颜色
 #import "GPUImageSubtractBlendFilter.h"             //差值混合,通常用于创建两个图像之间的动画变暗模糊效果
 #import "GPUImageHardLightBlendFilter.h"            //强光混合,通常用于创建阴影效果
 #import "GPUImageSoftLightBlendFilter.h"            //柔光混合
 #import "GPUImageChromaKeyBlendFilter.h"            //色度键混合
 #import "GPUImageMaskFilter.h"                      //遮罩混合
 #import "GPUImageHazeFilter.h"                      //朦胧加暗
 #import "GPUImageLuminanceThresholdFilter.h"        //亮度阈
 #import "GPUImageAdaptiveThresholdFilter.h"         //自适应阈值
 #import "GPUImageAddBlendFilter.h"                  //通常用于创建两个图像之间的动画变亮模糊效果
 #import "GPUImageDivideBlendFilter.h"               //通常用于创建两个图像之间的动画变暗模糊效果
 
 */








/**
 #import "GPUImageBrightnessFilter.h"                //亮度
 29 #import "GPUImageExposureFilter.h"                  //曝光
 30 #import "GPUImageContrastFilter.h"                  //对比度
 31 #import "GPUImageSaturationFilter.h"                //饱和度
 32 #import "GPUImageGammaFilter.h"                     //伽马线
 33 #import "GPUImageColorInvertFilter.h"               //反色
 34 #import "GPUImageSepiaFilter.h"                     //褐色（怀旧）
 35 #import "GPUImageLevelsFilter.h"                    //色阶
 36 #import "GPUImageGrayscaleFilter.h"                 //灰度
 37 #import "GPUImageHistogramFilter.h"                 //色彩直方图，显示在图片上
 38 #import "GPUImageHistogramGenerator.h"              //色彩直方图
 39 #import "GPUImageRGBFilter.h"                       //RGB
 40 #import "GPUImageToneCurveFilter.h"                 //色调曲线
 41 #import "GPUImageMonochromeFilter.h"                //单色
 42 #import "GPUImageOpacityFilter.h"                   //不透明度
 43 #import "GPUImageHighlightShadowFilter.h"           //提亮阴影
 44 #import "GPUImageFalseColorFilter.h"                //色彩替换（替换亮部和暗部色彩）
 45 #import "GPUImageHueFilter.h"                       //色度
 46 #import "GPUImageChromaKeyFilter.h"                 //色度键
 47 #import "GPUImageWhiteBalanceFilter.h"              //白平横
 48 #import "GPUImageAverageColor.h"                    //像素平均色值
 49 #import "GPUImageSolidColorGenerator.h"             //纯色
 50 #import "GPUImageLuminosity.h"                      //亮度平均
 51 #import "GPUImageAverageLuminanceThresholdFilter.h" //像素色值亮度平均，图像黑白（有类似漫画效果）
 52
 53 #import "GPUImageLookupFilter.h"                    //lookup 色彩调整
 54 #import "GPUImageAmatorkaFilter.h"                  //Amatorka lookup
 55 #import "GPUImageMissEtikateFilter.h"               //MissEtikate lookup
 56 #import "GPUImageSoftEleganceFilter.h"              //SoftElegance lookup
 
 61 #pragma mark - 图像处理 Handle Image
 62
 63 #import "GPUImageCrosshairGenerator.h"              //十字
 64 #import "GPUImageLineGenerator.h"                   //线条
 65
 66 #import "GPUImageTransformFilter.h"                 //形状变化
 67 #import "GPUImageCropFilter.h"                      //剪裁
 68 #import "GPUImageSharpenFilter.h"                   //锐化
 69 #import "GPUImageUnsharpMaskFilter.h"               //反遮罩锐化
 70
 71 #import "GPUImageFastBlurFilter.h"                  //模糊
 72 #import "GPUImageGaussianBlurFilter.h"              //高斯模糊
 73 #import "GPUImageGaussianSelectiveBlurFilter.h"     //高斯模糊，选择部分清晰
 74 #import "GPUImageBoxBlurFilter.h"                   //盒状模糊
 75 #import "GPUImageTiltShiftFilter.h"                 //条纹模糊，中间清晰，上下两端模糊
 76 #import "GPUImageMedianFilter.h"                    //中间值，有种稍微模糊边缘的效果
 77 #import "GPUImageBilateralFilter.h"                 //双边模糊
 78 #import "GPUImageErosionFilter.h"                   //侵蚀边缘模糊，变黑白
 79 #import "GPUImageRGBErosionFilter.h"                //RGB侵蚀边缘模糊，有色彩
 80 #import "GPUImageDilationFilter.h"                  //扩展边缘模糊，变黑白
 81 #import "GPUImageRGBDilationFilter.h"               //RGB扩展边缘模糊，有色彩
 82 #import "GPUImageOpeningFilter.h"                   //黑白色调模糊
 83 #import "GPUImageRGBOpeningFilter.h"                //彩色模糊
 84 #import "GPUImageClosingFilter.h"                   //黑白色调模糊，暗色会被提亮
 85 #import "GPUImageRGBClosingFilter.h"                //彩色模糊，暗色会被提亮
 86 #import "GPUImageLanczosResamplingFilter.h"         //Lanczos重取样，模糊效果
 87 #import "GPUImageNonMaximumSuppressionFilter.h"     //非最大抑制，只显示亮度最高的像素，其他为黑
 88 #import "GPUImageThresholdedNonMaximumSuppressionFilter.h" //与上相比，像素丢失更多
 89
 90 #import "GPUImageSobelEdgeDetectionFilter.h"        //Sobel边缘检测算法(白边，黑内容，有点漫画的反色效果)
 91 #import "GPUImageCannyEdgeDetectionFilter.h"        //Canny边缘检测算法（比上更强烈的黑白对比度）
 92 #import "GPUImageThresholdEdgeDetectionFilter.h"    //阈值边缘检测（效果与上差别不大）
 93 #import "GPUImagePrewittEdgeDetectionFilter.h"      //普瑞维特(Prewitt)边缘检测(效果与Sobel差不多，貌似更平滑)
 94 #import "GPUImageXYDerivativeFilter.h"              //XYDerivative边缘检测，画面以蓝色为主，绿色为边缘，带彩色
 95 #import "GPUImageHarrisCornerDetectionFilter.h"     //Harris角点检测，会有绿色小十字显示在图片角点处
 96 #import "GPUImageNobleCornerDetectionFilter.h"      //Noble角点检测，检测点更多
 97 #import "GPUImageShiTomasiFeatureDetectionFilter.h" //ShiTomasi角点检测，与上差别不大
 98 #import "GPUImageMotionDetector.h"                  //动作检测
 99 #import "GPUImageHoughTransformLineDetector.h"      //线条检测
 100 #import "GPUImageParallelCoordinateLineTransformFilter.h" //平行线检测
 101
 102 #import "GPUImageLocalBinaryPatternFilter.h"        //图像黑白化，并有大量噪点
 103
 104 #import "GPUImageLowPassFilter.h"                   //用于图像加亮
 105 #import "GPUImageHighPassFilter.h"                  //图像低于某值时显示为黑
 106
 107
 108 #pragma mark - 视觉效果 Visual Effect
 109
 110 #import "GPUImageSketchFilter.h"                    //素描
 111 #import "GPUImageThresholdSketchFilter.h"           //阀值素描，形成有噪点的素描
 112 #import "GPUImageToonFilter.h"                      //卡通效果（黑色粗线描边）
 113 #import "GPUImageSmoothToonFilter.h"                //相比上面的效果更细腻，上面是粗旷的画风
 114 #import "GPUImageKuwaharaFilter.h"                  //桑原(Kuwahara)滤波,水粉画的模糊效果；处理时间比较长，慎用
 115
 116 #import "GPUImageMosaicFilter.h"                    //黑白马赛克
 117 #import "GPUImagePixellateFilter.h"                 //像素化
 118 #import "GPUImagePolarPixellateFilter.h"            //同心圆像素化
 119 #import "GPUImageCrosshatchFilter.h"                //交叉线阴影，形成黑白网状画面
 120 #import "GPUImageColorPackingFilter.h"              //色彩丢失，模糊（类似监控摄像效果）
 121
 122 #import "GPUImageVignetteFilter.h"                  //晕影，形成黑色圆形边缘，突出中间图像的效果
 123 #import "GPUImageSwirlFilter.h"                     //漩涡，中间形成卷曲的画面
 124 #import "GPUImageBulgeDistortionFilter.h"           //凸起失真，鱼眼效果
 125 #import "GPUImagePinchDistortionFilter.h"           //收缩失真，凹面镜
 126 #import "GPUImageStretchDistortionFilter.h"         //伸展失真，哈哈镜
 127 #import "GPUImageGlassSphereFilter.h"               //水晶球效果
 128 #import "GPUImageSphereRefractionFilter.h"          //球形折射，图形倒立
 129
 130 #import "GPUImagePosterizeFilter.h"                 //色调分离，形成噪点效果
 131 #import "GPUImageCGAColorspaceFilter.h"             //CGA色彩滤镜，形成黑、浅蓝、紫色块的画面
 132 #import "GPUImagePerlinNoiseFilter.h"               //柏林噪点，花边噪点
 133 #import "GPUImage3x3ConvolutionFilter.h"            //3x3卷积，高亮大色块变黑，加亮边缘、线条等
 134 #import "GPUImageEmbossFilter.h"                    //浮雕效果，带有点3d的感觉
 135 #import "GPUImagePolkaDotFilter.h"                  //像素圆点花样
 136 #import "GPUImageHalftoneFilter.h"                  //点染,图像黑白化，由黑点构成原图的大致图形
 137
 138
 139 #pragma mark - 混合模式 Blend
 140
 141 #import "GPUImageMultiplyBlendFilter.h"             //通常用于创建阴影和深度效果
 142 #import "GPUImageNormalBlendFilter.h"               //正常
 143 #import "GPUImageAlphaBlendFilter.h"                //透明混合,通常用于在背景上应用前景的透明度
 144 #import "GPUImageDissolveBlendFilter.h"             //溶解
 145 #import "GPUImageOverlayBlendFilter.h"              //叠加,通常用于创建阴影效果
 146 #import "GPUImageDarkenBlendFilter.h"               //加深混合,通常用于重叠类型
 147 #import "GPUImageLightenBlendFilter.h"              //减淡混合,通常用于重叠类型
 148 #import "GPUImageSourceOverBlendFilter.h"           //源混合
 149 #import "GPUImageColorBurnBlendFilter.h"            //色彩加深混合
 150 #import "GPUImageColorDodgeBlendFilter.h"           //色彩减淡混合
 151 #import "GPUImageScreenBlendFilter.h"               //屏幕包裹,通常用于创建亮点和镜头眩光
 152 #import "GPUImageExclusionBlendFilter.h"            //排除混合
 153 #import "GPUImageDifferenceBlendFilter.h"           //差异混合,通常用于创建更多变动的颜色
 154 #import "GPUImageSubtractBlendFilter.h"             //差值混合,通常用于创建两个图像之间的动画变暗模糊效果
 155 #import "GPUImageHardLightBlendFilter.h"            //强光混合,通常用于创建阴影效果
 156 #import "GPUImageSoftLightBlendFilter.h"            //柔光混合
 157 #import "GPUImageChromaKeyBlendFilter.h"            //色度键混合
 158 #import "GPUImageMaskFilter.h"                      //遮罩混合
 159 #import "GPUImageHazeFilter.h"                      //朦胧加暗
 160 #import "GPUImageLuminanceThresholdFilter.h"        //亮度阈
 161 #import "GPUImageAdaptiveThresholdFilter.h"         //自适应阈值
 162 #import "GPUImageAddBlendFilter.h"                  //通常用于创建两个图像之间的动画变亮模糊效果
 163 #import "GPUImageDivideBlendFilter.h"               //通常用于创建两个图像之间的动画变暗模糊效果
 164
 165
 166 #pragma mark - 尚不清楚
 167 #import "GPUImageJFAVoroniFilter.h"
 168 #import "GPUImageVoroniConsumerFilter.h"
 
 */

@end
