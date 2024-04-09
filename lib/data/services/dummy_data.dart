import 'package:i_store/features/shop/models/banner_model.dart';
import 'package:i_store/features/shop/models/brand_category_model.dart';
import 'package:i_store/features/shop/models/brand_model.dart';
import 'package:i_store/features/shop/models/category_model.dart';
import 'package:i_store/features/shop/models/product_attribute_model.dart';
import 'package:i_store/features/shop/models/product_model.dart';
import 'package:i_store/features/shop/models/product_variation_model.dart';
import 'package:i_store/routes/routes.dart';
import 'package:i_store/utils/constants/image_strings.dart';

class TDummyData {

  /// -- Banners
  static final List<BannerModel> banners = [
    BannerModel(imageUrl: TImages.banner1, targetScreen: TRoutes.order, active: false),
    BannerModel(imageUrl: TImages.banner2, targetScreen: TRoutes.cart, active: true),
    BannerModel(imageUrl: TImages.banner3, targetScreen: TRoutes.favourites, active: true),
    BannerModel(imageUrl: TImages.banner4, targetScreen: TRoutes.search, active: true),
    BannerModel(imageUrl: TImages.banner5, targetScreen: TRoutes.settings, active: true),
    BannerModel(imageUrl: TImages.banner6, targetScreen: TRoutes.userAddress, active: true),
    BannerModel(imageUrl: TImages.banner8, targetScreen: TRoutes.checkout, active: false),
  ];

  /// -- List of categories
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Sports', image: TImages.sportIcon, isFeatured: true),
    CategoryModel(id: '2', name: 'Electronics', image: TImages.electronicsIcon, isFeatured: true),
    CategoryModel(id: '3', name: 'Clothes', image: TImages.clothIcon, isFeatured: true),
    CategoryModel(id: '4', name: 'Animals', image: TImages.animalIcon, isFeatured: true),
    CategoryModel(id: '5', name: 'Furniture', image: TImages.furnitureIcon, isFeatured: true),
    CategoryModel(id: '6', name: 'Shoes', image: TImages.shoeIcon, isFeatured: true),
    CategoryModel(id: '7', name: 'Cosmetics', image: TImages.cosmeticsIcon, isFeatured: true),
    CategoryModel(id: '14', name: 'Jewelery', image: TImages.jeweleryIcon, isFeatured: true),

    ///Subcategories
    CategoryModel(id: '8', name: 'Sport Shoes', image: TImages.sportIcon, parentId: '1', isFeatured: false),
    CategoryModel(id: '9', name: 'Track suits', image: TImages.sportIcon, parentId: '1', isFeatured: false),
    CategoryModel(id: '10', name: 'Sports Equipments', image: TImages.sportIcon, parentId: '1', isFeatured: false),
    //Furniture
    CategoryModel(id: '11', name: 'Bedroom furniture', image: TImages.furnitureIcon, parentId: '5', isFeatured: false),
    CategoryModel(id: '12', name: 'Kitchen furniture', image: TImages.furnitureIcon, parentId: '5', isFeatured: false),
    CategoryModel(id: '13', name: 'Office furniture', image: TImages.furnitureIcon, parentId: '5', isFeatured: false),
    //electronics
    CategoryModel(id: '15', name: 'Laptop', image: TImages.electronicsIcon, parentId: '2', isFeatured: false),
    CategoryModel(id: '16', name: 'Mobile', image: TImages.electronicsIcon, parentId: '2', isFeatured: false),

