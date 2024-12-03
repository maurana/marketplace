"use client"

import { useState, useEffect, useRef } from "react";
import {
  Pagination, Card, Modal, Table, TableBody, TableCell, 
  TableHead, TableHeadCell, TableRow, Select, TextInput, Button,
} from "flowbite-react";
import { MdAnnouncement } from 'react-icons/md';
import { RiUserSearchLine } from "react-icons/ri";
import { HiCubeTransparent } from "react-icons/hi";
import HeadNav from "@/components/headnav";
import OrderService from '@/services/orderservice';
import OrderItemService from "@/services/orderitemservice";

interface ITypeOrder {
  orders_id: number,
  customer_name: string,
  customer_email: string,
  total_item: number,
  total_price: number,
  orders_date: string
}

interface ITypeOrderItem {
  item_id: number,
  products_name: string,
  item_stock: number,
  item_price: number
}

export default function Page() {
  const [Rows, setRows] = useState({rows: 10});
  const rows = useRef<HTMLSelectElement>(null);

  const [Keywords, setKeywords] = useState('');
  const [Order, setOrder] = useState([]);
  const [OrderItem, setOrderItem] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPage, setTotalPage] = useState(0);
  const [openModal, setOpenModal] = useState(false);
  const [modalPlacement] = useState('top-center')

  const onPageChange = async (page: number) => {
    const params: string = `rows=${Rows.rows}&keywords=${Keywords}`;
    await OrderService.getList(params, page)
            .then(res => {
              setCurrentPage(page);
              setOrder(res.data.data.rows)
              setTotalPage(res.data.data.total_page)
            })
            .catch(e =>  console.log(e));
  }

  const debounce = (onChange: ReturnType<typeof Function>) => {
    let timeout: ReturnType<typeof setTimeout>;
    return (e: React.FormEvent<HTMLInputElement> | React.ChangeEvent<HTMLSelectElement>) => {
      const val: string = e.currentTarget.value;
      clearTimeout(timeout);
      timeout = setTimeout(() => {
        onChange(val);
      }, 0);
    };
  };

  const handleSearch = async (val: string, name: string) => {
    let params: string = '';
    try {
      switch(name) {
        case 'keywords': {
          params = `rows=${Rows.rows}&keywords=${val}`
          break;
        }
        case 'rows': {
          val = val.trim();
          params = `rows=${val}&keywords=${Keywords}`
          break;
        }
      }

      await OrderService.getList(params, currentPage)
              .then(res => {
                setOrder(res.data.data.rows)
                setTotalPage(res.data.data.total_page)
                if (name == 'rows') setRows({ ...Rows, [name as string]: val})
                else setKeywords(val)
              })
              .catch(e =>  console.log(e));
    } catch (error: unknown) {
      console.error("Error fetching data:", error);
    }
  }
  
  const oList = async () => {
    const params: string = `rows=${Rows.rows}&keywords=${Keywords}`;
    await OrderService.getList(params, currentPage)
            .then(res => {
              setOrder(res.data.data.rows)
              setTotalPage(res.data.data.total_page)
            })
            .catch(e =>  console.log(e));
  }

  const oiList = async (id: number) => {
    const params: string = `orders=${id}`;
    await OrderItemService.getListByOrder(params)
            .then(res => setOrderItem(res.data.data))
            .catch(e => console.log(e));
  }

  useEffect(() => {
    if (Object.keys(Order).length < 1 && Keywords.length == 0) oList()
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [Keywords, Rows, currentPage, Order])

  const onListModal = (orders_id: number) => {
    setOpenModal(true)
    oiList(orders_id)
  }

    return (
      <main>
        <HeadNav />
        <div className="container mx-auto p-1 mt-4">
        <Card className="w-full">
          <div className="max-w-sm inline-flex gap-2">
            <span>
              <TextInput onChange={debounce((e: string) => handleSearch(e, 'keywords'))} value={Keywords} id="keywords" name="keywords" type="text" icon={RiUserSearchLine} placeholder="search.." />
            </span>
            <span>
              <Select ref={rows} onChange={debounce((e: string) => handleSearch(e, 'rows'))} value={Rows.rows} id="rows" className="w-20" name="rows">
                <option value={2}>2</option>
                <option value={5}>5</option>
                <option value={10}>10</option>
              </Select>
            </span>
          </div>
          <div className="overflow-x-auto">
            <Table hoverable>
              <TableHead>
                <TableHeadCell>NO</TableHeadCell>
                <TableHeadCell>Customer name</TableHeadCell>
                <TableHeadCell>Customer email</TableHeadCell>
                <TableHeadCell>Total Item</TableHeadCell>
                <TableHeadCell>Total Price</TableHeadCell>
                <TableHeadCell>Date</TableHeadCell>
                <TableHeadCell>Action</TableHeadCell>
              </TableHead>
              <TableBody className="divide-y">
                { Order.length > 0 ? Array.from(Order).map((val: ITypeOrder, idx: number) => {
                  return (
                    <TableRow key={idx+1} className="bg-white dark:border-gray-700 dark:bg-gray-800">
                    <TableCell>{idx+1}</TableCell>
                    <TableCell className="whitespace-nowrap font-medium text-gray-900 dark:text-white">
                      {val.customer_name}
                    </TableCell>
                    <TableCell>{val.customer_email}</TableCell>
                    <TableCell>{val.total_item}</TableCell>
                    <TableCell>Rp {val.total_price.toFixed(2)}</TableCell>
                    <TableCell>{val.orders_date}</TableCell>
                    <TableCell>
                      <Button size="sm" gradientMonochrome="info" onClick={() => onListModal(val.orders_id)}>
                        <HiCubeTransparent className="mr-2 h-5 w-5" />
                        Item Detail
                      </Button>
                    </TableCell>
                  </TableRow>
                  )
                }):  
                <TableRow className="text-center bg-white dark:border-gray-700 dark:bg-gray-800">
                <TableCell colSpan={7} rowSpan={1}>
                  <div className="flex w-full justify-between mt-5">
                  <div className="mx-auto flex items-center">
                    <p className="flex items-center text-sm font-normal text-gray-500 dark:text-gray-400">
                      <MdAnnouncement className="mr-4 h-4 w-4" />
                      <span className="[&_p]:inline">
                        NO DATA ORDERS
                      </span>
                    </p>
                  </div>
                </div>
                </TableCell>
                </TableRow> }
              </TableBody> 
            </Table>
          </div>
          <div className="flex overflow-x-auto sm:justify-center">
            <Pagination currentPage={currentPage} totalPages={totalPage} onPageChange={onPageChange} showIcons />
          </div>
        </Card>

        <Modal
          show={openModal}
          position={modalPlacement}
          onClose={() => setOpenModal(false)}
        >
          <Modal.Header>Item Detail</Modal.Header>
          <Modal.Body>
          <div className="overflow-x-auto">
            <Table hoverable>
              <TableHead>
                <TableHeadCell>NO</TableHeadCell>
                <TableHeadCell>Product</TableHeadCell>
                <TableHeadCell>Price</TableHeadCell>
                <TableHeadCell>Stock</TableHeadCell>
              </TableHead>
              <TableBody className="divide-y">
              { OrderItem.length > 0 ? Array.from(OrderItem).map((val: ITypeOrderItem, idx: number) => {
                  return (
                    <TableRow key={idx+1} className="bg-white dark:border-gray-700 dark:bg-gray-800">
                      <TableCell>{idx+1}</TableCell>
                      <TableCell>{val.products_name}</TableCell>
                      <TableCell>{val.item_price.toFixed(2)}</TableCell>
                      <TableCell>{val.item_stock}</TableCell>
                    </TableRow>
                  )
                }): null }
              </TableBody>
            </Table>
          </div>
          </Modal.Body>
        </Modal>
        </div>
      </main>
    );
}