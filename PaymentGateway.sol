// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PaymentGateway is Ownable {
    event PaymentSent(address indexed customer, uint256 amount, uint256 indexed paymentId, address token);

    constructor() Ownable(msg.sender) {}

    /**
     * @dev Process native gas token payments (ETH/BNB/MATIC).
     */
    function payNative(uint256 _paymentId) external payable {
        require(msg.value > 0, "Amount must be > 0");
        emit PaymentSent(msg.sender, msg.value, _paymentId, address(0));
    }

    /**
     * @dev Process ERC20 stablecoin payments.
     */
    function payToken(address _token, uint256 _amount, uint256 _paymentId) external {
        IERC20 token = IERC20(_token);
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        emit PaymentSent(msg.sender, _amount, _paymentId, _token);
    }

    function withdraw(address _to) external onlyOwner {
        payable(_to).transfer(address(this).balance);
    }

    function withdrawToken(address _token, address _to) external onlyOwner {
        IERC20(_token).transfer(_to, IERC20(_token).balanceOf(address(this)));
    }
}