    CategoryModel(id: '17', name: 'Shirts', image: TImages.clothIcon, parentId: '3', isFeatured: false),
  ];

  /// -- List of all Brands
  static final List<BrandModel> brands = [
    BrandModel(id: '1', image: TImages.nikeLogo, name: 'Nike', productsCount: 265, isFeatured: true),
    BrandModel(id: '2', image: TImages.adidasLogo, name: 'Adidas', productsCount: 95, isFeatured: true),
    BrandModel(id: '8', image: TImages.kenwoodLogo, name: 'Kenwood', productsCount: 36, isFeatured: false),
    BrandModel(id: '9', image: TImages.ikeaLogo, name: 'IKEA', productsCount: 36, isFeatured: false),
    BrandModel(id: '5', image: TImages.appleLogo, name: 'Apple', productsCount: 16, isFeatured: true),
    BrandModel(id: '10', image: TImages.acerlogo, name: 'Acer', productsCount: 36, isFeatured: false),
    BrandModel(id: '3', image: TImages.jordanLogo, name: 'Jordan', productsCount: 36, isFeatured: true),
    BrandModel(id: '4', image: TImages.pumaLogo, name: 'Puma', productsCount: 65, isFeatured: true),
    BrandModel(id: '6', image: TImages.zaraLogo, name: 'ZARA', productsCount: 36, isFeatured: true),
    BrandModel(id: '7', image: TImages.electronicsIcon, name: 'Samsung', productsCount: 36, isFeatured: false),
  ];

  /// -- List Brand-Category
  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '1'),
    BrandCategoryModel(brandId: '1', categoryId: '8'),
    BrandCategoryModel(brandId: '1', categoryId: '10'),
    BrandCategoryModel(brandId: '10', categoryId: '5'),
    BrandCategoryModel(brandId: '10', categoryId: '15'),
    BrandCategoryModel(brandId: '10', categoryId: '16'),
    BrandCategoryModel(brandId: '7', categoryId: '2'),
    BrandCategoryModel(brandId: '2', categoryId: '3'),
    BrandCategoryModel(brandId: '9', categoryId: '4'),
    BrandCategoryModel(brandId: '9', categoryId: '5'),
    BrandCategoryModel(brandId: '4', categoryId: '6'),
    BrandCategoryModel(brandId: '6', categoryId: '9'),
  ];

 /// -- List of all Products
  static final List<ProductModel> products = [
      ProductModel(
          id: '001',
          title: 'Green Nike sports shoe',
          stock: 15,
          price: 135,
          isFeatured: true,
          thumbnail: TImages.productImage1,
          description: 'Green Nike sports shoe',
          brand: BrandModel(id: '1', image: TImages.nikeLogo, name: 'Nike', productsCount: 265, isFeatured: true),
          images: [TImages.productImage1, TImages.productImage23, TImages.productImage21, TImages.productImage9],
          salePrice: 30,
          sku: 'ABR4568',
          categoryId: '1',
          productAttributes: [
            ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
            ProductAttributeModel(name: 'Size', values: ['EU 30', 'EU 32', 'EU 34']),
          ],
          productVariations: [
            ProductVariationModel(id: '1', stock: 34, price: 134, salePrice: 122.6, image: TImages.productImage1,
                description: 'This is a product description for Green Nike sports shoe',
                attributeValues: {'Color':'Green', 'Size':'EU 34'}),
            ProductVariationModel(id: '2', stock: 15, price: 132, image: TImages.productImage23,
                attributeValues: {'Color':'Black', 'Size':'EU 32'}),
            ProductVariationModel(id: '3', stock: 0, price: 234, image: TImages.productImage23,
                attributeValues: {'Color':'Black', 'Size':'EU 34'}),
            ProductVariationModel(id: '4', stock: 222, price: 232, image: TImages.productImage1,
                attributeValues: {'Color':'Green', 'Size':'EU 32'}),
            ProductVariationModel(id: '5', stock: 0, price: 235, image: TImages.productImage21,
                attributeValues: {'Color':'Red', 'Size':'EU 34'}),
            ProductVariationModel(id: '6', stock: 11, price: 230, image: TImages.productImage21,
                attributeValues: {'Color':'Red', 'Size':'EU 32'}),
          ],
          productType: 'ProductType.variable'
      ),
      ProductModel(
          id: '002',
          title: 'Blue T-shirt for all ages',
          stock: 15,
          price: 35,
          isFeatured: true,
          thumbnail: TImages.productImage69,
          description: 'This is a product description for Blue Nike Sleeve less vest.',
          brand: BrandModel(id: '6', image: TImages.zaraLogo, name: 'ZARA'),
          images: [TImages.productImage68, TImages.productImage69, TImages.productImage5],
          salePrice: 30,
          sku: 'ABR4568',
          categoryId: '16',
          productAttributes: [
            ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
            ProductAttributeModel(name: 'Color', values: ['Green', 'Blue', 'Red']),
          ],
          productType: 'ProductType.single'
      ),
      ProductModel(
          id: '003',
          title: 'Leather brown Jacket',
          stock: 15,
          price: 38000,
          isFeatured: false,
          thumbnail: TImages.productImage64,
          description: 'This is a product description for Leather brown Jacket.',
          brand: BrandModel(id: '6', image: TImages.zaraLogo, name: 'ZARA'),
          images: [TImages.productImage64, TImages.productImage65, TImages.productImage66, TImages.productImage67],
          salePrice: 30,
          sku: 'ABR4568',
          categoryId: '17',
          productAttributes: [
            ProductAttributeModel(name: 'Color', values: ['Green', 'Blue', 'Red']),
            ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
          ],
          productType: 'ProductType.single'
      ),
      ProductModel(
          id: '004',
          title: '4 Color collar T-shirt dry fit',
          stock: 15,
          price: 135,
          isFeatured: false,
          thumbnail: TImages.productImage60,
          description: 'This is a product description for 4 Color collar T-shirt dry fit.',
          brand: BrandModel(id: '6', image: TImages.zaraLogo, name: 'ZARA'),
          images: [TImages.productImage60, TImages.productImage61, TImages.productImage62, TImages.productImage63],
          salePrice: 30,
          sku: 'ABR4568',
          categoryId: '16',
          productAttributes: [
            ProductAttributeModel(name: 'Color', values: ['Red', 'Yellow', 'Green', 'Blue']),
            ProductAttributeModel(name: 'Size', values: ['EU30', 'EU32', 'EU34']),
          ],
          productVariations: [
            ProductVariationModel(id: '1', stock: 34, price: 134, salePrice: 122.6, image: TImages.productImage60,
                description: 'This is a product description for 4 Color collar T-shirt dry fit',
                attributeValues: {'Color':'Red', 'Size':'EU 34'}),
            ProductVariationModel(id: '2', stock: 15, price: 132, image: TImages.productImage60,
                attributeValues: {'Color':'Red', 'Size':'EU 32'}),
            ProductVariationModel(id: '3', stock: 0, price: 234, image: TImages.productImage61,
                attributeValues: {'Color':'Yellow', 'Size':'EU 34'}),
            ProductVariationModel(id: '4', stock: 222, price: 232, image: TImages.productImage61,
                attributeValues: {'Color':'Yellow', 'Size':'EU 32'}),
            ProductVariationModel(id: '5', stock: 0, price: 235, image: TImages.productImage62,
                attributeValues: {'Color':'Green', 'Size':'EU 34'}),
            ProductVariationModel(id: '6', stock: 11, price: 232, image: TImages.productImage62,
                attributeValues: {'Color':'Green', 'Size':'EU 30'}),
            ProductVariationModel(id: '7', stock: 0, price: 234, image: TImages.productImage63,
                attributeValues: {'Color':'Blue', 'Size':'EU 30'}),
            ProductVariationModel(id: '8', stock: 11, price: 232, image: TImages.productImage63,
                attributeValues: {'Color':'Blue', 'Size':'EU 34'}),
          ],
          productType: 'ProductType.variable'
      ),

    ///Product after banner
      ProductModel(
          id: '005',
          title: 'Nike Air Jordon Shoes',
          stock: 15,
          price: 35,
          isFeatured: false,
          thumbnail: TImages.productImage10,
          description: 'Nike Air Jordon Shoes for running. Quality product, Long Lasting.',
          brand: BrandModel(id: '1', image: TImages.nikeLogo, name: 'Nike', productsCount: 256, isFeatured: true),
          images: [TImages.productImage7, TImages.productImage8, TImages.productImage9, TImages.productImage10],
          salePrice: 30,
          sku: 'ABR4568',
          categoryId: '8',
          productAttributes: [
            ProductAttributeModel(name: 'Color', values: ['Orange', 'Black', 'Brown']),
            ProductAttributeModel(name: 'Size', values: ['EU30', 'EU32', 'EU34']),
          ],
          productVariations: [
            ProductVariationModel(id: '1', stock: 16, price: 36, salePrice: 12.6, image: TImages.productImage8,
                description: 'This is a product description for Nike Air Jordon Shoes',
                attributeValues: {'Color':'Orange', 'Size':'EU 34'}),
            ProductVariationModel(id: '2', stock: 15, price: 35, image: TImages.productImage7,
                attributeValues: {'Color':'Black', 'Size':'EU 32'}),
            ProductVariationModel(id: '3', stock: 14, price: 34, image: TImages.productImage9,
                attributeValues: {'Color':'Brown', 'Size':'EU 34'}),
            ProductVariationModel(id: '4', stock: 13, price: 33, image: TImages.productImage7,
                attributeValues: {'Color':'Black', 'Size':'EU 32'}),
            ProductVariationModel(id: '5', stock: 12, price: 32, image: TImages.productImage9,
                attributeValues: {'Color':'Brown', 'Size':'EU 32'}),
            ProductVariationModel(id: '6', stock: 11, price: 31, image: TImages.productImage8,
                attributeValues: {'Color':'Orange', 'Size':'EU 30'}),
          ],
          productType: 'ProductType.variable'
      ),
    ProductModel(
        id: '006',
        title: 'SAMSUNG GALAXY S9 (Pink, 64 GB) (4 GB RAM)',
        stock: 15,
        price: 750,
        isFeatured: false,
        thumbnail: TImages.productImage11,
        description: 'SAMSUNG GALAXY S9 (Pink, 64 GB) (4 GB RAM), Long Battery Timing.',
        brand: BrandModel(id: '7', image: TImages.appleLogo, name: 'Samsung'),
        images: [TImages.productImage11, TImages.productImage12, TImages.productImage13, TImages.productImage12],
        salePrice: 650,
        sku: 'ABR4568',
        categoryId: '2',
        productAttributes: [
          ProductAttributeModel(name: 'Color', values: ['Green', 'Blue', 'Red']),
          ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
        ],
        productType: 'ProductType.single'
    ),
    ProductModel(
        id: '007',
        title: 'TOMI Dog Food',
        stock: 15,
        price: 20,
        isFeatured: false,
        thumbnail: TImages.productImage18,
        description: 'This is a product description for TOMI Dog food.',
        brand: BrandModel(id: '7', image: TImages.appleLogo, name: 'Tomi'),
        images: [TImages.productImage11, TImages.productImage12, TImages.productImage13, TImages.productImage12],
        salePrice: 10,
        sku: 'ABR4568',
        categoryId: '4',
        productAttributes: [
          ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
          ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
        ],
        productType: 'ProductType.single'
    ),
    ProductModel(
        id: '009',
        title: 'Nike Air Jordon 19 Blue',
        stock: 15,
        price: 400,
        isFeatured: false,
        thumbnail: TImages.productImage19,
        description: 'This is a product description for Nike Air Jordon.',
        brand: BrandModel(id: '1', image: TImages.nikeLogo, name: 'Nike'),
        images: [TImages.productImage19, TImages.productImage20, TImages.productImage21, TImages.productImage22],
        salePrice: 200,
        sku: 'ABR4568',
        categoryId: '8',
        productAttributes: [
          ProductAttributeModel(name: 'Size', values: ['EU34', 'EU32']),
          ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
        ],
        productType: 'ProductType.single'
    ),
  ];
}