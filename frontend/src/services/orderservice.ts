import api from '@/utils/api';

class OrderService {
  getList(params: string, page: number) {
    return api.get(`/orders?page=${page}&`+new URLSearchParams(params));
  }
}
// eslint-disable-next-line import/no-anonymous-default-export
export default new OrderService();