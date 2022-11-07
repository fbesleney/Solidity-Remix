// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract _Order {

    struct Order {
        address customer;
        string name;
        bool completed;
        uint created;
    }
    Order[] public orders;

    event OrderCreated(uint256 orderId, address indexed consumer, uint indexed createdTime);
    event OrderCompleted(uint256 orderId, address indexed consumer,uint indexed updatedTime);

    function createOrder(string memory name)  external returns(uint256) {
        Order memory order;
        order.customer = msg.sender;
        order.name = name;
        order.completed=false;
        orders.push(order);
        
        emit OrderCreated(orders.length - 1, msg.sender,block.timestamp);

        return orders.length - 1;
    }

    function updateOrder(uint index ) public {
        Order storage order = orders[index];
        require(order.completed == false, "Order is already shipped.");
        order.completed=true;

        emit OrderCompleted(index, order.customer,  block.timestamp);
    }

} 



