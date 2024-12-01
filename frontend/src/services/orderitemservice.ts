import api from '@/utils/api';

class OrderItemService {
  getListByOrder(params: string) {
    return api.get(`/order_items?`+new URLSearchParams(params));
  }
}

export default new OrderItemService();