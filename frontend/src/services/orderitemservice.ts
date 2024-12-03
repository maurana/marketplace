import api from '@/utils/api';

class OrderItemService {
  getListByOrder(params: string) {
    return api.get(`/order_items?`+new URLSearchParams(params));
  }
}
// eslint-disable-next-line import/no-anonymous-default-export
export default new OrderItemService();