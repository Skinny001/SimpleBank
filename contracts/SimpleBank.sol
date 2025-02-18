// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract SimpleBank {
    bool private locked;
    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint amount);
    event withdrawn(address indexed user, uint amount);
    
    modifier noReentrancy() {
        require(!locked, 'Contract is locked');
        locked = true;
        _;
        locked = false;
    }
    function deposit() public payable {
        require(msg.sender != address(this), 'Address is not valid');
        require(msg.value > 0, 'should deposit funds');

        // update the users balance 
        balances[msg.sender] += msg.value;

        // Emit the deposit event
        emit Deposited(msg.sender, msg.value);
        
    }

    function withdraw(uint amount) public noReentrancy {
        require(balances[msg.sender] >= amount, 'Not enough balance to withdraw');
        //update the users after they withdraw
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        // Emit the withdraw event
        emit withdrawn(msg.sender, amount);
        
    }

    function getBalance() public view returns(uint) {
        return balances[msg.sender];
    }


}
