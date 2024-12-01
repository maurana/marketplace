import api from '@/utils/api';

class CategoriesService {
  getList() {
    return api.get(`/categories`);
  }
}

export default new CategoriesService();