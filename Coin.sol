pragma solidity ^0.5.4;

contract Coin {
    // 创建可以从 外部读取的地址变量
    address public minter;
    // 哈希存储当前地址变量 查询账户余额
    mapping (address => uint) public balances;
    
    // 事件消息钩子，等待被调用
    event Sent(address from, address to, uint amount);
    
    // 0.4.22 后的构造函数
    constructor() public {
        minter = msg.sender;
    }
    
    // 铸币
    function mint(address receiver, uint amount) public {
        if(msg.sender != minter) return;
        balances[receiver] += amount;
    }
    
    // 交易
    function send(address receiver, uint amount) public {
        if(balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}