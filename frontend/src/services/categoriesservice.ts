import api from '@/utils/api';

class CategoriesService {
  getList() {
    return api.get(`/categories`);
  }
}
// eslint-disable-next-line import/no-anonymous-default-export
export default new CategoriesService();