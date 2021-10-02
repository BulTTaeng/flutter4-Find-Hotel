
import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts() {
    const allProducts = <Product> [
      Product(
        id: 0,
        isFeatured: true,
        name: 'Vagabond hotel',
        location: 'at yangduct',
        star: 3,
        phone: '010 00000',
        explain: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',

      ),
      Product(
        id: 1,
        isFeatured: true,
        name: 'Stella hotel',
        location: 'newtonhall',
        star: 3,
          phone: '010 11111111111',
        explain: 'bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb',
      ),
      Product(
        id: 2,
        isFeatured: false,
        name: 'Whitney hotel',
        location: 'Gwangju',
        star: 4,
        phone: '010 222222222',
        explain: 'ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc',
      ),
      Product(
        id: 3,
        isFeatured: true,
        name: 'Garden hotel',
        location: 'Seoul',
        star: 2,
        phone: '010 33333333333',
        explain: 'dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd',
      ),
      Product(
        id: 4,
        isFeatured: false,
        name: 'Strut hotel',
        location: 'Seoul gangnan 162-132 \n samsung building',
        star: 5,
        phone: '010 4444444444',
        explain: 'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
      ),
      Product(
        id: 5,
        isFeatured: false,
        name: 'Varsity hotel',
        location: 'Busan',
        star: 3,
        phone: '010 55555555555',
        explain: 'fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
      ),

    ];

      return allProducts;
  }
}
