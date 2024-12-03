"use client"

import { useState, useEffect, useCallback, useRef} from 'react';
import { Button, TextInput, Select, Card } from 'flowbite-react';
import { HiOutlineSearchCircle, HiArrowRight } from 'react-icons/hi';
import { MdAnnouncement } from 'react-icons/md';
import HeadNav from '@/components/headnav';
import ProductService from '@/services/productservice';
import CategoriesService from '@/services/categoriesservice';

interface ITypeCategories {
  categories_id: number,
  categories_name: string
}

interface ITypeProduct {
  products_id: number,
  products_name: string,
  products_image: string,
  products_price: number,
  products_stock: number,
  categories_name: string
}

export default function Page() {
  const [Keywords, setKeywords] = useState('');
  const [KeyCategories, setKeyCategories] = useState({categories: ''});
  const keycategories = useRef<HTMLSelectElement>(null);

  const [Pages] = useState(1);
  const [Rows] = useState(1000);
  const [Product, setProduct] = useState([]);
  const [Categories, setCategories] = useState([]);

  const pList = async () => {
    const params:string=`rows=${Rows}&keywords=${Keywords}&categories=${KeyCategories.categories}`;
    await ProductService.getList(params, Pages)
            .then(res => setProduct(res.data.data.rows))
            .catch(e => console.log(e));
  }

  const cList = async () => {
    await CategoriesService.getList()
            .then(res => setCategories(res.data.data))
            .catch(e =>  console.log(e));
  }

  const handleInputChange = useCallback((e: React.FormEvent<HTMLInputElement>) => {
    setKeywords(e.currentTarget.value);
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [Keywords]);

  const handleSelectChange = useCallback((e: React.ChangeEvent<HTMLSelectElement>) => {
    setKeyCategories({ ...KeyCategories, [e.target.name]: e.target.value.trim() });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [KeyCategories]);

  const handleClick = useCallback(() => {
    pList()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [Keywords, KeyCategories]);

  useEffect(() => {
    if (Object.keys(Product).length < 1 && Keywords.length == 0 && KeyCategories.categories == '') pList();
    if (Object.keys(Categories).length < 1) cList();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [Keywords, Categories, Rows, Product, Categories])

    return (
      <main>
        <HeadNav />
        <div className="container mx-auto">
          <div className="flex w-full items-center mt-4 mb-4 justify-between border-b border-gray-200 bg-white p-4 dark:border-gray-600 dark:bg-gray-700">
            <div className="mx-auto inline w-full shrink-0 items-center sm:w-auto">
              <div className="flex w-full flex-col items-center md:flex-row md:gap-x-2">
                <TextInput onChange={handleInputChange} id="keywords" type="text" icon={HiOutlineSearchCircle} placeholder="search products.." name="keywords" />
                <Select ref={keycategories} onChange={handleSelectChange} id="categories" name="categories" value={KeyCategories.categories}>
                  <option value={''}>product categories</option>
                  {Categories != null ? Array.from(Categories).map((val: ITypeCategories, idx: number) => {
                    return (
                      <option key={idx} value={val.categories_name}>{val.categories_name}</option>
                  )}) : null}
                </Select>
                <Button onClick={handleClick} gradientMonochrome="info" > 
                  Search &nbsp;
                  <HiArrowRight className="mr-2 h-5 w-5" />
                </Button>
              </div>
            </div>
          </div>
          {Product.length > 0 ? 
            <div className="grid grid-cols-1 md:grid-cols-5 sm:grid-cols-2 gap-1">
              { Array.from(Product).map((val: ITypeProduct, idx: number) => {
                return (
                  <Card
                    className="max-w-sm mb-2"
                    imgAlt="Apple Watch Series 7"
                    imgSrc={"http://localhost:8000/storage/"+val.products_image}
                    key={idx}
                  >
                    <a href="#">
                      <h5 className="text-md font-semibold tracking-tight text-gray-900 dark:text-white">
                        {val.products_name}
                      </h5>
                    </a>
                    <div className="flex items-center -mt-3">
                      <p className="text-sm text-muted">{val.categories_name}</p>
                    </div>
                    <div className="flex items-center justify-between">
                      <p className="text-sm text-gray-700 font-medium">{val.products_stock}</p>
                      <p className="text-sm text-sky-700 font-bold">Rp {val.products_price}</p>
                    </div>
                  </Card>
                )})}
             </div> : 
             <div className="flex w-full justify-between p-4 mt-32">
              <div className="mx-auto flex items-center">
                <p className="flex items-center text-sm font-normal text-gray-500 dark:text-gray-400">
                  <MdAnnouncement className="mr-4 h-4 w-4" />
                  <span className="[&_p]:inline">
                    NO DATA PRODUCTS
                  </span>
                </p>
              </div>
            </div> }
        </div>
      </main>
    );
}