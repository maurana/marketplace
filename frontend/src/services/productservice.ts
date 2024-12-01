import api from '@/utils/api'

class ProductService {
  getList(params: string, page: number) {
    return api.get(`/products?page=${page}&`+new URLSearchParams(params));
  }

  getShow(id: number) {
    return api.get(`/products/${id}`);
  }
}

export default new ProductService();