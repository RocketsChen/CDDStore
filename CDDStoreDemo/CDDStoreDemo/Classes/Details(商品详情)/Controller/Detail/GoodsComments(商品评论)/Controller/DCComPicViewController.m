//
//  DCComPicViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/24.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCComPicViewController.h"
#import "DCDetailPicCell.h"
#import "UIView+Toast.h"
#import <Photos/Photos.h>
#import <UIImageView+WebCache.h>

@interface DCComPicViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/* collectionview */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 评论 */
@property (strong , nonatomic)NSString *comComtent;
/* 规格 */
@property (strong , nonatomic)NSString *comSpecifications;
/* 选择 */
@property (assign , nonatomic)NSInteger selectCount;
/* 图片数组 */
@property (nonatomic, copy) NSArray *imageArray;
/* 提示 */
@property (strong , nonatomic)UILabel *tipLabel;
/* 底部View */
@property (strong , nonatomic)UIView *bottomView;

/* cell */
@property (weak , nonatomic)DCDetailPicCell *cell;
@end

static NSString *const DCDetailPicCellID = @"DCDetailPicCell";

@implementation DCComPicViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *dcFlowLayout = [UICollectionViewFlowLayout new];
        dcFlowLayout.minimumLineSpacing = dcFlowLayout.minimumInteritemSpacing = 0;
        dcFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:dcFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = [UIScreen mainScreen].bounds;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [self.view insertSubview:_collectionView atIndex:0];
        
        [_collectionView registerClass:[DCDetailPicCell class] forCellWithReuseIdentifier:DCDetailPicCellID];
    }
    return _collectionView;
}


#pragma mark - 基础设置
- (void)setUpComPicAttribute:(void(^)(NSArray **imageArray,NSString **comComtent,NSString **comSpecifications,NSInteger *selectCount))BaseSettingBlock{
    
    NSArray *imageArray;
    NSString *comSpecifications;
    NSString *comComtent;
    
    NSInteger selectCount;
    
    if (BaseSettingBlock) {
        BaseSettingBlock(&imageArray,&comComtent,&comSpecifications,&selectCount);
        
        self.imageArray = imageArray;
        self.comComtent = comComtent;
        self.comSpecifications = comSpecifications;
        self.selectCount = selectCount;
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpBottomView];
}

- (void)setUpBase
{
    self.view.backgroundColor = DCBGColor;
    
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.selectCount inSection:0];
    [self.collectionView selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally]; //默认选择
}

#pragma mark - 底部View
- (void)setUpBottomView
{
    CGFloat contentH = [DCSpeedy dc_calculateTextSizeWithText:_comComtent WithTextFont:13 WithMaxW:ScreenW - 20].height;
    _bottomView = [UIView new];
    [self.view insertSubview:_bottomView aboveSubview:_collectionView];
    _bottomView.frame = CGRectMake(0, ScreenH - (contentH + 45 + 15), ScreenW, (contentH + 45 + 15));
    _bottomView.backgroundColor = RGBA(32, 30, 28,0.8);
    
    
    UILabel *contentLabel = [UILabel new];
    contentLabel.numberOfLines = 0;
    contentLabel.font = PFR13Font;
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.text = _comComtent;
    [_bottomView addSubview:contentLabel];
    
    UILabel *specificationsLabel = [UILabel new];
    specificationsLabel.font = PFR11Font;
    specificationsLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    specificationsLabel.text = _comSpecifications;
    [_bottomView addSubview:specificationsLabel];
    
    
    _tipLabel = [UILabel new];
    _tipLabel.font = PFR12Font;
    _tipLabel.text = [NSString stringWithFormat:@"%zd/%zd",_selectCount+1,_imageArray.count];
    _tipLabel.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    [_bottomView addSubview:_tipLabel];
    
    
    [specificationsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_bottomView)setOffset:DCMargin];
        [make.top.mas_equalTo(_bottomView)setOffset:DCMargin];
        make.height.mas_equalTo(@15);
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(_bottomView)setOffset:-15];
        make.top.mas_equalTo(specificationsLabel);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(specificationsLabel);
        [make.top.mas_equalTo(specificationsLabel.mas_bottom)setOffset:DCMargin];
        [make.right.mas_equalTo(_bottomView)setOffset:-DCMargin];
    }];
    
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    DCDetailPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCDetailPicCellID forIndexPath:indexPath];
    _cell = cell;
//    __weak typeof(cell)weakCell = cell;
    cell.savePhotoBlock = ^{
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [controller addAction:[UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            #pragma mark - C语言
//            //保存图片
//            UIImageWriteToSavedPhotosAlbum(weakCell.itemImageView.image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            
            
            #pragma mark - <Photos/Photos.h>
            [weakSelf saveImage]; //保存图片
            
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [weakSelf presentViewController:controller animated:YES completion:nil];
    };
    
    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[indexPath.row]]];

    return cell;
}

