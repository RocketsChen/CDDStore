//
//  DCComPicViewController.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/24.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCComPicViewController.h"
#import "DCDetailPicCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+Toast.h"

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
    __weak typeof(cell)weakCell = cell;
    cell.savePhotoBlock = ^{
        
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [controller addAction:[UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //保存图片
            UIImageWriteToSavedPhotosAlbum(weakCell.itemImageView.image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [weakSelf presentViewController:controller animated:YES completion:nil];
    };
    
    [cell.itemImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[indexPath.row]]];

    return cell;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = (error) ? @"保存失败" : @"保存成功";
    [self.view makeToast:msg duration:0.5 position:CSToastPositionCenter];
}


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


@end
