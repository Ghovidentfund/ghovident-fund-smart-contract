// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../interfaces/IGhovidentFund.sol";
import "../interfaces/IERC20WithPermit.sol";

contract Fund is IGhovidentFund {
    // TODO: whilte list pool
    function supply(
        address assets,
        address spender,
        uint256 amount
    ) external override {
        IERC20WithPermit(assets).transferFrom(spender, address(this), amount);
    }

    function withdraw(
        address assets,
        address receiver,
        uint256 amount
    ) external override {
        IERC20WithPermit(assets).transfer(receiver, amount);
    }
}
