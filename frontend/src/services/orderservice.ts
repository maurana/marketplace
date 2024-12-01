import api from '@/utils/api';

class OrderService {
  getList(params: string, page: number) {
    return api.get(`/orders?page=${page}&`+new URLSearchParams(params));
  }
}

export default new OrderService();