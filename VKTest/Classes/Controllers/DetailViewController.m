//
//  DetailViewController.m
//  VKTest
//
//  Created by Александр on 03.11.15.
//  Copyright © 2015 Alexander Bugaev. All rights reserved.
//

#import "DetailViewController.h"
#import "NewsFooterCollectionReusableView.h"
#import "NewsHeaderCollectionReusableView.h"
#import "NewsTextCollectionViewCell.h"
#import "NewsImageCollectionViewCell.h"
#import "Constants.h"
#import "Photo.h"
#import <UIImageView+WebCache.h>

@interface DetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsHeaderViewIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNewsHeaderViewIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsFooterViewIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kNewsFooterViewIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsTextCollectionViewIdentifier bundle:nil] forCellWithReuseIdentifier:kNewsTextCollectionViewIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:kNewsImageCollectionViewIdentifier bundle:nil] forCellWithReuseIdentifier:kNewsImageCollectionViewIdentifier];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        NewsTextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewsTextCollectionViewIdentifier forIndexPath:indexPath];
        
        cell.title.text = self.currentNote.text;
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        return cell;
    } else {
        NewsImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNewsImageCollectionViewIdentifier forIndexPath:indexPath];
        Photo *photo = [[self.currentNote urlImages] objectAtIndex:indexPath.row-1];
        [cell.photoView sd_setImageWithURL:[NSURL URLWithString:photo.photoURL]];
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        return cell;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1 + [self.currentNote numberOfAttachImages];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        NewsHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNewsHeaderViewIdentifier forIndexPath:indexPath];
        [headerView configureView:self.currentNote];
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        NewsFooterCollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kNewsFooterViewIdentifier forIndexPath:indexPath];
        [footerview configureView:self.currentNote];
        reusableview = footerview;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.frame.size.width, 55);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.frame.size.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row > 0) {
        //if ([self.currentNote urlImages].count == 1) {
            Photo *photo = [[self.currentNote urlImages] objectAtIndex:indexPath.row-1];
            CGFloat relation = photo.width.floatValue / photo.height.floatValue;
            return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.width / relation);
//        } else {
//            return CGSizeMake(self.collectionView.frame.size.width / 2, self.collectionView.frame.size.width / 2);
//        }
    }
    
    CGRect labelRect = [self.currentNote.text
                        boundingRectWithSize:CGSizeMake(self.collectionView.frame.size.width - 16, CGFLOAT_MAX)
                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                        attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}
                        context:nil];
    return CGSizeMake(self.collectionView.frame.size.width, labelRect.size.height + 16);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
