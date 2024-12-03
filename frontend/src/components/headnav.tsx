import {
  Avatar,
  Navbar,
  NavbarBrand,
  NavbarCollapse,
  NavbarLink,
  NavbarToggle
} from 'flowbite-react';

export default function HeadNav() {
  return (
    <div className="shadow-md bg-white">
    <div className="container mx-auto p-1">
    <Navbar fluid>
      <NavbarBrand href="#">
        <img src="/favicon.svg" className="mr-3 h-6 sm:h-9" alt="Logo" />
        <span className="self-center whitespace-nowrap text-xl font-semibold dark:text-white">Apps</span>
      </NavbarBrand>
      <div className="flex md:order-2">
      <Avatar alt="User settings" img="/next.svg" rounded bordered color="blue" status="online" statusPosition="top-right">
        <div className="font-medium dark:text-white">
          <p className="text-sm font-medium">@users</p>
        </div>
      </Avatar>
      <NavbarToggle className="ml-2"/>
      </div>
      <NavbarCollapse>
        <NavbarLink href="/" className="font-semibold">
          Home
        </NavbarLink>
        <NavbarLink href="/product" className="font-semibold">Product</NavbarLink>
        <NavbarLink href="/order" className="font-semibold">Order</NavbarLink>
      </NavbarCollapse>
    </Navbar>
    </div>
    </div>
  );
}