#pragma mark - C语言
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    NSString *msg = (error) ? @"保存失败" : @"保存成功";
//    [self.view makeToast:msg duration:0.5 position:CSToastPositionCenter];
//}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint currentPoint = scrollView.contentOffset;
    NSInteger page = currentPoint.x / scrollView.dc_width;
    _tipLabel.text = [NSString stringWithFormat:@"%zd/%zd",page+1,_imageArray.count];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ScreenW, ScreenH);
}


#pragma mark - <Photos/Photos.h>
//1.一下是利用<Photos/Photos.h>框架保存照片到相册和自定义相册的过程
//2.上面我把利用C语言保存图片的方式注释了，需要的可自行打开查看
//3.从实现的简易角度 C语言比<Photos/Photos.h>框架实现方便更容易简洁
#pragma mark - 保存图片
- (void)saveImage
{
    //1.获取当前的授权状态
    PHAuthorizationStatus lastStatus = [PHPhotoLibrary authorizationStatus];
    
    //2.请求授权
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(status == PHAuthorizationStatusDenied){//用户拒绝（可能是之前拒绝的，有可能是刚才在系统弹框中选择的拒绝）
                
                if (lastStatus == PHAuthorizationStatusNotDetermined) {
                    //说明，用户之前没有做决定，在弹出授权框中，选择了拒绝
                    [self.view makeToast:@"保存失败" duration:0.5 position:CSToastPositionCenter];
                    return;
                }
                // 说明，之前用户选择拒绝过，现在又点击保存按钮，说明想要使用该功能，需要提示用户打开授权
                [self.view makeToast:@"失败！请在系统设置中开启访问相册权限" duration:0.5 position:CSToastPositionCenter];
            }
            else if(status == PHAuthorizationStatusAuthorized){ //用户允许
                //保存图片-调用上面封装的方法
                [self saveImageToCustomAblum];
            }
            else if (status == PHAuthorizationStatusRestricted){
                [self.view makeToast:@"系统原因，无法访问相册" duration:0.5 position:CSToastPositionCenter];
            }
        });
    }];
}

#pragma mark - 保存到相册
- (void)saveImageToCustomAblum
{
    //1.将图片保存到系统的【相机胶卷】中---调用刚才的方法
    PHFetchResult<PHAsset *> *assets = [self syncSaveImageWithPhotos];
    if (assets == nil){
        [self.view makeToast:@"保存失败" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    //2.拥有自定义相册（与 APP 同名，如果没有则创建）--调用刚才的方法
    PHAssetCollection *assetCollection = [self getAssetCollectionWithAppNameAndCreateIfNo];
    if (assetCollection == nil) {
        [self.view makeToast:@"相册创建失败" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    
    //3.将刚才保存到相机胶卷的图片添加到自定义相册中-保存带自定义相册-属于增的操作，需要在PHPhotoLibrary的block中进行
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //告诉系统，要操作哪个相册
        PHAssetCollectionChangeRequest *collectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
        
        //[collectionChangeRequest addAssets:assets];//添加图片到自定义相册--追加就不能成为封面了
        
        //插入图片到自定义相册--插入--可以成为封面
        [collectionChangeRequest insertAssets:assets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    
    NSString *msg = (error) ? @"保存失败" : @"保存成功" ;
    [self.view makeToast:msg duration:0.5 position:CSToastPositionCenter];
}

#pragma mark - 获取自定义相册
- (PHAssetCollection *)getAssetCollectionWithAppNameAndCreateIfNo
{
    //1.获取以 APP 的名称
    NSString *title = [NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey];
    //2.获取与 APP 同名的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        //遍历
        if ([collection.localizedTitle isEqualToString:title]) {
            //找到了同名的自定义相册--返回
            return collection;
        }
    }
    
    //说明没有找到，需要创建
    NSError *error = nil;
    __block NSString *createID = nil; //用来获取创建好的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //发起了创建新相册的请求，并拿到ID，当前并没有创建成功，待创建成功后，通过 ID 来获取创建好的自定义相册
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
        createID = request.placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) {
        [self.view makeToast:@"自定义相册创建失败" duration:0.5 position:CSToastPositionCenter];
        return nil;
    }else{
        [self.view makeToast:@"自定义相册创建成功" duration:0.5 position:CSToastPositionCenter];
        //通过 ID 获取创建完成的相册 -- 是一个数组
        return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createID] options:nil].firstObject;
    }
    
}

#pragma mark - 同步方式保存图片到系统的相机胶卷中---返回的是当前保存成功后相册图片对象集合
- (PHFetchResult<PHAsset *> *)syncSaveImageWithPhotos
{
    WEAKSELF
    //1.创建 ID 这个参数可以获取到图片保存后的 asset对象
    __block NSString *createdAssetID = nil;
    
    //2.保存图片
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //----block 执行的时候还没有保存成功--获取占位图片的 id，通过 id 获取图片---同步
        createdAssetID = [PHAssetChangeRequest          creationRequestForAssetFromImage:weakSelf.cell.itemImageView.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    //3.如果失败，则返回空
    if (error) return nil;
    
    //4.成功后，返回对象
    //获取保存到系统相册成功后的 asset 对象集合，并返回
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[createdAssetID] options:nil];
    return assets;
}

@end
